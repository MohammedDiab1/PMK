
/* PMK Predicates */
%:- use_module(library('semweb/rdf11')).
:- use_module(library('semweb/rdf_db')).
:- use_module(library('semweb/rdf_db.pl')).
:- use_module(library('semweb/rdf_edit.pl')).
:- use_module(library('semweb/rdfs.pl')).
:- use_module(library('semweb/rdf_portray')).
:- use_module(library('url.pl')).
:- use_module(library('http/http_open.pl')).

%Setting resources for predicates.
:-  rdf_meta
 find_subclass(r,r),
 find_dimension(r,r,r,r),
 assert_objPose,
 rdf_instance_from_class(r,r),
 find_ManProperties(r, r, r, r, r, r, r).

%Pasring the pmk ontology.

:- rdf_load('/home/users/mohammed.sharafeldeen/catkin_ws_know/PMK/interfaceprologcpp/owl/pmk_merged.owl').

:- rdf_db:rdf_register_ns(sir_pmk, 'http://www.co-ode.org/ontologies/ont.owl#', [keep(true)]).

%%%%%%%%%%%%% PROLOG FEATURES %%%%%%%%%%%%

   find_subclass(Class, SubClass):-
   rdfs_subclass_of(SubClass, Class),
   SubClass \= Class.

%Removing unnecessary string in literal when reading data values in order to extract only value.

 literal_type_conv(literal(type(_, V)), Value):- atom_to_term(V, Value, _), !.
 literal_type_conv(Value, Value).

%%%%%%%%%%%% READING DATA PROPERTIES FROM THE OWL %%%%%%%%%%%%%

find_dimension(Artifact, Diameter, Height, Length):-
    %Reading the object dimension   
 rdf_has(Artifact, sir_pmk:'diameter', D),
 rdf_has(Artifact, sir_pmk:'height', H),
 rdf_has(Artifact, sir_pmk:'Length', L),

    %Converting literal to value.has
     literal_type_conv(D, Diameter),
     literal_type_conv(H, Height),
     literal_type_conv(L, Length).

find_ManProperties(Artifact, Diameter, Height, Length, Color, Friction, Mass):-
 rdf_has(Artifact, sir_pmk:'diameter', D),
 rdf_has(Artifact, sir_pmk:'height', H),
 rdf_has(Artifact, sir_pmk:'Length', L),
 rdf_has(Artifact, sir_pmk:'Color', C),
 rdf_has(Artifact, sir_pmk:'InteractionParameter', F),
 rdf_has(Artifact, sir_pmk:'mass', M),
%rdf_has(Artifact, sir_pmk:'hasGraspingPart', GP),


    %Converting literal to value.has
     literal_type_conv(D, Diameter),
     literal_type_conv(H, Height),
     literal_type_conv(L, Length),
     literal_type_conv(C, Color),
     literal_type_conv(F, Friction),
     literal_type_conv(M, Mass).
    %literal_type_conv(GP, GPart).


%%%%%%%%%%%%%%%%%%%%%% Assert dummy values %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

:- dynamic quternian/4.
%assert_objPose/0.
 assert_objPose :-
 % Dummy values- it will be replaced by the ar_track_alvar position values so, try to see how to define the matrix inside protege
      X1 = [3,2,3,1],
      X2 = [3,2,3,1],
      % Replace the old-value by the updated one (change quternian(_))
      ( X1=X2 -> retractall(quternian(_, _, _, _)), 
      assert(quternian(_, _, _, _));
      X1=x3 -> retractall(quternian(_, _, _, _)), 
      assert(quternian(1, 3, 4, 5))),
      A = quternian(X,Y, Z, W),
      read(X),
      write('The quternian value of X is: '),
      write(X), nl,
      read(Y),
      write('The quternian value of Y is: '),
      write(Y), nl,
      read(Z),
      write('The quternian value of Z is: '),
      write(Z), nl,
      read(W),
      write('The quternian value of W is: '),
      write(W), nl,
      write('The quternian is: '),
      write(A).
 
 % rdf_assert(PerceptualLocalization, sir_pmk:'hasObjPos', literal(type(xsd:double, A)), objPos), !.
    rdf_instance_from_class(Class, Instance) :-
    rdf_instance_from_class(Class, _, Instance).
    
    rdf_instance_from_class(Class, SourceRef, Instance) :-
  ( is_uri(Class) ->
    T=Class ;
    atom_concat('http://www.co-ode.org/ontologies/ont.owl#', Class, T)),
  rdf_unique_id(Class, Instance),
  ( var(SourceRef) ->
    rdf_assert(Instance, rdf:type, T) ;
    rdf_assert(Instance, rdf:type, T, SourceRef)).


    rdf_unique_id(Class, UniqID) :-
  % generate 8 random alphabetic characters
  randseq(8, 25, Seq_random),
  maplist(plus(65), Seq_random, Alpha_random),
  atom_codes(Sub, Alpha_random),
  atom_concat(Class,  '_', Class2),
  atom_concat(Class2, Sub, Instance),
  % check if there is no triple with this identifier as subject or object yet
  ((rdf(Instance,_,_);rdf(_,_,Instance)) ->
    (rdf_unique_id(Class, UniqID));
    (UniqID = Instance)).
    
    
    
/* rdf_assert('http://www.co-ode.org/ontologies/ont.owl#objPos', sir_pmk:'hasObjPos', literal(type(xsd:double, 11)), objPos).
for example, create a instance called semanticMap011 that has pose 11.1
1) rdf_assert('semanticMap011', rdf:type, 'http://www.co-ode.org/ontologies/ont.owl#PerceptualLocalization').
2) rdf_assert(semanticMap011, sir_pmk:'hasObjPos', literal(type(xsd:double, 11.1))).
read the individual using
rdfs_individual_of(M,'http://www.co-ode.org/ontologies/ont.owl#PerceptualLocalization').
read the value of the individual
rdf_has(semanticMap011, A, B).

or 
 rdf_assert('http://www.co-ode.org/ontologies/ont.owl#PerceptualLocalization', rdf:type, 'asd').
 to see the individual of each class use: 
rdfs_individual_of(M,'http://www.co-ode.org/ontologies/ont.owl#PerceptualLocalization'). */

