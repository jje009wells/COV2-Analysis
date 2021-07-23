### A Pluto.jl notebook ###
# v0.14.8

using Markdown
using InteractiveUtils

# ╔═╡ ac9a9a63-808b-4353-b55c-e9e27414f3ed
using BioinformaticsBISC195

# ╔═╡ 8699ff31-b4ed-4f74-ad90-f11a0c1bb024
using Plots

# ╔═╡ 31bb927a-c189-485b-8888-622baec1b594
md"""
First I have to collect the data for all sequences in asia from the covgen_asia.fasta file.

I downloaded the files from the following website, making sure to add the collection date as part of the header:
[NCBI](https://www.ncbi.nlm.nih.gov/labs/virus/vssi/#/virus?SeqType_s=Nucleotide&VirusLineage_ss=Severe%20acute%20respiratory%20syndrome%20coronavirus%202%20(SARS-CoV-2),%20taxid:2697049&VirusLineage_ss=Middle%20East%20respiratory%20syndrome-related%20coronavirus%20(MERS-CoV),%20taxid:1335626&VirusLineage_ss=Severe%20acute%20respiratory%20syndrome-related%20coronavirus,%20taxid:694009&QualNum_i=50&Completeness_s=complete&CreateDate_dt=2019-12-01T00:00:00.00Z%20TO%202021-07-20T23:59:59.00Z&CollectionDate_dr=2019-12-19T00:00:00.00Z%20TO%202021-07-20T23:59:59.00Z&Region_s=Asia)

The data consists of all SARS, COV2, and MERS sequences from all of Asia from Dec 2019 to July 2021.
The data is parsed using the parse_fasta function that stores both the headers and the sequences themselves.
"""

# ╔═╡ bcfd3636-b637-4422-8e76-d57e8a3f51d9
genomes_asia = parse_fasta(joinpath(@__DIR__, "..", "data", "covgen_asia.fasta"))

# ╔═╡ bdc8235b-e5e3-4ac8-a32d-ec8352bf7a3b
md"""
startingSeq is the very first sequence I am using, from Dec 2019, that will be compared against the other sequences each month to see how the sequence changes over time. The very first entry in the fasta file happens to be the first date needed, so there was no need to do any special search for it.
"""

# ╔═╡ 9e89e7d1-36ff-4337-b57d-769cf5aaed3e
startingSeq = genomes_asia[2][1]

# ╔═╡ 88756434-059e-4335-a34c-7947a7571625
md"""
Now the final calculations can be performed sing the monthlycomparison function. I initally wanted to make the total months be closer to 16 in order to get more data, but that ended up being very time and memory consuming so I cut it down to 12 in order to get a full year minimum in. To make things more efficient in a future version I would not use Smith-Waterman scoring, but it was interesting to see how the algorithm comparison system that we coded our selves works with real data.
"""

# ╔═╡ a745b6cd-9db9-4caf-869f-bab219f61020
monthly_scores = monthlycomparison(startingSeq, genomes_asia, 12)

# ╔═╡ ef66799f-63c2-4bee-96b5-0bca9e614db8
md"""
Now I am going to make a scatter plot where the x axis is months since Dec 2019 and the y axis is the Smith-Waterman score for that month.
I predict the scores will gradually decrease as the months pass because a lower SW score indicates less similarity, and as the virus mutates and develops it will get less and less similar to the original strand from Dec 2019.
"""

# ╔═╡ fce9f89f-8573-483e-816a-e8930ba8d79b
plot([1:12], monthly_scores, label = "", xaxis = "Months Since December 2019", yaxis = "Smith-Waterman Score", lw = 2, markershape = :circle)

# ╔═╡ 6a505319-edb4-4c6d-b716-a84539d1a99f
md"""
It is difficult to determine a conclusive trend for the graph, though there are a few areas where there is a brief downward trend (from months 2-10 with score spikes/outliers at months 6 and 9).
It is important to note the scale of the graph- the scores have a range of around 300, which seems like a big range for a data set of this size. 
However, this is a rather limited sample of only one sequence per month being tested for an entire continent, ignoring the distinctions that may exist between individual countries, and also only encompasses one year, so it is not a very accurate representation of the data as a whole.
It would be interesting to see if this trend continues for future months, or how it compares to different scoring algorithms or a more comprehensive method of scoring across many sequences.
"""

# ╔═╡ Cell order:
# ╠═ac9a9a63-808b-4353-b55c-e9e27414f3ed
# ╠═8699ff31-b4ed-4f74-ad90-f11a0c1bb024
# ╟─31bb927a-c189-485b-8888-622baec1b594
# ╠═bcfd3636-b637-4422-8e76-d57e8a3f51d9
# ╟─bdc8235b-e5e3-4ac8-a32d-ec8352bf7a3b
# ╠═9e89e7d1-36ff-4337-b57d-769cf5aaed3e
# ╟─88756434-059e-4335-a34c-7947a7571625
# ╠═a745b6cd-9db9-4caf-869f-bab219f61020
# ╟─ef66799f-63c2-4bee-96b5-0bca9e614db8
# ╠═fce9f89f-8573-483e-816a-e8930ba8d79b
# ╟─6a505319-edb4-4c6d-b716-a84539d1a99f
