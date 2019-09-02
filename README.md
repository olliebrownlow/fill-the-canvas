# Fill the canvas

## Basic command line canvas editor simulator

- M x N matrix of pixels representing the canvas
- Each element represents a colour
- Command line instructions as per below

### Getting started

Clone the repo, navigate to the root directory and run `bundle install`.

To use the program run `ruby bin/run.rb`.

### Commands

`X` :- Exits the program.

`I M N` :- Initiates a new matrix M x N in size with all elements white (O).

`L X Y C` :- Colours pixel (x,y) with colour C.

`C` :- Clears the canvas, all pixels set back to white (O).

`S` :- Shows the current canvas.

`V X Y1 Y2 C` :- Colours a vertical line of pixels in column X between rows Y1 and Y2 inclusive, in colour C

`H X1 X2 Y C` :- Colours a horizontal line of pixels in row Y between columns X1 and X2 inclusive, in colour C

`F X Y C` :- Fills a region R with the colour C, where pixel (X,Y) is in R and any other pixel the same colour as (X,Y) and sharing a common side with any pixel in R also belongs to R.

`W F` :- Scales the canvas by the given factor F in percentage.

Example:

```
> I 3 3
> L 2 2 A
> S
OOO
OAO
OOO
> C
> S
OOO
OOO
OOO
> F 1 1 A
> S
AAA
AAA
AAA
> W 200
> S
OOOAAA
OOOAAA
OOOAAA
OOOOOO
OOOOOO
OOOOOO
> H 1 6 3 Z
> S
OOOAAA
OOOAAA
ZZZZZZ
OOOOOO
OOOOOO
OOOOOO
> V 3 3 6 G
> S
OOOAAA
OOOAAA
ZZGZZZ
OOGOOO
OOGOOO
OOGOOO
```
`?` :- Shows in program help
### User stories

- As a user, I want to be able to quit the program
- As a user, I want to be able to create a new canvas of any size I choose (up to 250 x 250).
- As a user, I want to be able to see my canvas.
- As a user, I want to be able to change the colour of individual pixels.
- As a user, I want to be able to reset my canvas.
- As a user, I want to be able to draw a vertical line in a column of my choice stretching between the rows I choose.
- As a user, I want to be able to draw a horizontal line in a row of my choice stretching between the columns I choose.
- As a user, I want to be able to fill regions of the same colour in other colours
- As a user, I want to be able to scale my canvas up and down by factors written in percentages.
- As a user, I want to be able to see in-program help.

### Code design

- I went with creating 2d arrays to represent the canvas as opposed to a matrix, a string or a simple list. I decided against matrices as they are immutable in Ruby, and I felt that 2d arrays are visually closer to the canvases being created by the user so preferred to work with them over the other two options.
- I pushed the values for M and N to an array called `canvas_dimensions`. These values are used to limit acceptable argument values for many of the commands and are particularly important for the scaling command where they are also updated.
- I separated the colour individual pixel method into another class as all other methods that change pixel colour do so using this method.
- I decided to use a single method, the `colour_pixel` method, to implement all other painting pixel methods - fill, draw vertical line and draw horizontal line.
- Scaling (`W` command) by greater than 100% means adding rows and columns while scaling below 100% means potentially deleting rows and columns. When scaling up, I decided to round up, where necessary, the number of rows and columns to add, but round down for deleting. The difference is only really noticeable for small canvases. For any canvas just one row or one column wide, rounding up when deleting could delete the entire canvas, which might be undesirable. Conversely, rounding down number of rows and columns to add when scaling up a small canvas may be undesirable too - after all, why would a user scale up in the first place if not for a bigger canvas?

### Edge cases

`I M N` command
- Although not ruled out by the `create_canvas` method, in practice it is not possible to create a canvas more than 250 x 250 or less than 1 x 1 as entering a number more than 250 or less than 1 for either argument leads to an "invalid command" response due to the conditions on the command `I`. These conditions also rule out other data types.
- Any extra arguments placed after the `N` argument will lead to an "invalid command" response.

`S` command
- If no canvas has been created, an error message is displayed asking the user to create one first.
- Any extra arguments placed after the `S` argument will lead to an "invalid command" response.

`L X Y C` command
- If no canvas has been created, an error message is displayed asking the user to create one first.
- Although not ruled out by the `colour_pixel` method, in practice it is not possible to change the colour of a chosen pixel outside of the boundary of the current canvas. This is due to the conditions when inputting the `L` command and its arguments.
- Any extra arguments placed after the `C` argument will lead to an "invalid command" response.

`C` command
- If no canvas has been created, an error message is displayed asking the user to create one first.
- Any extra arguments placed after the `C` argument will lead to an "invalid command" response.

`V X Y1 Y2 C` command
- If no canvas has been created, an error message is displayed asking the user to create one first.
- Although not ruled out by the `draw_vertical_line` method, in practice it is not possible to draw a line outside of the boundary of the current canvas. This is due to the conditions set when inputting the `V` command and its arguments.
- It is also not possible to input the rows such that the value of `Y1` is higher than the value of `Y2`, e.g., `V 2 4 1 Z`, again due to the conditions in the relevant `elsif` statement.

`H X1 X2 Y C` command
- If no canvas has been created, an error message is displayed asking the user to create one first.
- Although not ruled out by the `draw_horizontal_line` method, in practice it is not possible to draw a line outside of the boundary of the current canvas. This is due to the conditions set when inputting the `H` command and its arguments.
- It is also not possible to input the columns such that the value of `X1` is higher than the value of `X2`, e.g., `H 4 2 2 Z`, again due to the conditions in the relevant `elsif` statement.

`F X Y C` command
- The program will enter into an infinite loop if pixel (X,Y) is the same colour as the one chosen in the C argument (where the original colour is equal to the new colour). I have therefore ruled this out.
- If no canvas has been created, an error message is displayed asking the user to create one first.
- Although not ruled out by the `fill` method, in practice it is not possible to fill a region by choosing a pixel not inside the current canvas. This is due to the conditions when inputting the `F` command and its arguments.
- Any extra arguments placed after the `C` argument will lead to an "invalid command" response.

`W F` command
- If no canvas has been created, an error message is displayed asking the user to create one first.
- Only percentages over 1 can be entered.
- Any extra arguments placed after the `F` argument will lead to an "invalid command" response.

### Unresolved edge case

- When inputting commands which take more than one argument (e.g., `I M N`) extra spaces before, between and after the characters (e.g., <code>&nbsp;&nbsp;I&nbsp;&nbsp;&nbsp;M&nbsp;&nbsp;N&nbsp;&nbsp;</code>) do not invoke an "invalid command" response. I chose not to resolve this as it has no impact on the functionality of the program, only unnecessarily guarding against a mistakenly inputted empty space.

### If I started over..

Towards the end of writing the code I thought of a different implementation in which, instead of holding a canvas in state, mutating it with each command, you could store each command that operates on the canvas in a list and execute them in order only after calling show (`S`). The clear command then becomes trivial - simply delete the list of instructions - and it would have the added bonus of being able to incorporate an undo function (delete the last instruction in the list).
