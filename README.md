# Fill the canvas

## Basic command line canvas editor simulator

- M x N matrix of pixels representing the canvas
- Each element represents a colour
- Command line instructions as per below

### Getting started

Clone the repo, navigate to the root directory and run `bundle install` to get started.

To use the program run `ruby bin/run.rb`.

### Commands

`X` :- Exits the program.

`I M N` :- Initiates a new matrix M x N in size with all elements white (O).

`L X Y C` :- Colours pixel (x,y) with colour C.

`C` :- Clears the canvas, all pixels set back to white (O).

`S` :- Shows the current canvas.

`V X Y1 Y2 C` :- Colours a vertical line of pixels in column X between rows Y1 and Y2 inclusive, in colour C

Example:

```
> I 5 6
> L 2 3 A
> S
OOOOO
OOOOO
OAOOO
OOOOO
OOOOO
OOOOO
> C
> S
OOOOO
OOOOO
OOOOO
OOOOO
OOOOO
OOOOO
```
### User stories

- As a user I want to be able to quit the program
- As a user, I want to be able to create a new canvas of any size I choose (up to 250 x 250).
- As a user, I want to be able to see my canvas.
- As a user, I want to be able to change the colour of individual pixels.
- As a user, I want to be able to reset my canvas.
- As a user, I want to be able to draw a vertical line in a column of my choice stretching between the rows I choose.
- As a user, I want to be able to draw a horizontal line in a row of my choice stretching between the columns I choose.
- As a user, I want to be able to see in program help.

### Code design

- Initial confusion - the M x N matrix in the example in the brief is not written as per conventional matrix reference - M refers to columns and N to rows. `I 5 6` asks to create a canvas with 5 columns and 6 rows, NOT 5 rows and 6 columns.
- I went with creating 2d arrays to represent the canvas as opposed to a matrix, as the latter are immutable in Ruby.
- I push the values for M and N to an array called `canvas_size`. These values are used to limit the acceptable pixel choice when using the `L X Y C` command.

### Edge cases

`I M N` command
- Although not ruled out by the `create_canvas` method, in practice it is not possible to create a canvas more than 250 x 250 or less than 1 x 1 as entering a number more than 250 or less than 1 for either argument leads to an "invalid command" response due to the conditions on the command `I`. These conditions also rule out other data types.
- Any extra arguments placed after the `N` argument will lead to an "invalid command" response.

`S` command
- If no canvas has been created, an error message is displayed asking the user to create one first.

`L X Y C` command
- If no canvas has been created, an error message is displayed asking the user to create one first.
- Although not ruled out by the `colour_pixel` method, in practice it is not possible to change the colour of a chosen pixel outside of the boundary of the current canvas. This is due to the conditions when inputting the `L` command and its arguments.
- Any extra arguments placed after the `C` argument will lead to an "invalid command" response.

`C` command
- If no canvas has been created, an error message is displayed asking the user to create one first.

`V X Y1 Y2 C` command
- If no canvas has been created, an error message is displayed asking the user to create one first.
- Although not ruled out by the `draw_vertical_line` method, in practice it is not possible to draw a line outside of the boundary of the current canvas. This is due to the conditions set when inputting the `V` command and its arguments.
- It is also not possible to input the rows such that the value of `Y1` is higher than the value of `Y2`, e.g., `V 2 4 1 Z`, again due to the conditions in the relevant `elsif` statement.

### Unresolved edge case

- When inputting commands which take more than one argument (e.g., `I M N`) extra spaces before, between and after the characters (e.g., <code>&nbsp;&nbsp;I&nbsp;&nbsp;&nbsp;M&nbsp;&nbsp;N&nbsp;&nbsp;</code>) do not invoke an "invalid command" response. I chose not to resolve this as it has no impact on the functionality of the program, only unnecessarily guarding against a mistakenly inputted empty space.
