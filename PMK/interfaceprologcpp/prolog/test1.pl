/* PMK Predicates */
%:- use_module(library('semweb/rdf11')).
:- use_module(library('semweb/rdf_db')).
:- use_module(library('semweb/rdf_db.pl')).
:- use_module(library('semweb/rdf_edit.pl')).
:- use_module(library('semweb/rdfs.pl')).
:- use_module(library('semweb/rdf_portray')).
:- use_module(library('url.pl')).
:- use_module(library('http/http_open.pl')).




:-  rdf_meta
    find_subclass(r,r),
    find_ManProperties(r, r).


%Pasring the pmk ontology.

:- rdf_load('/home/users/mohammed.sharafeldeen/catkin_ws_know/src/PMK/interfaceprologcpp/owl/pmk_merged.owl').

:- rdf_db:rdf_register_ns(sir_pmk, 'http://www.co-ode.org/ontologies/ont.owl#', [keep(true)]).


%%%%%%%%%%%%% PROLOG FEATURES %%%%%%%%%%%%

   find_subclass(Class, SubClass):-
   rdfs_subclass_of(SubClass, Class),
   SubClass \= Class.

%Removing unnecessary string in literal when reading data values in order to extract only value.

 literal_type_conv(literal(type(_, V)), Value):- atom_to_term(V, Value, _), !.
 literal_type_conv(Value, Value).

properties(obj):-
  rdf_has(Artifact, sir_pmk:'diameter', D),
  rdf_has(Artifact, sir_pmk:'height', H),
  rdf_has(Artifact, sir_pmk:'Length', L),
     
     literal_type_conv(D, Diameter),
     literal_type_conv(H, Height),
     literal_type_conv(L, Length).


find_ManProperties(Artifact, properties):-
  rdf_has(Artifact, sir_pmk:'diameter', D),
  rdf_has(Artifact, sir_pmk:'height', H),
  rdf_has(Artifact, sir_pmk:'Length', L),
     
     literal_type_conv(D, Diameter),
     literal_type_conv(H, Height),
     literal_type_conv(L, Length).
