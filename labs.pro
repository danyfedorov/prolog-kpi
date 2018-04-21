% -*- mode: prolog -*-

%%% a - Fibonacci numbers

fib(0, 0).
fib(1, 1).
fib(N, X):- M is N - 1,
            fib_(0, 1, M, X).
fib_(_, B, 0, B).
fib_(A, B, N, X):- C is A + B,
                   M is N - 1,
                   fib_(B, C, M, X).

%%% b - Mutually prime numbers

% greatest common divisor, Euclid's algorithm
gcd(X, X, X).
gcd(X, Y, D):- X < Y,
               Z is Y - X,
               gcd(X, Z, D).
gcd(X, Y, D):- Y < X,
               Z is X - Y,
               gcd(Z, Y, D).

mut_prime(X, Y):- gcd(X, Y, D),
                  D = 1.

%%% c - Euler's totient function
% (N is the amount of mutually prime numbers to X that are < X)

phi(X, N):- phi_(1, 0, X, N).
phi_(X, I, X, I).
phi_(CX, I, X, N):- mut_prime(CX, X),
                    J is I + 1,
                    Y is CX + 1,
                    phi_(Y, J, X, N)
                    ;
                    Y is CX + 1,
                    phi_(Y, I, X, N).

%%% d - Goldbach's conjecture (A, B - primes, A + B = X)

%% goldbach(X, A, B):- HALF is div(X, 2),
%%                     print("0 "), print(HALF), nl,
%%                     goldbach_(X, A, B, 1, HALF).
%% goldbach_(_, _, _, LIM, LIM).
%% goldbach_(X, A, B, I, LIM):- prime_factors(I, L1),
%%                              print(L1), nl,
%%                              length(L1, L1L),
%%                              L1L = 0,
%%                              K is X - I,
%%                              prime_factors(K, L2),
%%                              print(L2), nl,
%%                              length(L2, L2L),
%%                              L2L = 0,
%%                              nth0(0, L2, _),
%%                              print("3 "), print(I), nl,
%%                              A is I,
%%                              B is K
%%                              ;
%%                              J is I + 1,
%%                              goldbach_(X, A, B, J, LIM).

%%% e - Nth element of a list

nth(0, [X|_], X).
nth(N, [_|T], X):- M is N - 1,
                   nth(M, T, X).

%%% f - Duplicate all the elements N times

n_xs(1, X, [X]).
n_xs(N, X, L):- M is N - 1,
                n_xs(M, X, LT),
                L = [X|LT].

dups(_, [], []).
dups(N, [H|T], LR):- dups(N, T, L2),
                     n_xs(N, H, L1),
                     conc(L1, L2, LR).

%%% g
% args:
%  M - Middle,
%  L - list with numbers
%  L1 - list of numbers from L that are less then M,
%  L2 - numbers from L that are greater then M

% imperative-like
split(_, [], [], []).
split(M, [H|T], L1, L2):- split(M, T, L11, L22),
                          split_(M, H, L1, L11, L2, L22).
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

% try to make it more Prolog-like
split2(_, [], [], []).
split2(M, [H|T], [H|T1], L2):- H < M,
                               split2(M, T, T1, L2).
split2(M, [H|T], L1, [H|T2]):- H > M,
                               split2(M, T, L1, T2).
split2(M, [H|T], L1, L2):- H = M,
                           split2(M, T, L1, L2).

%%% h - Prime factors

prime_factors(1, []).
prime_factors(X, L):- LIM is div(X, 2),
                      prime_factors_(X, L, 2, LIM),
                      !.
prime_factors_(_, [], LIM, LIM).
prime_factors_(X, [I|T], I, LIM):- R is X / I,
                                   integer(R),
                                   prime_factors_(R, T, 2, LIM).
prime_factors_(X, L, I, LIM):- J is I + 1,
                               prime_factors_(X, L, J, LIM).


%%% i - Intersect L1 with L2 as sets into L3

intersect([], _, []).
intersect([H|T1], L2, [H|T3]):- member(H, L2),
                                intersect(T1, L2, T3).
intersect([_|T1], L2, L3):- intersect(T1, L2, L3).


%%% j - True if X and Y are adjucent in L. L = [... , X, Y, ... ]

cut_after(X, [X|T], T).
cut_after(_, [], []).
cut_after(X, [_|T], LR):- cut_after(X, T, LR).

adjacent(X, Y, L) :- cut_after(X, L, [Y|_]).

%%% other

% factorial

fact(0, 1).
fact(N, X):- N > 0,
             M is N - 1,
             fact(M, Y),
             X is Y * N.

% member

member(X, [X|_]).
member(X, [_|T]):- member(X, T).

% concatenate L1 and L2 into L3

conc([], L, L).
conc([H|T1], L2, [H|T3]):- conc(T1, L2, T3).

% add

add_front(X, L, [X|L]).

add_back(X, [], LR):- LR = [X].
add_back(X, [H|T], [H|TR]):- add_back(X, T, TR).

% del X

del(X, [X|T], T).
del(X, [Y|T], [Y|TR]):- del(X, T, TR).

% del Nth

del_nth(N, L, LR):- del_nth_(N, L, LR, 0).
del_nth_(I, [_|T], LR, I):- LR = T.
del_nth_(N, [H|T], [H|TR], I):- J is I + 1,
                                del_nth_(N, T, TR, J).
