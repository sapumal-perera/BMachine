/* RobotController
 * Author: Sapumal
 * Creation date: 12/15/2019
 */
MACHINE
    RobotController

INCLUDES
    GridMaze
    
SETS
    
     NOTIFICATION = {
        PathClearToMove,
        PathBlockedFromInternalWall,
        PathEndFromGridWall,
        PathClearToTeleport,
        DirectTeleportToTargetIsProhibited
    };
    MOVEMENT = {
        toNorth,
        toSouth,
        toEast,
        toWest
    }
    
VARIABLES

    moveddirection,
    visitedroute,
    xcordinate,
    ycordinate,
    moveCount
        
INVARIANT
    
    moveddirection: seq(MOVEMENT) &
    visitedroute: seq(NATURAL1 * NATURAL1) &
    xcordinate: NATURAL1 &
    ycordinate:NATURAL1 &
    xcordinate: gridwidth &
    ycordinate: gridheight&
    moveCount : NATURAL 
    
INITIALISATION
    
    moveddirection := [] ||
    visitedroute := [] ||
    moveCount := 0 ||
    xcordinate := 1 ||
    ycordinate := 1

OPERATIONS

//Operation to take the x,y coordinates of current cell

   cellvisited  <-- get_visited_cell(cellx, celly)  =
   PRE    
       cellx : gridwidth &
       celly : gridheight
   THEN
       IF
           (cellx |-> celly : ran(visitedpath))
       THEN
           cellvisited := Yes
       ELSE
           cellvisited := No
       END
   END;

//Operation to trace the Robots path through the Grid

   path  <-- get_robots_path  =
   BEGIN 
       path := visitedpath
   END;


//Operation to Check whether Robot found the Target cell

   targetfound  <-- found_target_cell  =
   IF
       ((visitedcellx |-> visitedcelly) : targetcell)
   THEN
       targetfound := Yes
   ELSE
       targetfound := No
   END;


//Operation to Move the robot to North

   message  <-- robot_move_north  =
     PRE
        message : NOTIFICATION
        THEN
    IF
        ((xcordinate|-> ycordinate  + 1 ) /: internalwalls &
        (ycordinate + 1 : gridheight))
    THEN
        ycordinate := ycordinate + 1 ||
        moveddirection := moveddirection <- toNorth ||
        visitedroute := visitedroute <- (xcordinate |-> ycordinate) ||
        log_current_status(xcordinate, ycordinate +1, visitedroute <- (xcordinate  |-> ycordinate)) ||
        message := PathClearToMove||
        moveCount := moveCount + 1 
    ELSIF
        (ycordinate +1 /:  gridheight)
	      THEN 
	          message := PathEndFromGridWall
	 ELSE 
	     message := PathBlockedFromInternalWall
    END
    END;

//Operation to Move the robot to South

   message  <-- robot_move_south  =
    PRE
        message : NOTIFICATION
    THEN
    IF
        ((xcordinate |-> ycordinate -1) /: internalwalls &
        (ycordinate - 1 :  gridheight))
    THEN
        ycordinate := ycordinate - 1 ||
        moveddirection := moveddirection <- toSouth ||
        visitedroute := visitedroute <- (xcordinate |-> ycordinate) ||
        log_current_status(xcordinate, ycordinate -1, visitedroute <- (xcordinate  |-> ycordinate)) ||
        message := PathClearToMove||
        moveCount := moveCount + 1 
    ELSIF
        (ycordinate - 1 /:  gridheight)
	      THEN 
	          message := PathEndFromGridWall
	 ELSE 
	     message := PathBlockedFromInternalWall
    END
 END;
//Operation to Move the robot to East

   message  <-- robot_move_east  =
     PRE
        message : NOTIFICATION
        THEN
    IF
        ((xcordinate +1  |-> ycordinate) /: internalwalls &
        (xcordinate + 1 : gridwidth))
    THEN
        xcordinate := xcordinate + 1 ||
        moveddirection := moveddirection <- toEast ||
        visitedroute := visitedroute <- (xcordinate  |-> ycordinate) ||
        log_current_status(xcordinate + 1, ycordinate, visitedroute <- (xcordinate  |-> ycordinate)) ||
        message := PathClearToMove ||
        moveCount := moveCount + 1 
    ELSIF
        (xcordinate + 1 /:  gridwidth)
	      THEN 
	          message := PathEndFromGridWall
	 ELSE 
	     message := PathBlockedFromInternalWall
    END
     END;
    
//Operation to Move the robot to west

   message  <-- robot_move_west  =
     PRE
        message : NOTIFICATION
        THEN
    IF
        ((xcordinate  - 1 |-> ycordinate) /: internalwalls &
        (xcordinate - 1 : gridwidth))
    THEN
        xcordinate := xcordinate - 1 ||
        moveddirection := moveddirection <- toWest ||
        visitedroute := visitedroute <- (xcordinate |-> ycordinate) ||
        log_current_status(xcordinate - 1, ycordinate, visitedroute <- (xcordinate  |-> ycordinate)) ||
        message := PathClearToMove ||
        moveCount := moveCount + 1 
    ELSIF
        (xcordinate - 1 /: gridwidth)
	      THEN 
	          message := PathEndFromGridWall
	 ELSE 
	     message := PathBlockedFromInternalWall
END    
END;
    
//Operation to Get the Robots position in the Grid

   currentPosition  <-- get_robots_position  =
   BEGIN 
       currentPosition := (xcordinate|-> ycordinate)
   END;
 
 
 //Operation to Teleport the Robots in the Grid
 
  teleportMessage <-- robot_teleport(xvaluve,yvaluve) =
    PRE
        xvaluve : NATURAL1 &
        yvaluve : NATURAL1 &
        teleportMessage : NOTIFICATION
    THEN
        IF ((xvaluve|->yvaluve) : internalwalls)
        THEN
            teleportMessage := PathBlockedFromInternalWall
        ELSIF ((xvaluve|->yvaluve) /: gridheight*gridwidth )
        THEN
            teleportMessage := PathEndFromGridWall
        ELSIF ((xvaluve|->yvaluve) = (1 |-> 5) & moveCount = 0)
        THEN
            teleportMessage := DirectTeleportToTargetIsProhibited            
        ELSE
                 
            moveCount := moveCount + 1 ||
            xcordinate := xvaluve||
            ycordinate := yvaluve||
            teleportMessage := PathClearToTeleport ||
            log_current_status(xvaluve, yvaluve, visitedroute <- (xcordinate  |-> ycordinate))
        END                
    END
   
END

