param (
    [System.Collections.Generic.List[String]] $Targets = $null
)

Clear-Host
$tgts = New-Object "System.Collections.Generic.List[String]"

if($Targets -ne $null) { 
    Write-Debug "Targets is not null."
    $tgts = $Targets 
}

if($tgts.Count -eq 0) {
    Write-Debug "Populating tgts"
    $tgts.Add("x64")
    $tgts.Add("C")
    $tgts.Add("CSharp")
    $tgts.Add("CSharpExpressions")
    $tgts.Add("CSharpIL")
    $tgts.Add("FSharp")
    $tgts.Add("Java")
    $tgts.Add("JavaScript")
    $tgts.Add("Python3")
}

$directory = Get-Location
$root = $directory.Path

& $directory\Write-OutputFile.ps1

$referenceHash = (Get-FileHash $directory\FizzBuzz.txt).Hash;
$failed = New-Object "System.Collections.Generic.List[String]"
$passed = New-Object "System.Collections.Generic.List[String]"
$wslCommand = "wsl"
$vcCommand = "cl"
$dotnetCommand = "dotnet"
$javaCommand = "javac"
$nodeCommand = "npm"
$pythonCommand = "python"

function Execute-FizzBuzz {
    param (
        $location = "\src"
        , $buildCommand = ""
        , $buildCommandParameters = ""
        , $buildCommandParametersArray = @()
        , $executeCommand = ""
        , $executeCommandParameters = ""
        , $executeCommandParametersArray = @()
        , $nameShort = ""
        , $nameLong = ""
        , $preBuild = ""
        , [System.Collections.Generic.List[String]] $fail
        , [System.Collections.Generic.List[String]] $pass
        , [System.Collections.Generic.List[String]] $targets
    )

    process {
        if($root -eq $null) { $root = "" }
        if($location -eq $null) { $location = "" }
        if($buildCommand -eq $null) { $buildCommand = "" }
        if($buildCommandParameters -eq $null) { $buildCommandParameters = "" }
        if($buildCommandParametersArray -eq $null) { $buildCommandParametersArray = @( "" ) }
        if($executeCommand -eq $null) { $executeCommand = "" }
        if($executeCommandParameters -eq $null) { $executeCommandParameters = "" }
        if($executeCommandParametersArray -eq $null) { $executeCommandParametersArray = @( "" ) }
        if($nameShort -eq $null) { $nameShort = "" }
        if($nameLong -eq $null) { $nameLong = "" }
        if($preBuild -eq $null) { $preBuild = "" }

        Write-Host "Looking for [$nameShort]"
        Write-Debug $root
        Write-Debug $location
        Write-Debug $buildCommand
        Write-Debug $buildCommandParameters
        Write-Debug $executeCommand
        Write-Debug $executeCommandParameters
        Write-Debug $nameShort
        Write-Debug $nameLong
        Write-Debug $preBuild

        $isTarget = $targets | Where-Object { $nameShort -ilike $_ }
        $found = Get-Command $buildCommand -errorAction SilentlyContinue

        Write-Debug "[$isTarget]"
        if ($isTarget -and $found) {        
            Write-Debug "$buildCommand exists"

            Write-Debug "Building $nameLong in $location"

            Join-Path $root -ChildPath $location | Set-Location
            $wd = Get-Location

            if($preBuild) {
                & $preBuild
            }

            Write-Host "$buildCommand $buildCommandParameters $buildCommandParametersArray"
            & $buildCommand $buildCommandParameters $buildCommandParametersArray

            if($LASTEXITCODE -eq 0){
                Write-Host "Executing $executeCommand $executeCommandParameters in $location"

                $outputFilename = Join-Path $root -ChildPath "FizzBuzz.$nameShort.txt"

                & $executeCommand $executeCommandParameters > $outputFilename

                if (-not($referenceHash -eq ((Get-FileHash $outputFilename).Hash))) {
                    Write-Host "Incorrect hash on output for $nameLong implementation. :("
                    $fail.Add($wd)
                }
                else {
                    Write-Debug "$nameLong passed!"
                    $pass.Add($wd)
                }
            } else {
                Write-Host "Error compiling $nameLong program."        
            }        
        }
    }
}

