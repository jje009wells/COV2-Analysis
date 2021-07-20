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
- A number of functions are pretty inefficient.
  - use typed arrays (eg `String[]` for kmers instead of `[]`)
  - try not to cycle through lots of different collection types (Dicts -> Sets -> vectors etc),
    try to stick with one from the beginning. Eg

    ```julia
    julia> seqs = [join(rand("ACGT", 20)) for _ in 1:10000];
    
    julia> @benchmark kmercollecting($seqs, 3) # current version
    BenchmarkTools.Trial: 55 samples with 1 evaluation.
     Range (min … max):  86.472 ms … 97.356 ms  ┊ GC (min … max): 3.73% … 7.69%
     Time  (median):     90.552 ms              ┊ GC (median):    6.58%
     Time  (mean ± σ):   91.072 ms ±  2.667 ms  ┊ GC (mean ± σ):  6.86% ± 2.22%
    
              ▁  ▁▁▁  ▄ ▁▄▄     ▁ ▄ █▁  ▁         ▁          ▁
      ▆▁▁▁▆▁▁▆█▁▆███▆▆█▁███▆▁▆▆▁█▁█▆██▁▆█▁▁▁▁▁▁▁▁▁█▆▆▁▁▁▁▆▁▆▆█▆▁▆ ▁
      86.5 ms         Histogram: frequency by time        96.4 ms <
    
     Memory estimate: 48.94 MiB, allocs estimate: 799987.
    
    julia> function kmercollecting2(seqs, n) # new version
               map(seqs) do seq
                   Set(seq[i:(i+n-1)] for i in 1:(length(seq)-n+1))
               end
           end
    kmercollecting2 (generic function with 1 method)
    
    julia> @benchmark kmercollecting2($seqs, 3)
    BenchmarkTools.Trial: 403 samples with 1 evaluation.
     Range (min … max):  10.016 ms … 68.695 ms  ┊ GC (min … max):  0.00% … 80.71%
     Time  (median):     10.701 ms              ┊ GC (median):     0.00%
     Time  (mean ± σ):   12.428 ms ±  4.481 ms  ┊ GC (mean ± σ):  13.73% ± 15.09%
    
      ▄▇█▆▅▂▁                ▁ ▁  ▁  ▁▁   ▁▂
      ███████▄▅▅▄▄▁▅▄▁▅▆█▆█▅▇█▆█▆███▆████▇██▄▁▅▁▁▅▁▄▁▁▁▁▁▁▁▁▁▁▁▁▄ ▇
      10 ms        Histogram: log(frequency) by time      21.5 ms <
    
     Memory estimate: 13.28 MiB, allocs estimate: 250005.
    ```
    
    that is, a 9x speed-up, using 1/4 of the memory
- 

## Analysis repo

- Use Markdown cells to more effectively organize / describe what you're doing in notebooks
- separate multiple expressions into multiple cells
- Don't re-write functions in your notebooks. If necessary, show the docstrings
- Neither analysis has plots yet
- Both analyses need more narrative description of what's being done, why, and the results
