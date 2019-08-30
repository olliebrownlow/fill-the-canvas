# Fill the canvas

### Basic command line canvas editor simulation

- M x N matrix of pixels representing the canvas
- Each element represents a colour
- Command line instructions

#### Commands

`I M N` :- Initiates a new matrix M x N in size with all elements white (O).

`C` :- Clears the canvas, all pixels set back to white (O).

`L X Y C` :- Colours pixel (x,y) with colour C.

`S` :- Shows the current canvas.

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
OOOOO
OOOOO
OOOOO
OOOOO
OOOOO
OOOOO
```