function ExecuteNoBuild-FizzBuzz {
    param (
        $location = "\src"
        , $command = ""
        , $commandParameters = ""
        , $nameShort = ""
        , $nameLong = ""
        , $preExecute = ""
        , [System.Collections.Generic.List[String]] $fail
        , [System.Collections.Generic.List[String]] $pass
        , [System.Collections.Generic.List[String]] $targets
    )

    process {
        if($root -eq $null) { $root = "" }
        if($location -eq $null) { $location = "" }
        if($command -eq $null) { $command = "" }
        if($commandParameters -eq $null) { $commandParameters = "" }
        if($nameShort -eq $null) { $nameShort = "" }
        if($nameLong -eq $null) { $nameLong = "" }
        if($preExecute -eq $null) { $preExecute = "" }

        Write-Host "Looking for [$nameShort]"
        Write-Debug $root
        Write-Debug $location
        Write-Debug $command
        Write-Debug $commandParameters
        Write-Debug $nameShort
        Write-Debug $nameLong
        Write-Debug $preExecute

        $isTarget = $targets | Where-Object { $nameShort -ilike $_ }
        Write-Debug "[$isTarget]"
        $found = Get-Command $command -errorAction SilentlyContinue

        if ($isTarget -and $found) {        
            Write-Debug "$command exists"

            Join-Path $root -ChildPath $location | Set-Location
            $wd = Get-Location

            if($preExecute -ne "") {
                & $preExecute
            }

            Write-Host "Executing $command $commandParameters in $location"

            $outputFilename = Join-Path $root -ChildPath "FizzBuzz.$nameShort.txt"
            
            & $command $commandParameters > $outputFilename

            if (-not($referenceHash -eq ((Get-FileHash $outputFilename).Hash))) {
                Write-Host "Incorrect hash on output for $nameLong implementation. :("
                $fail.Add($wd)
            }
            else {
                Write-Debug "$nameLong passed!"
                $pass.Add($wd)
            }
        }
    }
}

$tests = Get-ChildItem test.json -Recurse

$tests | ForEach-Object -Process {
    Write-Host "Testing $_"
    $test = (Get-Content $_ | Out-String | ConvertFrom-Json)

    Execute-FizzBuzz -location $test.location `
        -buildCommand $test.buildCommand `
        -buildCommandParameters $test.buildCommandParameters `
        -buildCommandParametersArray $test.buildCommandParametersArray `
        -executeCommand $test.executeCommand `
        -executeCommandParameters $test.executeCommandParameters `
        -executeCommandParametersArray $test.executeCommandParametersArray `
        -nameShort $test.nameShort `
        -nameLong $test.nameLong `
        -preBuild $test.preBuild `
        -fail $failed `
        -pass $passed `
        -targets $tgts
}

Set-Location $directory

$tests = Get-ChildItem test_nobuild.json -Recurse

$tests | ForEach-Object -Process {
    Write-Host "Testing $_"
    $test = (Get-Content $_ | Out-String | ConvertFrom-Json)

    ExecuteNoBuild-FizzBuzz -location $test.location `
        -command $test.command `
        -commandParameters $test.commandParameters `
        -nameShort $test.nameShort `
        -nameLong $test.nameLong `
        -preExecute $test.preExecute `
        -fail $failed `
        -pass $passed `
        -targets $tgts
}

Set-Location $directory

Write-Host ""
Write-Host "Results"

if ($failed.Count -gt 0) {
    Write-Host "Failed:"
    $failed | ForEach-Object -Process {
        Write-Host $_
    }
}

if ($passed.Count -gt 0) {
    Write-Host "Passed:"
    $passed | ForEach-Object -Process {
        Write-Host $_
    }
}
