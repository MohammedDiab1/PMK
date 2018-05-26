% Try to assert the value from console  by adding read function 

% :- dynamic value_of_a/1.
%    main :-
%    % Dummy values- it will be replaced by the ar_track_alvar position values so, try to see how to define the matrix inside protege 
%      X1 = [3,2],
%      X2 = [3,2],
%      % Replace the old-value by the updated one (change value_of_a(_))
%      ( X1=X2 -> retractall(val_of_a(_)), assert(val_of_a(1));
%      X1=X3 -> retractall(val_of_a(_)), assert(val_of_a(3))),
%      val_of_a(A),
%      write('The value of A is: '),
%      write(A), nl.


     
       % main :-
      % X1 is 3,
     % X2 is 3,
    %  ( X1=X2 -> retractall(val_of_a(_)), assert(val_of_a(2))
   %   ; X1=X3 -> retractall(val_of_a(_)), assert(val_of_a(3))
  %    ),
 %     val_of_a(A),
%      write(A).


create_a_rule :- 
    Cond=[w,x,y,z(X)],
    Head=newrule(X),
    list_to_tuple(Cond,Body),
    dynamic(Head),
    assert(Head :- Body),
    listing(Head).

/*
This is a [l,i,s,t], and this is a (t,u,p,l,e).  
Convertng list to tuple:  
[]    -> undefined  
[x]   -> (x) == x  
[x,y] -> (x,y).  
[x,y,z..whatever] = (x,y,z..whatever)  
*/

list_to_tuple([],_) :- 
    ValidDomain='[x|xs]',
    Culprit='[]',
    Formal=domain_error(ValidDomain, Culprit),
    Context=context('list_to_tuple','Cannot create empty tuple!'),
    throw(error(Formal,Context)).

list_to_tuple([X],X).

list_to_tuple([H|T],(H,Rest_Tuple)) :-
    list_to_tuple(T,Rest_Tuple).

:- create_a_rule.
:- listing(newrule).




  write_list([]).
      write_list(Head|Tail) :-
      write(Head), nl,
      write_list(Tail).
