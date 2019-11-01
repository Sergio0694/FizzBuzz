#include <iostream>

int main()
{

    for (int i = 1; i <= 100; i++)
    {
        int displayNumber = 1;
        if(i % 3 == 0) {
            std::cout << "Fizz";
            displayNumber = 0;
        }
        if(i % 5 == 0){
            std::cout << "Buzz";
            displayNumber = 0;
        }
        if(displayNumber){
            std::cout << i;
        }
        std::cout << "\n";
    }
}
