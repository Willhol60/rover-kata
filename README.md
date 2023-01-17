# Source: http://dallashackclub.com/rover

# Develop an API that moves a rover around on a grid.
# * You are given the initial starting point (x,y) of a rover and the direction (N,S,E,W) it is facing.
# * - The rover receives a character array of commands.
# * - Implement commands that move the rover forward/backward (f,b).
# * - Implement commands that turn the rover left/right (l,r).
# * - Implement wrapping from one edge of the grid to another. (planets are spheres after all)
# * - Implement obstacle detection before each move to a new square.
# * - If a given sequence of commands encounters an obstacle, the rover moves up to the last possible point and reports the obstacle.


Clone the repository and run.

## Run

Go to the program directory and Run. This program uses OptionParser to take inputs from the Command Line.
- The position (--p) and obstacles (--o) should both be given as single-digit coordinates (xy - or xyxy for multiple obstacles).
- The sphere's size (--s) should be given as a single digit which will apply to the x and y coordinates (as spheres as symmetrical)
- The direction should be one of N, E, S, W.
- The commands should include F (forwards), B (backwards), L (turn left), R (turn right), U(undo last move).


```ruby
ruby app/run_rover.rb --p 37 --d N --o 36 --c LFLFLFLFU
```

To run specs

```ruby
rspec
```

NEXT STEPS
- validators for user input
- allow for coordinates to be double digit
- clean up 'check_for_boundaries' method in navigator.rb

