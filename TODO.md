# TODO

## 1. Boot Sector Initialization
- **Task:** Write bootloader code to initialize the boot sector.
  - **Subtasks:**
    - Write the boot signature (0x55AA) at the end of the 512-byte sector.
    - Set up the stack pointer.
    - Initialize the video mode for graphics (e.g., 320x200 256-color mode).

## 2. Graphics Initialization
- **Task:** Set up graphics mode and basic screen drawing functions.
  - **Subtasks:**
    - Write functions to set the video mode.
    - Develop routines for drawing pixels, lines, and basic shapes.

## 3. Main Game Loop
- **Task:** Implement the main game loop structure.
  - **Subtasks:**
    - Create an infinite loop for game execution.
    - Implement timing mechanisms for controlling game speed.

## 4. Player Character (Bird) Mechanics
- **Task:** Develop the bird's movement and physics.
  - **Subtasks:**
    - Write code for bird's upward movement on input (e.g., space bar press).
    - Implement gravity for downward movement.
    - Draw bird sprite on the screen.

## 5. Obstacles (Pipes)
- **Task:** Create obstacles for the bird to navigate through.
  - **Subtasks:**
    - Write functions to generate and move pipes across the screen.
    - Implement collision detection between bird and pipes.

## 6. Scorekeeping
- **Task:** Implement scoring system.
  - **Subtasks:**
    - Write code to increase score when bird passes through pipes.
    - Display score on the screen.

## 7. Game Over Conditions
- **Task:** Define game over state and restart mechanism.
  - **Subtasks:**
    - Detect collision with ground and pipes.
    - Display game over message.
    - Implement restart functionality.


## 10. Code Optimization
- **Task:** Optimize code to fit within the boot sector size limit.
  - **Subtasks:**
    - Minimize code size by refining algorithms.
    - Remove any unnecessary instructions.

## 11. Testing and Debugging
- **Task:** Thoroughly test the game for bugs and performance issues.
  - **Subtasks:**
    - Test on different emulators/virtual machines.
    - Fix any identified issues.
