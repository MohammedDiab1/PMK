#:- module(knowledge).
 
 
 





#:- like(a,d).
#:- grasping_pose(x,y,z,w).



#:- module(knowledge).
 
 
 
%:- use_module(library('semweb/rdf_db.pl')).
%:- use_module(library('semweb/rdf_edit.pl')).
%:- use_module(library('semweb/rdfs.pl')).
%:- use_module(library('semweb/rdf_portray')).
%:- use_module(library('url.pl')).
%:- use_module(library('http/http_open.pl')).


%Setting resources for predicates.
:-  rdf_meta
 %   find_subclass(r,r),
 %   object_dimension(r, ?, ?, ?),
%	find_dimension(r, r, r, r).
%	% like(r,r).
%	% grasping_pose(r,r,r,r).

%Parsing and registering OWLs.
%:- rdf_load('/home/diab/catkin_ws/src/interfaceprologcpp/owl/pmk.owl').

%:- rdf_db:rdf_register_ns(sir_pmk, 'http://sir.upc.edu/projects/ontologies/kb/mpk.owl#', [keep(true)]).


%%%%%%%%%%%%% PROLOG FEATURES %%%%%%%%%%%%

    % find_subclass(Class, SubClass):-
   % rdfs_subclass_of(SubClass, Class),
  %  SubClass \= Class.

%Removing unnecessary string in literal when reading data values in order to extract only value.
% literal_type_conv(literal(type(_, V)), Value):- atom_to_term(V, Value, _), !.
%literal_type_conv(Value, Value).


%%%%%%%%%%%% READING DATA PROPERTIES FROM THE OWL %%%%%%%%%%%%%

% find_dimension(Obj, Depth, Height, Length):-
    %Reading the object dimension.
    % rdf_has(Obj, sir_pmk:'depthOfObject', D),
    % rdf_has(Obj, sir_pmk:'heightOfObject', H),
   % rdf_has(Obj, sir_pmk:'LengthOfObject', L),

    %Converting literal to value.has
  %  literal_type_conv(D, Depth),
 %   literal_type_conv(H, Height),
%    literal_type_conv(L, Length).
    
% object_color(Artifact, color):-
% rdf_has(Artifact, sir_standardFOclass:'Color', color).
   
% object_dimension(obj, _, _, _). 



%:- like(a,d).
%:- grasping_pose(x,y,z,w).

%Setting resources for predicates.
:-  rdf_meta
        find_subclass(r,r),
	find_dimension(r,r,r,r),
        find_physical_attributes(r,r,r,r),
        find_alignmen(r,r),
	find_cont_const(r,r),
	find_manip_const(r,r),
	find_color(r,r),
	find_shape(r,r),
	object_classification(r,r,r),
	all_object_classification(r,r,r,r),
	min_force_comp(r,r).
%Parsing and registering OWLs.
:- rdf_load('/home/diab/catkin_ws/src/interfaceprologcpp/owl/pmk.owl').

%:- rdf_db:rdf_register_ns(sir_pmk, 'http://sir.upc.edu/projects/ontologies/kb/mpk.owl#', [keep(true)]).


	
	%Parsing and registering OWLs.
% :- rdf_load('/home/muhayyuddin/PROLOG/PrologCpp/prolog_cpp_interface/knowledge/mpk.owl').

%:- http_open('http://sir.upc.edu/projects/ontologies/kb/mpk.owl', Stream, []), rdf_load(Stream, [blank_nodes(noshare)]).


%:- rdf_db:rdf_register_ns(sir_mpk, 'http://sir.upc.edu/projects/ontologies/kb/mpk.owl#', [keep(true)]).


% rdf_has(Ind, Prop, Ind).
% Functions to be defined: find_min_force, find_manip_const 

%%%%%%%%%%%%% PROLOG FEATURES %%%%%%%%%%%%

find_subclass(Class, SubClass):-
    rdfs_subclass_of(SubClass, Class),
    SubClass \= Class.

