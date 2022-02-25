# Seating Algorithm - Airplane

A program that helps seat audiences in a flight based on the following input and rules.

**Rules for seating**

1. Always seat passengers starting from the front row to back, starting from the left to the right
2. Fill aisle seats first followed by window seats followed by center seats (any order in center seats)

**Input to the program will be**

1. A 2D array that represents the columns and rows - Ex. [[3,4], [4,5], [2,3], [3,4]]
2. Number of passengers waiting in the queue.

### Demo
```
$ ruby main.rb
Input a 2D array that represents the columns and rows - Ex. [[3,2], [4,3], [2,3], [3,4]]:
[[3,2], [4,3], [2,3], [3,4]]
Input number of passengers waiting in the queue:
30

Seating Arrangement
19  25  1       2   26  27  3       4   5       6   28  20
21  29  7       8   30      9       10  11      12      22
                13          14      15  16      17      23
                                                18      24
```

## Running

### Local

Install dependencies:

    $ bundle install

Just run:

	$ ruby main.rb

## Tests

    $ rake
    Run options: --seed 37373

	# Running:

	.........

    Fabulous run in 0.002558s, 3518.3732 runs/s, 9382.3285 assertions/s.

    9 runs, 24 assertions, 0 failures, 0 errors, 0 skips
