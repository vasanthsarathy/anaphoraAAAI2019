%%%%%%%%%%%%%%%%%
% D1_norms_v2.lp %%%
%%%%%%%%%%%%%%%%%

%*
Pick up the knife
Cut the tomato
Put it down
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

% Percept names
has(obj1,name,knife).
has(obj2,name,tomato).
has(obj3,name,kitchen).
has(obj4,name,table).
has(obj5,name,commX).
has(word1,name,pickup).
has(word2,name,putdown).
has(word3,name,it).

%other facts
has(word2,verb_pronoun_ref,word3).
has(obj5,uttered,word2).

% Fluents
has(obj1,loc,self). %holding knife
has(obj2,loc,table). %tomato on table

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%GENERATE
{ has(A,permissible,X) : is(A,action_verb),is(X,object),is(S,person),has(S,uttered,A) } = 1.

%DEFINE


%TEST
:- has(A,permissible,X),has(A,forbidden,X).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%DISPLAY
%#show holds/2.
#show has/3.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
