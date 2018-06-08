                                                            
                                                            
                                      %%%%%%%%%%%%%% Spatial-Reasoning %%%%%%%%%%%%%%%%%
                                                            
% This predicates are implemented following the same strategy of KNOWROB for spatial qualitative reasoning. Some of % them are modified to be fit with PMK. 

%%%%%%%%%%%%%%%%%%%% INSIDE%%%%%%%%%%%%%%%%%%%%%

%% in_ContGeneric(?InnerObj, ?OuterObj) is nondet.
%% in_ContGeneric(?InnerObj, ?OuterObj, +Interval) is nondet.
%
% Check if InnerObj is contained by OuterObj. Currently does not take the orientation
% into account, only the position and dimension.
%
% Implemented as a wrapper predicate around holds(...) that computes the relation for the
% current point in time
%
% @param InnerObj Identifier of the inner Object
% @param OuterObj Identifier of the outer Object
%

% Introduce the inner and outer objects that depends on time.
in_ContGeneric(InnerObj, OuterObj) :-
    current_time(Instant),
    in_ContGeneric(InnerObj, OuterObj, [Instant,Instant]).
    
% return the result of each instance in Interval.    
in_ContGeneric(InnerObj, OuterObj, Interval) :-
    spatially_holds_interval(InnerObj, in_ContGeneric_at_time, OuterObj, Interval).

% comparesion! 
in_ContGeneric_at_time(InnerObj, OuterObj, Instant) :-
    
    spatial_thing(InnerObj),
    map_frame_name(MapFrame),
    object_pose_at_time(InnerObj, Instant, (MapFrame, _, [IX,IY,IZ], _)),
    object_dimensions(InnerObj, ID, IW, IH),
    rdfs_individual_of(OuterObj, sir_pmk:'Container'),
    InnerObj \= OuterObj,
    object_pose_at_time(OuterObj, Instant, (MapFrame, _, [OX,OY,OZ], _)),
    object_dimensions(OuterObj, OD, OW, OH),



%in_cont_generic:-

%IX = 2, IY = 2, IZ = 2,
%ID = 3, IW = 3, IH = 3,

%OX = 2, OY = 2, OZ = 2,
%OD = 3, OW = 3, OH = 3,


    >=( (IX - 0.5*ID), (OX - 0.5*OD)-0.05), =<( (IX + 0.5*ID),  (OX + 0.5*OD)+0.05 ),
    >=( (IY - 0.5*IW), (OY - 0.5*OW)-0.05 ), =<( (IY + 0.5*IW), (OY + 0.5*OW)+0.05 ),
    >=( (IZ - 0.5*IH), (OZ - 0.5*OH)-0.05 ), =<( (IZ + 0.5*IH), (OZ + 0.5*OH)+0.05 ).
    
%%%%%%%%%LEFT%%%%%%%%%%%%%%%%%%%%%%%%%    
on_the_left:-

LX = 3, LY = 2, LZ = 4,
RX = 2, RY = 2, RZ = 4,

    =<( abs( LY - RY), 0.30), 
    =<( RX, LX ),              
    =<( abs( LZ - RZ), 0.30).  
    
%%%%%%%%%%RIGHT%%%%%%%%%%%%%%%%%%%%%%    
on_the_right:-

LX = 3, LY = 2, LZ = 4,
RX = 2, RY = 2, RZ = 4,

    =<( abs( LY - RY), 0.30), 
    =<( LX, RX ),              
    =<( abs( LZ - RZ), 0.30). 
    
%%%%%%%%%%%%%%On%%%%%%%%%%%%%%%%%%% 
on:-

BZ = 4, TZ = 5, 

%in_cont_generic,
<( BZ, TZ).




%% objectAtPoint2D(+PX, +PY, ?Obj) is nondet.
%
% Compute which objects are positioned at the given (x,y) coordinate 
%
% @param PX   X coordinate to be considered    
% @param PY   Y  coordinate to be considered
% @param Obj  Objects whose bounding boxes overlap this point in x,y direction
% @bug        THIS IS BROKEN FOR ALL NON-STANDARD ROTATIONS if the upper left matrix is partly zero
%

objectAtPoint2D(PX,PY,Obj) :-
    current_time(Instant),
    objectAtPoint2D(PX,PY,Obj, Instant).
 
objectAtPoint2D(PX, PY, Obj, Instant) :-

    % get information of potential objects at positon point2d (x/y)
    object_dimensions(Obj, OD, OW, _),
    
    object_pose_at_time(Obj, Instant, mat([M00, M01, _, OX,
                                           M10, M11, _, OY,
                                           _, _, _, _,
                                           _, _, _, _])),

% object must have an extension
    <(0,OW), <(0,OD),

    % calc corner points of rectangle (consider rectangular objects only!)
    P0X is (OX - 0.5*OW),
    P0Y is (OY + 0.5*OD),
    P1X is (OX + 0.5*OW),
    P1Y is (OY + 0.5*OD),
    P2X is (OX - 0.5*OW),
    P2Y is (OY - 0.5*OD),
    % rotate points
    RP0X is (OX + (P0X - OX) * M00 + (P0Y - OY) * M01),
    RP0Y is (OY + (P0X - OX) * M10 + (P0Y - OY) * M11),
    RP1X is (OX + (P1X - OX) * M00 + (P1Y - OY) * M01),
    RP1Y is (OY + (P1X - OX) * M10 + (P1Y - OY) * M11),
    RP2X is (OX + (P2X - OX) * M00 + (P2Y - OY) * M01),
    RP2Y is (OY + (P2X - OX) * M10 + (P2Y - OY) * M11),

    % debug: print rotated points
    %write('P0 X: '), write(P0X), write(' -> '), writeln(RP0X),
    %write('P0 Y: '), write(P0Y), write(' -> '), writeln(RP0Y),
    %write('P1 X: '), write(P1X), write(' -> '), writeln(RP1X),
    %write('P1 Y: '), write(P1Y), write(' -> '), writeln(RP1Y),
    %write('P2 X: '), write(P2X), write(' -> '), writeln(RP2X),
    %write('P2 Y: '), write(P2Y), write(' -> '), writeln(RP2Y),

    V1X is (RP1X - RP0X),
    V1Y is (RP1Y - RP0Y),

    V2X is (RP2X - RP0X),
    V2Y is (RP2Y - RP0Y),

    VPX is (PX - RP0X),
    VPY is (PY - RP0Y),

    DOT1 is (VPX * V1X + VPY * V1Y),
    DOT2 is (VPX * V2X + VPY * V2Y),
    DOTV1 is (V1X * V1X + V1Y * V1Y),
    DOTV2 is (V2X * V2X + V2Y * V2Y),

    =<(0,DOT1), =<(DOT1, DOTV1),
    =<(0,DOT2), =<(DOT2, DOTV2).
