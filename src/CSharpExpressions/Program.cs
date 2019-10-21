#nullable enable

using System.Linq.Expressions;
using System.Linq;
using System;

using static System.Console;
using static System.Linq.Enumerable;

namespace CSharpExpressions
{
    class Program
    {
        static Expression<Func<int, string?>> ByThree = 
            (i) => i % 3 == 0 ? "Fizz" : null;

        static Expression<Func<int, string?>> ByFive = 
            (i) => i % 5 == 0 ? "Buzz" : null;

        static Expression<Func<int, string?>> ByThreeAndFive = 
            (i) => i % 5 == 0 && i % 3 == 0 ? "FizzBuzz" : null;

        static Expression<Func<int, string>> Other = (i) => $"{i}";

        static void Main(string[] args)
        {
            var by3and5 = ByThreeAndFive.Compile();
            var by5 = ByFive.Compile();
            var by3 = ByThree.Compile();
            var other = Other.Compile();

            Range(1, 100).ToList().ForEach(i =>
                WriteLine(by3and5(i) ?? by5(i) ?? by3(i) ?? other(i))
            );
        }
    }
}
