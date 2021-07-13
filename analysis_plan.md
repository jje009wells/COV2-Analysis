## Analysis Plan

# Plan 1
I am interested in comparing kmers from the sequences from Africa to the sequences from South America. I am interested in looking at the similarity of these sequences to each other and to themselves over time, predicting that as a whole sequences from Africa at the beginning of the pandemic in late 2019 would be more similar to sequences from Africa later in the pandemic than to South American sequences  overall due to the big differences in geographic location. I believe I can make use of kmers to do this, based on some information from https://bioinfologics.github.io/post/2018/09/17/k-mer-counting-part-i-introduction/. I can take kmers from the South America sequences and see if there are more of the same kmers present in the rest of the South America data or the Africa sequences. The more kmers that are shared between the sets of data, the more similar they are. I can do this for varying kmer lengths; longer lengths will indicate more similarity, but also risk being too specific to show potential similarities in smaller sections of sequence. The article suggests a maximim length of around 31 because that is still a manageable number for Int64 to handle. The functions I can make use of are:

- The parse_fasta and parse_header functions, in order to traverse the data from the file
- The kmer composition one from assignment 4
- A function that can compare the sequences from each kmer across groups of data, keeping track of how many kmers early Africa and late Africa data have in common and also how many kmers early Africa and South America have in common

I could present this information using a line plot that records the size of the kmer against the amount of kmers in common for early Africa against late Africa and early Africa against South America. The lines may vary as the kmer sizes do, but lines that are higher up on the graph will obviously indicate more kmers in common and therefore may be indicators that these two groups of data are more similar than the other.

# Plan 2
I am interested in developing a phylogenetic tree of the COVID virus located in Asia from December 2019 to the most current data. I am limiting by these factors in order to try to keep the amount of data that I am analyzing to smaller, easier to work with amount. Based off of research largely from biointeractive.org (https://www.biointeractive.org/classroom-resources/creating-phylogenetic-trees-dna-sequences) and the Oxford University Press youtube (https://www.youtube.com/watch?v=09eD4A_HxVQ), the basic steps to making a tree seem to be:


- Start by finding the sequences with the least amount of differences between them, these can be branched together as most likely to be closely linked
- Then essentially work backwards to compare individual sequences to the ones already graphed, picking the ones with the least differences to add to the graph as you go
- For the entire process, keep in mind that if difference scores are equal at any point, will need to find a way to average them


 Functions that I will need to make use of are:
- A scoring algorithm; I believe I can use Needleman-Wunsch for this by taking the score from the bottom right of the scored matrix as the overall score for the difference between the sequences. A higher number would reflect more similar sequences
- The parse_fasta and parse_header functions from assignment6 to take the data from the file
- A function, possibly with a set of helper functions, to organize and compare the sequences to be put into the tree. I am thinking of using the method described in the video linked above which uses matrices to store the comparisons for each sequence and places sequences in the next available node based on which sequence has the smallest difference between 
- A way to make the actual representation of the tree; it seems there are several package options like PhyloTrees.jl that I could potentially use

The steps to making a phylogenetic tree do make sense to me on paper and with basic examples, but I do worry about the complexity of this with a bigger dataset with longer sequence lengths. Specifically, the video linked above describes comparing all sequences against each other, then finding average distances between them, before figuring out where to place things and seemingly working backwards in the tree. Many different matrices are created and traversed, which really adds up. I could see this being very time consuming and not super efficient, especially for longer sequences, so maybe coming up with a different system that works from a certain starting point might be easier. 
