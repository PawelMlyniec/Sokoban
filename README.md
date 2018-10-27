# Sokoban

Sokoban is a type of puzzle created in Japan which means “warehouse”. The goal of the
game is that a player pushes all the boxes distributed around a grid in the warehouses.

In order to explain the rules and restrictions of the game, we will use the grid shown in
the figure below as an example. Nevertheless, the student must design and write a CLIPS
program that works for any configuration of the grid.

The grid of the figure displays grey cells that represent obstacles, three boxes, three
warehouses and a robot (player). The grid cells are referenced by two numbers that
indicate the row and column of the cell, respectively. Thus, in the figure, the robot is in
position (4,1), there is a warehouse at (1,7), a box in cell (4,3), an obstacle at (3,5), etc.

![sokoban](https://user-images.githubusercontent.com/37669901/47604834-0d6dfd00-d9ff-11e8-90a6-8a3907dc38b0.png)


The robot can move to an adjacent cell in any of the four following directions: up, down,
right and left. Likewise, the robot can push a box to the upper adjacent cell, to the below
cell, to the cell on the left or to the cell on the right of the box.

The robot can move to a cell in any of the four directions if:
- The destination cell does neither have an obstacle nor a box
- The destination cell is not a warehouse

For pushing a box the robot must be located in a cell adjacent to the box. The robot can
only push the box to a cell that neither has an obstacle nor a box, or to a warehouse. For
example, given the box in position (4,3) in the grid of the figure, the robot:
- can go to cell (5,3) and push the box upwards; the effect of this operation is that both the robot and the box are moved one row up; that is, the robot will end in cell (4,3) and the box in cell (3,3)
- can go to cell (3,3) and push the box downwards; the effect of this operation is that both the robot and the box are moved one row down
- cannot go to the cell on the right of the box because there is an obstacle in such cell
- can go to the cell on the left of the box but then it does not get to push the box because there is an obstacle in the cell on the right of the box

Warehouses have capacity for only one box so that when the robot pushes a box the warehouse becomes full and no more boxes can be stored.

The work to do consists in solving this version of the Sokoban game, using a state-based representation of the problem, with a RBS implemented in CLIPS. The BREADTH and DEPTH search strategies will be used to run the CLIPS program and solve the problem:
1. The program will request the user the maximum depth level of the tree to develop (see example of the 8-puzzle problem)
2. The program will return the depth level and number of generated nodes of the solution found for each execution of the RBS with the search strategies (no need to return the solution path)
3. Use a generic knowledge representation that is easily modifiable. The program should allow changing the grid dimensions, including new obstacles, boxes or warehouses without having to modify the rules.
4. All the initial information can be directly written within the deffacts command
