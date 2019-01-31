%%%%%%%%%%%%%%%%%
% D3_speaker.lp %%%
%%%%%%%%%%%%%%%%%

%*
Pick up the knife
Cut the tomato
Pass it to me (washing_dishes vs cooking)
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
is(word1,action_verb).
is(word2,action_verb).
is(word3,pronoun).
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
has(obj5,uttered,word2).
has(obj5,previously_uttered,word1).
has(obj2,physical_integrity,split).
has(word4,verb_pronoun_ref,word3).
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

{has(A,speaker_intends,X) : is(A,action_verb),is(S,person),has(S,uttered,A),is(X,object)} = 1.

%DEFINE
has(X,nextAction,A) :- has(X,loc,self),is(X,object),has(A,name, putdown).
has(X,nextAction,A) :- has(X,loc,table),is(X,object),has(A,name,pickup).

% When something is split, it is made up of multiple parts
% Speaker unlikely to use "it" when referring to multiple object
has(X,number_parts,multiple) :- has(X,physical_integrity,split),is(X,object).
-has(A,speaker_intends,X):- has(X,number_parts,multiple),has(A,verb_pronoun_ref,W),is(W,pronoun),has(W,name,it),is(X,object), not has(A,speaker_intends,X).

% speaker prefers the robot to perform the next action
-has(A,speaker_intends,X):- not has(X,nextAction,A),is(A,action_verb),is(X,object), not has(A,speaker_intends,X).

% relevance of an object to a speaker if it helps the speaker
has(X,function,tool) :- has(X,used_for,cutting).
has(cooking,requires,X):- has(X,used_for,eating).
has(washing_dishes,requires,X):- has(X,function,tool).
has(X,relevant_to,S) :- has(S,is_doing,T),has(T,requires,X),is(S,person).

%TEST
% speaker does not intend for the robot to pass it irrelevant things.
:- has(A,speaker_intends,X), not has(X,relevant_to,S),has(S,uttered,A).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%DISPLAY
%#show holds/2.
#show has/3.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
