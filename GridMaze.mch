/* GridMaze
 * Author: Sapumal
 * Creation date: 12/15/2019
 */
MACHINE
    GridMaze
    
SETS
    ANSWERS = {Yes, No}

CONSTANTS

    startcell,
    targetcell,
    gridwidth,
    gridheight,
    internalwalls

PROPERTIES

    gridheight <: NATURAL1 & // y axis of the grid represent the height (vertical)
    gridheight = 1..5 &
    gridwidth <: NATURAL1 & // x axis of the grid represent the width (horizontal)
    gridwidth = 1..7 &
    internalwalls: NATURAL1 <-> NATURAL1 & // Internal wall cells marked as the spec
    internalwalls = {(1 |-> 3), (2 |-> 1), (2 |-> 3), (2 |-> 5), (3 |-> 3), (4 |-> 2), (4 |-> 3), (4 |-> 4), (6 |-> 1), (6 |-> 2), (6 |-> 4), (7 |-> 4)} &
    startcell: NATURAL1 <-> NATURAL1 &
    startcell = {(1 |-> 1)} &
    targetcell: NATURAL1 <-> NATURAL1 &
    targetcell = {(1 |-> 5)} //exit cell


VARIABLES

    visitedcellx,
    visitedcelly,
    visitedpath

INVARIANT
    
    visitedcellx: NATURAL1 &
    visitedcelly: NATURAL1 &
    visitedpath: seq(NATURAL1 * NATURAL1)

INITIALISATION
    
   visitedcellx := 1 ||
   visitedcelly := 1 ||
   visitedpath := []


OPERATIONS

//Operation to update the system with current status

   log_current_status(gridhorizontalpoint, gridverticalpoint, path)  =
   PRE
       gridhorizontalpoint: NATURAL1 & gridverticalpoint: NATURAL1 & path: seq(NATURAL1 * NATURAL1)
   THEN
       visitedpath := path ||
       visitedcellx := gridhorizontalpoint ||
       visitedcelly := gridverticalpoint
   END

END
