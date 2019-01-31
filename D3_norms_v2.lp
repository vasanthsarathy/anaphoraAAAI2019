%%%%%%%%%%%%%%%%%
% D3_norms_v2.lp %%%
%%%%%%%%%%%%%%%%%

%*
Pick up the knife
Cut the tomato
Pass it to me.
*%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% We have several visual entities "obj1=knife", "obj2=tomato", "obj3=overall scene", "obj4=table", "obj5=human"
% We have several linguistic entities (words, utterances, discourse)

% Different percept types
is(obj1,object).
is(obj2,object).
is(obj3,scene).
is(obj4,loc).
is(obj5,person).
is(self,loc).
is(word1,action_verb). %pickup
is(word2,action_verb). %putdown
is(word3,pronoun). %it
is(word4,action_verb). %new word: pass

% Percept names
has(obj1,name,knife).
has(obj2,name,tomato).
has(obj3,name,kitchen).
has(obj4,name,table).
has(obj5,name,commX).
has(word1,name,pickup).
has(word2,name,putdown).
has(word3,name,it).
has(word4,name,pass).

%other facts
has(word2,verb_pronoun_ref,word3).
has(obj5,uttered,word2).
has(obj2,used_for,eating).
has(obj1,used_for,cutting).

% Fluents
has(obj1,loc,self). %holding knife
has(obj2,loc,table). %tomato on table

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%GENERATE
%Task that the speaker is doing
{has(obj5,is_doing,(washing_dishes;cooking))} = 1.
{ has(A,permissible,X) : is(A,action_verb),is(X,object),is(S,person),has(S,uttered,A) } = 1.

%DEFINE
% Forbidden to pass something that is not a dish to someone who is washing dishes.
has(X,function,tool) :- has(X,used_for,cutting).
has(cooking,requires,X):- has(X,used_for,eating).
has(washing_dishes,requires,X):- has(X,function,tool).
-has(A,forbidden,X) :- has(S,is_doing,T),has(A,permissible,X),has(T,requires,X).

%TEST
:- has(A,permissible,X),not -has(A,forbidden,X).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%DISPLAY
%#show holds/2.
#show has/3.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
