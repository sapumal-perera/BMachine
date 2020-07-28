/* Maze
 * Author: IsuruK
 * Creation date: 12/19/2019
 */
MACHINE
    Maze


DEFINITIONS
    GRID == POW(NATURAL1 * NATURAL1)
        
CONSTANTS
    grid, blockedCells, startCell, exitCell, gridWidth, gridHeight
    
PROPERTIES
    grid : GRID & 
    blockedCells <: grid &
    startCell : grid &
    exitCell : grid &
    gridWidth : NATURAL1 &
    gridHeight : NATURAL1 &
    gridWidth = 7 &
    gridHeight = 5 &
    grid = ((1..gridWidth) * (1..gridHeight))&
    blockedCells = {1|->3,2|->1,2|->3,2|->5,3|->3,4|->2,4|->3,4|->4,6|->1,6|->2,6|->4,7|->4}&
    startCell = (1|->1)&
    exitCell = (1|->5)
    

END
