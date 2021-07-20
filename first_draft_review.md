# Review of Analysis and Code repos

**date**: 2021-07-19

## Review Notes

- See instructions in Pull Request for incorporating changes
- Comments in julia code are preceded with `#`
- Comments in markdown look like this: `<!-- this is a comment -->`
- Comments that require action begin with `TODO`, others are just for information
- You may delete comments inside other files once you've addressed them
- Please keep this file in the repository - you may add your own responses if aplicable.

## Analysis plan

- added some newlines to follow [sembr](http://sembr.org)
- code formatting

## Code repo

https://github.com/jje009wells/BioinformaticsBISC195

- Some tests don't exist or don't pass
  ```
  Test Summary:          | Pass  Fail  Error  Total
  BioinformaticsBISC195  |   41     1      1     43
    Using Strings        |   41     1      1     43
      normalizeDNA       |    5                   5
      composition        |   11                  11
      gc_content         |    3                   3
      complement         |    4                   4
      reverse_complement |    4                   4
      parse_fasta        |                 1      1
      isDNA              |    4                   4
      kmercount          |    4                   4
      kmerdistance       |    3     1             4
      kmercombining      |    3                   3
      monthlycomparisons |                    No tests
  ERROR: LoadError: Some tests did not pass: 41 passed, 1 failed, 1 errored, 0 broken.
  ```
- A bunch of functions are unfinished


## Analysis repo

- Use Markdown cells to more effectively organize / describe what you're doing in notebooks
- separate multiple expressions into multiple cells
- Don't re-write functions in your notebooks. If necessary, show the docstrings
- Neither analysis has plots yet
- Both analyses need more narrative description of what's being done, why, and the results
