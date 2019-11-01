Imports System

Namespace FizzBuzz
    Module Program
        Sub Main()
            For i = 1 To 100
                Dim textToPrint as String = ""
                Dim printNumber As Boolean = True
                If i Mod 3 = 0 Then
                    textToPrint = "Fizz"
                    printNumber = False
                End If
                If i Mod 5 = 0 Then
                    textToPrint += "Buzz"
                    printNumber = False
                End If
                If printNumber Then
                    textToPrint = i
                End If
                Console.WriteLine(textToPrint)
            Next
        End Sub
    End Module
End Namespace
