%Student Name: Chenqu Zhao 
%Student Number: 5242692
%Assignment Name: Assignment 1 - Prolog Programming

%Question1
%sumsq_even(Numbers, Sum) - sums the squares of only the even numbers in a list of integers

sumsq_even([], 0).
sumsq_even([Head|Tail], Sum) :- sumsq_even(Tail, Sum_now), 0 is Head mod 2, Sum is Head ^ 2 + Sum_now.
sumsq_even([Head|Tail], Sum) :- sumsq_even(Tail, Sum_now), 1 is Head mod 2, Sum is Sum_now.

%Question2
%same_name(Person1, Person2) - succeeds if it can be deduced from the facts in the database that Person1 and Person2 will have the same family name

paternal(Person1, Person2) :- Person1 = Person2.
paternal(Person1, Person2) :- parent(Person3, Person2), male(Person3), paternal(Person1, Person3).

same_name(Person1, Person2) :- paternal(Person4, Person1), paternal(Person4, Person2).

%Question3
%sqrt_list(NumberList, ResultList) - binds ResultList to the list of pairs consisting of a number and its square root, for each number in NumberList

insert(New, [], [New]).
insert(New, [Head|Tail], [New,Head|Tail]).

sqrt_pair(Number, [Number|[X]]) :- X is sqrt(Number).

sqrt_list([], []).
sqrt_list([Head|Tail], List) :- sqrt_list(Tail, List_now), sqrt_pair(Head, Y), insert(Y, List_now, List).

%Question4
%sign_runs(List, RunList) - converts a list of numbers into the corresponding list of sign runs where each run is a maximal sequence of consecutive negative or non-negative numbers within the original list

break_p([], [], []).
break_p([Head|Tail], List, List_rest) :- Head >= 0, break_p(Tail, List_now, List_rest), insert(Head, List_now, List).
break_p([Head|Tail], List, List_rest) :- Head < 0, List_rest = [Head|Tail], List = [].

break_n([], [], []).
break_n([Head|Tail], List, List_rest) :- Head < 0, break_n(Tail, List_now, List_rest), insert(Head, List_now, List).
break_n([Head|Tail], List, List_rest) :- Head >= 0, List_rest = [Head|Tail], List = [].

sign_runs([], []).
sign_runs([Head|Tail], List) :- Head >= 0, break_p([Head|Tail], L1, L2), sign_runs(L2, List_now), insert(L1, List_now, List).
sign_runs([Head|Tail], List) :- Head < 0, break_n([Head|Tail], L1, L2), sign_runs(L2, List_now), insert(L1, List_now, List).

%Question5
%is_heap(Tree) - returns true if Tree satisfies the heap property which for every non-leaf node in the tree, the number stored at that node is less than or equal to the number stored at each of its children, and false otherwise

is_heap(empty).
is_heap(tree(empty, _, empty)).

is_heap(tree(empty, Data, Right)) :- is_heap(Right), Right = tree(_, RightData, _), RightData >= Data.
is_heap(tree(Left, Data, empty)) :- is_heap(Left), Left = tree(_, LeftData, _), LeftData >= Data.
is_heap(tree(Left, Data, Right)) :- is_heap(Left), is_heap(Right), Left = tree(_, LeftData, _), Right = tree(_, RightData, _), LeftData >= Data, RightData >= Data.
