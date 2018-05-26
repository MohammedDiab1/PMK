% Try to assert the value from console  by adding read function 

 :- dynamic quternian/4.
    main :-
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
      
    write_to_file(file, text) :-
    open(file, write, stream).
   % write(Stream, Text), nl,
   % close(Stream).
    
    read_from_file(File) :-
    open(File, read, Stream),
    get_float(Stream, A),
    stream_process(A, Stream),
    close(Stream).
    
    stream_process(end_of_file, _) :- !.
    
    stream_process(float, Stream) :-
    write(A),
    get_float(Stream, A),
    stream_process(A, Stream),
       write('The quternian is: '),
       write(A).
      
