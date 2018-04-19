## Задание на работу

### a
Написать предикат, вычисляющий n-е число Фибоначчи.
### b
Написать предикат, определяющий, являются ли его аргументы взаимно
простыми числами. Взаимно простыми называются числа, наибольший
общий делитель которых равен единице.
### c
Написать предикат, реализующий функцию Эйлера. Функция Эйлера ph (m)
определяет количество чисел r, взаимно простых с m (1 <= r <=m).
Например, при m =10, r = 1, 3, 7, 9. Т.о. phi(10) = 4.
### d
Гипотеза Гольдбаха утверждает, что любое положительное целое может
быть представлено в виде суммы двух простых чисел, например 28 = 5 + 23.
Написать предикат goldbach(N, X1, X2), который находит два простых числа
X1 и X2, сумма которых равна заданному целому N.
### e
Написать предикат, определяющий n-й элемент списка.
### f
Написать предикат, дублирующий его элементы заданное число раз.
Например, dups([a, b, c], 2). Результат - [a,a,b,b,c,c,]
### g
Написать предикат split(Middle, L, L1, L2). Аргумент Middle
является компаратором, L – исходный список, L1 и L2 – подсписки,
элементы которых меньше и больше Middle соответственно.
### h
Написать предикат, который строит список всех множителей заданного
положительного числа.
### i
Написать предикат, который определяет пересечение двух множеств,
заданных списками.
### j
Написать предикат adjacent(X,Y,Zs), который заканчивается
успехом, если X и Y - смежные елементы списка Z.
