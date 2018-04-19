% -*- mode: prolog -*-

%%% a - Fibonacci numbers

fib(0, 0).
fib(1, 1).
fib(N, X):- M is N - 1,
            fib_(0, 1, M, X),
            !.
fib_(_, B, 0, B).
fib_(A, B, N, X):- C is A + B,
                   M is N - 1,
                   fib_(B, C, M, X).

%%% b - Mutually prime numbers

% greatest common divisor, Euclid's algorithm
gcd(X, X, X).
gcd(X, Y, D):- X < Y,
               Z is Y - X,
               gcd(X, Z, D),
               !.
gcd(X, Y, D):- Y < X,
               Z is X - Y,
               gcd(Z, Y, D),
               !.

mut_prime(X, Y):- gcd(X, Y, D),
                  D = 1,
                  !.

%%% c - Euler's totient function
% (N is the amount of mutually prime numbers to X that are < X)

phi(X, N):- phi_(1, 0, X, N),
            !.
phi_(X, I, X, I).
phi_(CX, I, X, N):- mut_prime(CX, X),
                    J is I + 1,
                    Y is CX + 1,
                    phi_(Y, J, X, N)
                    ;
                    Y is CX + 1,
                    phi_(Y, I, X, N).

%%% d - Goldbach's conjecture predicate (A, B - primes, A + B = X)

% goldbach(X, A, B):- TODO

%%% e - Nth element of a list

nth(0, [X|_], X).
nth(N, [_|T], X):- M is N - 1,
                   nth(M, T, X),
                   !.

%%% f - Duplicate all the elements N times

n_xs(1, X, [X]).
n_xs(N, X, L):- M is N - 1,
                n_xs(M, X, LT),
                L = [X|LT],
                !.

dups(_, [], []):- !.
dups(N, [H|T], LR):- dups(N, T, L2),
                     n_xs(N, H, L1),
                     conc(L1, L2, LR),
                     !.

%%% g
% M - Middle, L1 - list of numbers from [H|T] that are less then M,
% L2 - numbers from [H|T] that are greater then M

split(_, [], [], []).
split(M, [H|T], L1, L2):- split(M, T, L11, L22),
                          split_(M, H, L1, L11, L2, L22),
                          !.
split_(M, X, L1, L11, L2, L22):- X < M,
                                 L1 = [X|L11],
                                 L2 = L22
                                 ;
                                 X > M,
                                 L2 = [X|L22],
                                 L1 = L11
                                 ;
                                 L1 = L11,
                                 L2 = L22.

%%% h

%%% i

%%% j


%%% other

% factorial

fact(0, 1).
fact(N, X):- N > 0,
             M is N - 1,
             fact(M, Y),
             X is Y * N,
             !.

% member

member(X, [X|_]).
member(X, [_|T]):- member(X, T),
                   !.

% concatenate L1 and L2 into L3

conc([], L, L).
conc([H|T], L2, L3):- conc(T, L2, LT),
                      L3 = [H|LT].

% add

add_front(X, L, [X|L]).

add_back(X, [], LR):- LR = [X].
add_back(X, [H|T], LR):- add_back(X, T, LR_),
                         LR = [H|LR_],
                         !.

% del X

del(X, [X|T], T).
del(X, [Y|T], [Y|TR]):- del(X, T, TR),
                        !.

% del Nth

del_nth(N, L, LR):- del_nth_(N, L, LR, 0).
del_nth_(I, [_|T], LR, I):- LR = T,
                            !.
del_nth_(N, [H|T], [H|TR], I):- J is I + 1,
                                del_nth_(N, T, TR, J),
                                !.
