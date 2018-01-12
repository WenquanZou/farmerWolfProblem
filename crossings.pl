%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                            %
%         276 Introduction to Prolog         %
%                                            %
%       Coursework 2017-18 (crossings)       %
%                                            %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%% ------------  (utilities) DO NOT EDIT



forall(P,Q) :- \+ (P, \+ Q).


app_select(X,List,Remainder) :-
  append(Front, [X|Back], List),
  append(Front, Back, Remainder).


% The following might be useful for testing.
% You may edit it if you want to adjust
% the layout. DO NOT USE it in your submitted code.

write_list(List) :-
  forall(member(X, List),
         (write('  '), write(X), nl)
        ).


% solutions for testing

solution([f+g,f,f+w,f+g,f+c,f,f+b,f,f+g]).
solution([f+g,f,f+c,f+g,f+w,f,f+b,f,f+g]).
solution([f+g,f,f+b,f,f+w,f+g,f+c,f,f+g]).
solution([f+g,f,f+b,f,f+c,f+g,f+w,f,f+g]).


%% --------- END (utilities)



%% ------ Add your code to this file here.


/* Add code for Step 1 below this comment */
% safe(+Bank)
% safe/1 holds when Bank is a given list of items (those left
% behind on a bank when a journey is made) that is safe.

safe(L) :- contain(f, L) ,! ;\+ unsafe(L).

unsafe(L) :- contain(g,L), (contain(w, L); contain(c, L)).

contain(I, [I|_]).
contain(I, [X|L]) :- X \= I,contain(I,L).

/* Add code for Step 2 below this comment */
% safe_state(+State)
% safe_state/1 holds when State represents a state
% in which both of the banks are safe.

safe_state(North-South) :- safe(North), safe(South).

/* Add code for Step 3 below this comment */
% equiv(+State1, +State2)
% In this problem, I have assumed that the elems are unique.
% equiv/2 holds when the two (ground) states are equivalent

equiv(N1-S1, N2-S2) :- equalBank(N1, N2), equalBank(S1, S2).
equalBank(Bank1, Bank2)
  :- checkLength(Bank1,Bank2), forall(member(M, Bank1), contain(M, Bank2)).
checkLength(Bank1,Bank2)
  :- length(Bank1, X), length(Bank2, Y), X =:= Y.

/* Add code for Step 4 below this comment */
% goal(+State)
% goal/1 holds when (given, ground) State is a valid goal state

goal([]-[f|_]).

/* Add code for Step 5 below this comment */
% visited(+State, +Sequence)
% visited/2 holds when a given state State is equivalent to some
% member of a given Sequence

visited(State, [CurrHis|Rest]) :- equiv(State, CurrHis); visited(State, Rest).

/* Add code for Step 6 below this comment */
% select(X, List, Remainder)
% select/3 holds when X is an element of the given (ground) list List and
% Remainder is the list obtained when X is removed from List.

/*  Uncomment the following if you wish to skip Step 6. Else Add code
for Step 6  below this comment */


select(X, [X|Remainder], Remainder).
select(X, [Y|Rest], [Y|Remainder]) :- select(X, Rest, Remainder).

/*

select(X,List,Remainder) :-
  app_select(X,List,Remainder).

*/


/* Add code for Step 7 below this comment */
% crossing(+State, -Move, -Next)

% Base case for only farmer move.
crossing([f|Rest]-South, f, Rest-[f|South]).
crossing(North-[f|Rest], f, [f|North]-Rest).

% Complicate case for farmer plus another object move.
crossing([f|Rest]-South, Move, Next)
    :- select(X, Rest, BankAfter) , Move = f+X, Next = BankAfter-[f,X|South].
crossing(North-[f|Rest], Move, Next)
    :- select(X, Rest, BankAfter) , Move = f+X, Next = [f,X|North]-BankAfter.

/* Add code for Step 8 below this comment */
% succeeds(?Sequence)
%
% succeeds/1 holds for a sequence (a list of states) that starts
% with the initial state (all objects on the north bank) and
% terminates with all objects on the south bank;
% Where each step is the result of "safe" journeys and no states are
% repeated.

/*  Uncomment the following if you wish to skip Step 8.   Else Add code for Step 8  below this comment */

/*

succeeds(Sequence) :- solution(Sequence).

*/

succeeds(Sequence) :- journey([f,w,g,c,b]-[], [], Sequence).
journey(State, _, _) :- goal(State), !.
journey(CurState, History, [Move|Sequence])
  :- safeMove(CurState, Move, NextState, History)
  , journey(NextState, [CurState|History], Sequence).
safeMove(CurState, Move, NextState, History)
  :- crossing(CurState, Move, NextState), safe_state(NextState)
  , \+ visited(NextState, History).


/* Add code for Step 9 below this comment */
% count_items(List, Stats)
% count_items(+List, ?ImmList, -Final)
count_items(List, Stats) :- count_items(List, [], Stats).

count_items([], Final, Final).
count_items([F|Rest], Imm, Final)
  :- count_one((F, Occ), Imm, Recur), !, TotalOcc is Occ+1,
  count_items(Rest, [(F, TotalOcc)|Recur], Final).
count_items([F|Rest], Imm, Final) :- count_items(Rest, [(F,1)|Imm], Final).

count_one((F,Occ), [(F,Occ)|Recur], Recur) :- !.
count_one(F, [H|Recur], [H|Rest]) :- count_one(F, Recur, Rest).

/* Add code for Step 10  below this comment */
% g_journeys(Seq,N)

g_journeys(Seq,N) :- succeeds(Seq),!, count_items(Seq, [(f+g, N)|_]).
