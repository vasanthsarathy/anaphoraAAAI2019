%%%%%%%%%%%%%%%%%
% D2_norms_v2.lp %%%
%%%%%%%%%%%%%%%%%

%*
Pick up the knife
Cut the tomato
Put it in the bowl
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
is(obj6,object). %bowl
is(obj6,loc).
is(obj7,object). %contents of the bowl

% Percept names
has(obj1,name,knife).
has(obj2,name,tomato).
has(obj3,name,kitchen).
has(obj4,name,table).
has(obj5,name,commX).
has(word1,name,pickup).
has(word2,name,put_in_bowl).
has(word3,name,it).
has(obj6,name,bowl).
has(obj7,name,contents).

%other facts
has(obj5,uttered,word2).
has(word2,verb_pronoun_ref,word3). % put_in it
has(obj6,used_for,cooking).
has(obj5,using,obj6).
has(obj2,used_for,eating).
has(obj7,used_for,eating).
%has(obj1,used_for,cutting).
has(obj6,contains,obj7).
has(obj1,attentional_status,candidate).
has(obj2,attentional_status,candidate).


% Fluents
has(obj1,loc,self). %holding knife
has(obj2,loc,table). %tomato on table

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%GENERATE
{ has(A,permissible,X) : is(A,action_verb),is(X,object),is(S,person),has(S,uttered,A),has(X,attentional_status,candidate) } = 1.

%DEFINE
% Permissible actions imply permissibility of their effects
has(Z,contains,X) :- has(A,permissible,X),has(A,name,put_in_bowl),has(Z,name,bowl).


% Mixing ingredients when a bowl contains ingredients that are food and non-food
has(X,good_mix,Y) :- has(Z,contains,X),has(Z,contains,Y),X!=Y,has(X,used_for,P1), has(Y,used_for,P2),P1=P2.

% Forbidden to put inedible items into a container containing edible items.
-has(A,forbidden,X) :- has(X,good_mix,Y),is(Y,object),is(X,object),is(A,action_verb),has(A,permissible,X).

%TEST
:- has(A,permissible,X),not -has(A,forbidden,X).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%DISPLAY
%#show holds/2.
#show has/3.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
