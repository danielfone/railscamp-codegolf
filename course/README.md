# Welcome to Code Golf RCNZ4!

## Objective

Do more with less! Work through the each hole to reduce the code to as few
bytes as possible while still passing the tests.

A few things:

* This is golf, not a security challenge.
    * The infrastructure was hacked together in a week
    * It's trivally easy to break, please don't.
    * Please replace your divots
* Don't feel like you need to do each hole in order
* There are multiple ways to be competitive:
    * Lowest total score
    * Lowest score for a particular hole
    * First team to achieve par on every hole

## Getting Started

* Run `test/score` to ensure you can verify your code locally
* Delete some code
* Run `test/score` again to make sure your code still works
* Commit your changes and push
* ???
* Profit

## Ruby

The server is running ruby 2.1.0. The course should run fine on most other ruby
versions (completely untested) but a few language features useful for golfing
may be version specific.

You shouldn't need any gems.

## Testing Locally

`test/score` will test all the scripts in the holes/ directory.

    $ test/score
    Running 10_lettercount        passed [88 bytes]
    Running 11_most_consonants    passed [460 bytes]
    Running 12_olympics           passed [514 bytes]
    Running 13_anagram            passed [480 bytes]
    Running 14_applify            passed [133 bytes]
    Running 15_palindromes        passed [345 bytes]
    Running 16_cat                passed [83 bytes]
    Running 17_t9                 passed [583 bytes]
    Running 18_password_entropy   passed [4439 bytes]
    Running 1_fizzbuzz            passed [401 bytes]
    Running 2_wordcount           passed [26 bytes]
    Running 3_fibonacci           passed [580 bytes]
    Running 4_99_bottles          passed [955 bytes]
    Running 5_adder               passed [223 bytes]
    Running 6_web2names           passed [875 bytes]
    Running 7_alphabet            passed [60 bytes]
    Running 8_enhance             passed [798 bytes]
    Running 9_grades              passed [349 bytes]
    ----
    Your score: 11392

You can also also pass in path(s) to run a specific hole.

    $ test/score holes/2_wordcount.rb 
    Running 2_wordcount           passed [26 bytes]
    ----
    Your score: 26

The scripts are (almost) all basically unix filters. The test will pipe in 
test/cases/$hole/in.txt and verify that the output matches
test/cases/$hole/out.txt

In some cases you might want to check the output yourself:

    $ cat test/cases/grades/in.txt | ruby holes/9_grades.rb 
    F
    C
    B
    B
    F
    F
    D
    F
    F
    ...

## Pushing

When you push your repo, a post-receive hook will run a canonical test harness
against a different set of test cases. It will then record your score. Although
the test cases are different THEY WILL NOT INTRODUCE DIFFERENT EDGE CASES, at
least, not intentionally. This is probably the fragile part, please be gentle.

## Course Description

The holes are provided without commentary. It's left as an exercise to the
players to work out the purpose and requirements for each hole. Reading the
code and test cases should help.

Good luck.
