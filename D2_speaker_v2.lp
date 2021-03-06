%%%%%%%%%%%%%%%%%
% D2_speaker.lp %%%
%%%%%%%%%%%%%%%%%

%*
Pick up the knife
Cut the tomato
Put it (down) in the bowl
*%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% We have several visual entities "obj1=knife", "obj2=tomato", "obj3=overall scene", "obj4=table", "obj5=human"
% obj6=bowl.
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
is(obj6,object). %bowl
is(obj6,loc).

% Percept names
has(obj1,name,knife).
has(obj2,name,tomato).
has(obj3,name,kitchen).
has(obj4,name,table).
has(obj5,name,commX).
has(word1,name,pickup).
has(word2,name,putdown).
has(word3,name,it).
has(obj6,name,bowl).

%other facts
has(obj5,uttered,word2).
has(obj5,previously_uttered,word1).
has(obj2,physical_integrity,split).
has(word2,verb_pronoun_ref,word3).
has(obj6,used_for,cooking).
has(obj5,using,obj6).
has(obj2,used_for,eating).

% Fluents
has(obj1,loc,self). %holding knife
has(obj2,loc,table). %tomato on table

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%GENERATE
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

%TEST
%New rules over D1_speaker_v2
%-------------
% Speaker is cooking and using the bowl, probably wants a food item in the bowl
:- has(A,speaker_intends,X),not has(X,used_for,eating),has(S,uttered,A),has(S,using,B),has(B,used_for,cooking).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%DISPLAY
%#show holds/2.
#show has/3.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
