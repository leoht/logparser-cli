# Pageviews LogParser

## Usage:
```
ruby main.rb webserver.log
ruby main.rb path/to/logfile.log
```

## Implementation/Design choices:
 - Different components are dependency-injected using constructors
 - `FileReader` expects a block to read the file line by line, allowing to stream from the file
 - `LineParser` will ignore invalid lines, or lines containing invalid ipv4 or ipv6 address
 - `PageviewsAggregator` uses Sets to keep track of unique IPs per path
 - `Service` returns a response object to be passed to the `ConsolePresenter` for rendering
 - `Application` encapsulates CLI app logic and calls service

## Possible improvements
 - Turn into a gem by potentially wrapping Application under the LogParser module
 - Provide advanced CLI options/commands to specify which counters to see

## Design schema

     +--------------------+   +--------------------+  +---------------------+
     |                    |   |                    |  |                     |
     |     FileReader     |   |     LineParser     |  | PageviewsAggregator |
     |                    |   |                    |  |
     +--------------------+   +--------------------+  +---------------------+
               ^                        ^                        ^
               |                        |                        |
               |                        |                        |
               |                        |                        |
               |                        |                        |
               |                        |                        |
               |                        +                        |
               |              +--------------------+             |  +-------------------+
               |              |                    |             |  |                   |
               |              |       Service      |             |  |  ConsolePresenter |
               +--------------+                    +-------------+  |                   |
                              +--------------------+                +-------------------+
                                        ^                                    +
                                        |                                    |
                                        |                                    |
                                        |                                    |
                                        |                                    |
                                        |                                    |
                              +---------+---------+                          |
                              |                   |                          |
                              |    Application    +--------------------------+
                              |                   |
                              +-------------------+