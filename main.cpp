#include <iostream>
#include "functions.h"

using namespace std;

int main() {
    int num;
    cout << "Введите число для вычисления факториала: ";
    cin >> num;

    if (num < 0) {
        cout << "Ошибка: факториал определён только для неотрицательных чисел!" << endl;
    } else {
        cout << "Факториал " << num << " = " << factorial(num) << endl;
    }

    return 0;
}
