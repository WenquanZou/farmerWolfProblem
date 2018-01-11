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
safe([]).
safe([f|_]).
safe(L) :- contain(g,L), not(contain(c,L)), not(contain(w, L)).
safe(L) :- contain(w,L), not(contain(g,L)).
contain(I, [I|_]).
contain(I, [X|L]) :- X \= I,contain(I,L).

% safe/1 holds when Bank is a given list of items (those left
% behind on a bank when a journey is made) that is safe.


/* Add code for Step 2 below this comment */
% safe_state(+State)
%
% safe_state/1 holds when State represents a state
% in which both of the banks are safe.

/* Add code for Step 3 below this comment */
% equiv(+State1, +State2)
%
% equiv/2 holds when the two (ground) states are equivalent


/* Add code for Step 4 below this comment */
% goal(+State)
%
% goal/1 holds when (given, ground) State is a valid goal state


/* Add code for Step 5 below this comment */
% visited(+State, +Sequence)
%
% visited/2 holds when a given state State is equivalent to some
% member of a given Sequence

/* Add code for Step 6 below this comment */
% select(X, List, Remainder)
%
% select/3 holds when X is an element of the given (ground) list List and
% Remainder is the list obtained when X is removed from List.

/*  Uncomment the following if you wish to skip Step 6. Else Add code
for Step 6  below this comment */

/*

select(X,List,Remainder) :-
  app_select(X,List,Remainder).

*/


/* Add code for Step 7 below this comment */
% crossing(+State, -Move, -Next)


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


/* Add code for Step 9 below this comment */
% count_items(List, Stats)



/* Add code for Step 10  below this comment */
% g_journeys(Seq,N)