%Removing unnecessary string in literal when reading data values in order to extract only value.
literal_type_conv(literal(type(_, V)), Value):- atom_to_term(V, Value, _), !.
%literal_type_conv(Value, Value).


%%%%%%%%%%%% READING DATA PROPERTIES FROM THE OWL %%%%%%%%%%%%%

find_dimension(Obj, Width, Depth, Height):-
    %Reading the object dimension.
    rdf_has(Obj, sir_pmk:'widthOfObject', W),
    rdf_has(Obj, sir_pmk:'depthOfObject', D),
    rdf_has(Obj, sir_pmk:'heightOfObject', H),

    %Converting literal to value.
    literal_type_conv(W, Width),
    literal_type_conv(D, Depth),
    literal_type_conv(H, Height).

find_physical_attributes(Obj, Mass, Friction, GravEff):-
    %Reading the physical attributes.
    rdf_has(Obj, sir_pmk:'has-massValue', M), 
    rdf_has(Obj, sir_pmk:'has-frictionValue', F), 
    rdf_has(Obj, sir_pmk:'has-gravitationalEffect', G), 

    %Converting literal to value.
    literal_type_conv(M, Mass),
    literal_type_conv(F, Friction),
    literal_type_conv(G, GravEff).

find_alignment(Obj, Aligned):-
    %Reading the physical attributes.
    rdf_has(Obj, sir_pmk:'is-aligned', A),

    %Converting literal to value.
    literal_type_conv(A, Aligned).


%%%%%%%%%%%% READING OBJECT PROPERTIES FROM THE OWL %%%%%%%%%%%%%

%Finding the object contact constraint.
find_cont_const(Obj, ContConst):-
    rdfs_individual_of(Obj, sir_pmk:'ManipulatableObject'),
    (rdf_has(Obj, sir_pmk:'has-contConst', CC),
    rdf_split_url(_, CCSpl, CC), term_to_atom(ContConst, CCSpl);
    \+( rdf_has(Obj, sir_pmk:'has-contConst', _) ), ContConst = null ).

%Finding the object manipulation constraint.
find_manip_const(Obj, ManipConst):-
    rdfs_individual_of(Obj, sir_pmk:'ManipulatableObject'),
    ( rdf_has(Obj, sir_pmk:'has-manipConst', MC),
    rdf_split_url(_, MCSpl, MC), term_to_atom(ManipConst, MCSpl);
    \+( rdf_has(Obj, sir_pmk:'has-manipConst', _) ), ManipConst = null ).
    

%Finding the object color.
find_color(Obj, Color):-
    rdf_has(Obj, sir_pmk:'has-color', C), rdf_split_url(_, Color, C).

%Finding the object shape.
find_shape(Obj, Shape):-
     rdf_has(Obj, sir_pmk:'has-shape', S), rdf_split_url(_, Shape, S).


%%%%%%%%%%%% REASONING ON THE OWL KNOWLEDGE %%%%%%%%%%%%%

%Reasoning on object type.
object_classification(Obj, ObjType, Const):-
    find_cont_const(Obj, ContConst), find_manip_const(Obj, ManipConst),  
    ( ContConst = null, ManipConst = null, Const = null, ObjType = freely-manipulatable;
    ObjType = constraint-oriented, ( ContConst = null, ManipConst \= null, Const=manip-const; 
                                     ContConst \= null, ManipConst = null, Const=cont-const;
                                     ContConst \= null, ManipConst \= null, Const=cont-manip-const ) ), !.
    
all_object_classification(OrgObj, Obj, ObjType, Const):-
     rdfs_individual_of(OrgObj, sir_pmk:'ManipulatableObject'), object_classification(OrgObj, ObjType, Const),
     rdf_split_url(_, Obj, OrgObj).


%Comuting the minimal force to move an object.
min_force_comp(Obj, Force):-
    find_physical_attributes(Obj, Mass, Friction, _GravEff),
    Force is (Friction*Mass*9.8).
