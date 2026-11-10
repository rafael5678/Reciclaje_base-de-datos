# Lab

`lab_attempts` stores each throw:

- `correct` whether the bin matched
- `delta` 0 on a hit, -5 on a miss
- ranking is `max(0, scan_points + sum(delta))`

Scan history is not rewritten.
