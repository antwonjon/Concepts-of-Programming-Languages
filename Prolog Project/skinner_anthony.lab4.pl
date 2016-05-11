% CSCI 305, Lab 4
% Anthony Skinner

% The following is a weighted graph with 9 nodes
% Each edge is given as (i,j,weight), with weight > 0.

:-dynamic
	rpath/2.      % A reversed path

edge(1,2,1.6).
edge(1,3,1.5).
edge(1,4,2.2).
edge(1,6,5.2).
edge(2,3,1.4).
edge(2,5,2.1).
edge(2,9,5.1).
edge(3,4,1.4).
edge(3,5,1.3).
edge(4,5,1.3).
edge(4,7,1.2).
edge(4,8,3.0).
edge(5,6,1.6).
edge(5,7,1.7).
edge(6,7,1.8).
edge(6,8,2.2).
edge(6,9,1.7).
edge(7,8,1.6).
edge(8,9,1.8).

%you code will start from here
shortest(X,Y,L,W):- shortestPath(X, Y, W, L, []).

shortestPath(X, Y, W, [X,Y], _) :- edge(X, Y, W). 		%checks the weight between the two edges
shortestPath(X, Y, W, [X|P], V) :- \+ member(X, V), %check if its in the path already
                                 edge(X, Z, W1), %check if there is an edge
                                 shortestPath(Z, Y, W2, P, [X|V]), %recurse
                                 W is W1 + W2. %add to the weights
