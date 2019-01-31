%%%%%%%%%%%%%%%%%
% D1_can.lp %%%
%%%%%%%%%%%%%%%%%

%*
Pick up the knife
Cut the tomato
Put it down
*%

% For incremental mode iclingo
#include <incmode>.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
#program base.
% We have several visual entities "obj1=knife", "obj2=tomato", "obj3=overall scene", "obj4=table", "obj5=human"
% We have several linguistic entities (words, utterances, discourse)

% Different percept types
is(obj1,object).
is(obj2,object).
is(obj3,scene).
is(obj4,loc).
is(obj5,person).
is(self,loc).

% Percept names
has(obj1,name,knife).
has(obj2,name,tomato).
has(obj3,name,kitchen).
has(obj4,name,table).
has(obj5,name,commX).

% Fluents
init(has(obj1,loc,self)). %holding knife
init(has(obj2,loc,table)). %tomato on table

% Initial state axiom
holds(F,0):- init(F).

% Action definitions
action(pickup(X)) :- is(X,object).
action(putdown(X)) :- is(X,object).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
#program step(t).

%GENERATE
{ occ(A,t) :  action(A) } = 1.

%DEFINE
% Effect of action occuring
holds(has(X,loc,self),t) :- occ(pickup(X),t-1).
-holds(has(X,loc,table),t) :- occ(pickup(X),t-1).
holds(has(X,loc,table),t) :- occ(putdown(X),t-1).
-holds(has(X,loc,self),t) :- occ(putdown(X),t-1).

% Inertia axioms
holds(F,t) :- holds(F,t-1), not -holds(F,t).
-holds(F,t) :- -holds(F,t-1), not holds(F,t).

% Commonsense laws
% Objects cannot be in two locations at once.
-holds(has(X,loc,Y),t) :- holds(has(X,loc,Z),t),is(Y,loc),Y!=Z.

%TEST
% Cannot pick up something you are already holding
:- occ(pickup(X),t), holds(has(X,loc,self),t).

% Cannot pick up something when you are holding something else
:- occ(pickup(X),t), holds(has(Y,loc,self),t).

% Cannot put down something you are not holding
:- occ(putdown(X),t), holds(has(X,loc,table),t).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
#program check(t).
:- query(t), t<maxlength.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%DISPLAY
#show occ/2.
%#show has/3.
%#show holds/2.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

#const maxlength=5.
