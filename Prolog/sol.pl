%% Kevin Doyle (15350806)

countX([H1 | T], C) :- =(H1, x), 
                        !, 
                        NewC is C + 1,
                        countX(T, NewC); 
                        countX(T, C).

countX([], Board) :- Board is 1.

countOfCounts([], Y) :- Y is 1.

countOfCounts([H | T], Y) :- countX(H, 0), 
                                !, 
                                X is Y + 1, 
                                countOfCounts(T, X); 
                                countOfCounts(T, Y).

solved(Board) :- countOfCounts(Board, 0).

horizontalJump([H1 | T1], [H2 | T2], DifferenceCount) :- \+ =(H1, H2),
    												        !,
    												        NewCount is DifferenceCount + 1,
    													    horizontalJump(T1, T2, NewCount);
    													    horizontalJump(T2, T2, DifferenceCount).

horizontalJump([], [], DifferenceCount) :- DifferenceCount is 3; 
                                            DifferenceCount is 0.

correctHorizontalJump([H1 | T1], [H2 | T2]) :- horizontalJump(H1, H2, 0), 
                                                !, 
                                                correctHorizontalJump(T1, T2).
correctHorizontalJump([], []).
                           
hasHorizontalJump([], _, CountO, ConsecutiveX) :- CountO > 0, 
                                                    ConsecutiveX is 1.

hasHorizontalJump([H | T], LastX, CountO, ConsecutiveX) :- =(H, x), 
    														!, 
    													    (=(LastX, 1), 
    														!, 
    													    hasHorizontalJump(T, 1, CountO, 1); 
    													    hasHorizontalJump(T, 1, CountO, ConsecutiveX)); 
    														NewCountO is CountO + 1, 
    													    hasHorizontalJump(T, 0, NewCountO, ConsecutiveX). 

isHorizontalJump([], CountX) :- CountX is 1.

isHorizontalJump([H | T], CountX) :- hasHorizontalJump(H, 0, 0, 0), 
    							        !, 
    							        NewCountX is CountX + 1, 
    								    isHorizontalJump(T, NewCountX); 
    								    isHorizontalJump(T, CountX).

verticalJump([H1 | T1], [H2 | T2], DifferenceCount) :- \+ =(H1, H2), 
    												    !, 
    											        NewCount is DifferenceCount + 1, 
    												    verticalJump(T1, T2, NewCount); 
    												    verticalJump(T1, T2, DifferenceCount).

verticalJump([], [], DifferenceCount) :- DifferenceCount is 1.

correctVerticalJump([H1 | T1], [H2 | T2]) :- verticalJump(H1, H2, 0), 
                                                !, 
                                                correctVerticalJump(T1, T2).

correctVerticalJump([], []).

hasVerticalJump([], CountX) :- CountX is 1.

hasVerticalJump([H | T], CountX) :- =(H, x), 
    							    !, 
    							    NewCount is CountX + 1, 
    								hasVerticalJump(T, NewCount); 
    								hasVerticalJump(T, CountX).

isVerticalJump([], CountX) :- CountX is 2.

isVerticalJump([H | T], CountX) :- hasVerticalJump(H, 0), 
    						        !, 
    						        NewCountX is CountX + 1, 
    							    isVerticalJump(T, NewCountX); 
    							    isVerticalJump(T, CountX).

jump(BoardOne, BoardTwo) :- isHorizontalJump(BoardOne, 0), 
                                !, 
                                correctHorizontalJump(BoardOne, BoardTwo); 
                                isVerticalJump(BoardOne, 0), 
                                !, 
                                correctVerticalJump(BoardOne, BoardTwo).