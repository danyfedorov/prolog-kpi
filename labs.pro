% -*- mode: prolog -*-

% a
fib(0, 0).
fib(1, 1).
fib(N, X) :- M is N - 1, fib_(0, 1, M, X).
fib_(_, B, 0, B).
fib_(A, B, N, X) :- C is A + B, M is N - 1, fib_(B, C, M, X).

% e
nth(0, [X|_], X).
nth(N, [_|R], X) :- M is N - 1, nth(M, R, X).
