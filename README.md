# Fill the canvas

## Basic command line canvas editor simulator

- M x N matrix of pixels representing the canvas
- Each element represents a colour
- Command line instructions as per below

### Getting started

Clone the repo, navigate to the root directory and run `bundle install` to get started.

To use the program run `ruby bin/run.rb`.

### Commands

`I M N` :- Initiates a new matrix M x N in size with all elements white (O).

`L X Y C` :- Colours pixel (x,y) with colour C.

`C` :- Clears the canvas, all pixels set back to white (O).

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
> S
OOOOO
OOOOO
OOOOO
OOOOO
OOOOO
OOOOO
```
### User stories

- As a user, I want to be able to create a new canvas of any size I choose.
- As a user, I want to be able to see my canvas.
- As a user, I want to be able to change the colour of individual pixels.
- As a user, I want to be able to reset my canvas.

### Code design

- I went with creating 2d arrays to represent the canvas as opposed to a Matrix as the latter are immutable.
