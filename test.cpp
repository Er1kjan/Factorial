#include <iostream>
#include "functions.h"
#include <cassert>

void test_factorial() {
    std::cout << "Тест факториала 0: " << factorial(0) << std::endl;
    assert(factorial(0) == 1);
    assert(factorial(1) == 1);
    assert(factorial(5) == 120);
    assert(factorial(6) == 720);
    std::cout << "Все тесты пройдены!\n";
}

int main() {
    test_factorial();
    return 0;
}
