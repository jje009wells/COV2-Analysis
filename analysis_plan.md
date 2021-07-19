## Analysis Plan

# Plan 1 v2
I am interested in comparing kmers from the sequences from Africa to the sequences from South America. I am interested in looking at the similarity of these sequences to each other and to themselves over time, predicting that as a whole sequences from Africa at the beginning of the pandemic in late 2019 would be more similar to sequences from Africa later in the pandemic than to South American sequences  overall due to the big differences in geographic location. I think I will make use of the kmer distance function this time to determine differences between two groups of sequences. I believe I can take kmers from the South America sequences and compare kmerdistances to see how the kmer compositions change from group to group. I would make the x axis the different kmer counts, starting at 3, and the y axis would be the kmerdistance score. There would be two data plots, one that compars the early Africa data to late Africa data, and one that compares early Africa data to South American data. The trendlines can help visualize how the numbers change over time and which distance scores are higher by the end of the data. I am using different kmer lengths because I do not know how similar these sequences will actually be; if I start with lengths of 3 I might get a feel for how many amino acid sequences they have in common, but that is not very specific or descriptive since certain amino acids might appear in any genome. I am curious to see how big the kmers van get before I start to see a big change in the kmerdistance scores.

- The parse_fasta and parse_header functions, in order to traverse the data from the file
- The kmer composition one from assignment 4
- kmerdistance
- A function that can store the kmerdistance scores alongside the legnths in a vector, to easily be put into a graph
- Aa function from a package that can make a line plot like this, likely from Makie plots


# Plan 2 v2
I think I might have to change this one completely as I am really struggling with the feasibility of putting together the entire tree. My laptop has been tending to take minutes to even parse the sequences of this length, so I think it would be very hard for me to run certain tests, combined with the fact that I'm not sure the current Phylogenetic tree packages that I have seen do all that I would need them to. I would still like to compare the virus located in Asia from Deceber 2019 to the current data, but instead I am planning on plotting how the virus changes over time. My plan is to use the first month as a baseline to compare all other months to, and I would score the difference between them using a distance metric, I'm thinking Smith-Waterman. The x axis would be the months since December 2019, and the y would be the comparison score. My hypothesis is that as the months pass the sequences would get less and less similar and would be reflected in the graph's trendline. I would use many of the same functions:
- A scoring algorithm; I am leaning Smith-Water for this because I'm not sure if the sequences are already aligned. I can take the max score from the matrix
- The parse_fasta and parse_header functions from assignment6 to take the data from the file
- A function to actually calculate and store, likely in a vector, the comparisons per month so that they can easily be put into the graph
- A way to represent the plot, using a package like Makie's graphs to create a line plot

