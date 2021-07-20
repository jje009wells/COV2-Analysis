## Analysis Plan

# Plan 1 v2
I am interested in comparing kmers from the sequences from different parts of Africa to the sequences from South America.
I want to see the similarity of these sequences to each other and to themselves over time, predicting that as a whole sequences from Egpyt
would be more similar to sequences from Ghana than to Peruvian sequences o due to the big differences in geographic proximity.  
I would parse through the Egypt data and store a collection of only the kmers that exist in all of those sequences,
then do the same for both Ghana data and Peru data.
I could make a bar chart, labeled by country, that shows a count of all these kmers per country,
with additional bars that show a count of how many of these kmers exist in all of the countries,
how many exist only in Egypt and Ghana, and how many exist only in Egypt and Peru.
I would guess the number of sequences that exist only in Egpyt and Ghana would be higher than for Egypt and Peru. 

- The `parse_fasta` and `parse_header` functions, in order to traverse the data from the file
- `kmercount`
- A function that can compare the similarities across countries then store all the common kmers for use in the graph (might be able to just use intersect)
- A function from a package that can make a bar graph like this, likely from Makie plots


# Plan 2 v2
I think I might have to change this one completely as I am really struggling with the feasibility of putting together the entire tree.
My laptop has been tending to take minutes to even parse the sequences of this length, so I think it would be very hard for me to run certain tests,
combined with the fact that I'm not sure the current Phylogenetic tree packages that I have seen do all that I would need them to.
I would still like to compare the virus located in Asia from Deceber 2019 to the current data, but instead I am planning on plotting how the virus changes over time.
My plan is to use the first month as a baseline to compare all other months to, and I would score the difference between them using a distance metric, I'm thinking Smith-Waterman.
The x axis would be the months since December 2019, and the y would be the comparison score.
My hypothesis is that as the months pass the sequences would get less and less similar and would be reflected in the graph's trendline.
I would use many of the same functions:

- A scoring algorithm; I am leaning Smith-Waterman for this because I'm not sure if the sequences are already aligned. I can take the max score from the matrix
- The `parse_fasta` and `parse_header` functions from assignment6 to take the data from the file
- A function to actually calculate and store, likely in a vector, the comparisons per month so that they can easily be put into the graph
- A way to represent the plot, using a package like Makie's graphs to create a line plot

