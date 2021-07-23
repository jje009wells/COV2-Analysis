### A Pluto.jl notebook ###
# v0.14.8

using Markdown
using InteractiveUtils

# ╔═╡ cbb613d0-e913-11eb-0d6c-cb8b7e8c571a
using BioinformaticsBISC195

# ╔═╡ 02f5942b-721a-4e58-bc99-9ca3d6e5bf33
using Plots

# ╔═╡ f52e5561-ee04-4d95-bfce-a8574e7c31d9
md"""
First, I am going to parse each file that contains code specific to each country (Ghana, Egypt, Peru) so that I have each set of genomes available to use. The files were obtained from: [NCBI](https://www.ncbi.nlm.nih.gov/labs/virus/vssi/#/virus?SeqType_s=Nucleotide&VirusLineage_ss=Severe%20acute%20respiratory%20syndrome%20coronavirus%202%20(SARS-CoV-2),%20taxid:2697049&VirusLineage_ss=Middle%20East%20respiratory%20syndrome-related%20coronavirus%20(MERS-CoV),%20taxid:1335626&VirusLineage_ss=Severe%20acute%20respiratory%20syndrome-related%20coronavirus,%20taxid:694009&QualNum_i=50&Completeness_s=complete&CreateDate_dt=2019-12-01T00:00:00.00Z%20TO%202021-07-20T23:59:59.00Z&CollectionDate_dr=2019-12-19T00:00:00.00Z%20TO%202021-07-20T23:59:59.00Z&Country_s=Egypt&Country_s=Ghana&Country_s=Peru)

Each file for each country contains all SARS, COV2, and MERS genomes from Dec 2019 to July 2021, and is parsed using the parse_fasta function from the BioinformaticsBISC195 package.
"""

# ╔═╡ c76fd317-869c-43d1-ad8f-735f13f2da46
genomes_ghana = parse_fasta(joinpath(@__DIR__, "..", "data", "covgen_ghana.fasta"))

# ╔═╡ cdf022a2-ccd4-4746-8008-8c77e29c3950
genomes_egypt = parse_fasta(joinpath(@__DIR__, "..", "data", "covgen_egypt.fasta"))

# ╔═╡ 91ab0a31-cf34-4454-a8a6-3c7a644633dd
genomes_peru = parse_fasta(joinpath(@__DIR__, "..", "data", "covgen_peru.fasta"))

# ╔═╡ dfb58341-dc84-4c37-a729-9e7afef2e5ee
md"""
Now, I want to get collections of all the kmers of a certain length for each country. This combines data all sequences data from each country to attempt to make the data more generalized to the entire country, meaning each kmer in these sets exists every sequence in the country's file.
I initially started with k = 3 as 3mers could represent specific amino acids that certain sequences have in common, but due to the sheer size of the data all 64 possible 3mers are represented in each graph and it is difficult to make comparisons across countries that way or pick out any specifc animo acids. 
I ended up going with 12mers because the larger size has more potential possibilities and therefore the different sets of kmers per country can get more specific, though this not a perfect solution either.
It would be interesting to change the different k lengths and run several tests to see how long and specific the kmers can get, but for these purposes 12 is about the longest I can go before the number of kmer possibilites becomes excessive.
"""

# ╔═╡ 03ec5984-a462-410b-9403-24b4c0e94a21
kmers_allofghana = kmercollecting(genomes_ghana[2], 12)

# ╔═╡ da281e5e-afe7-4fec-a709-424493561783
kmers_allofegypt = kmercollecting(genomes_egypt[2], 12)

# ╔═╡ 24c15bf4-9079-4aa4-97dd-e383a34fc718
kmers_allofperu = kmercollecting(genomes_peru[2], 12)

# ╔═╡ aacf8425-eeae-4f0d-b4b2-5dbd0daf5603
md"""
Now I am going to combine all the arrays for each country into one array of kmers for each country using intersect. This will give a collection that only contains all kmers that every sequences from that country contained, as to narrow now the results when the final across-country comparisons happpen.
"""

# ╔═╡ abeb5ee2-fd2d-4643-90ef-e1b86959ceed
kmers_ghana = intersect(kmers_allofghana...)

# ╔═╡ f5c9f7d4-311c-4545-a0de-d3060d356055
kmers_egypt = intersect(kmers_allofegypt...)

# ╔═╡ 3ab6f125-1735-4188-91e5-e9c87ea02814
kmers_peru = intersect(kmers_allofperu...)

# ╔═╡ 8de6f315-e8b9-4677-be8f-63f632347677
md"""
I was initially going to use a function called kmercombining to get a collection that contains only kmers that exist in Egypt and Ghana, and Egypt and Peru, but then found out a way to just use the preexisting intersect function for the same thing. I can later get the lengths of these to compare how many kmers are in common for each
"""

# ╔═╡ 3652390f-28cb-4497-af79-7b245f78a893
ghana_to_egypt = intersect([kmers_ghana, kmers_egypt]...)

# ╔═╡ 432fce45-9755-4221-a08b-73529b67d1b9
peru_to_egypt = intersect([kmers_peru, kmers_egypt]...)

# ╔═╡ b1a52631-6d3d-4f99-8b2c-7fc4ae15012e
all_countries = intersect([kmers_ghana, kmers_egypt, kmers_peru]...)

# ╔═╡ be6670fa-a026-4838-b2f3-a94eee5c98b1
md"""
Now I want to get the data ready to plot. It will be a bar chart with the count of kmers on the y axis and the x axis that has bars for the number of kmers in common across the entire country for each country, the kmers in common for all countries combined, how many exist only in Egypt and Ghana, and how many exist only in Egypt and Peru.
"""

# ╔═╡ f93f92fa-0e75-47c3-8fce-93c720a38f2e
only_in_ghana = setdiff([kmers_ghana, kmers_egypt, kmers_peru]...)

# ╔═╡ f5beccb9-b9fa-4b42-afd4-c6ffe0857409
only_in_peru = setdiff([kmers_peru, kmers_egypt, kmers_ghana]...)

# ╔═╡ 3e10a923-60da-4db0-b856-de045d1faa5e
only_in_egypt = setdiff([kmers_egypt, kmers_ghana, kmers_peru]...)

# ╔═╡ cf88bfcf-2350-43c2-9136-16fea916ff9a
xaxis = ["Only Ghana", "Only Peru", "Only Egypt", "In All Countries", "Only Ghana and Egypt", "Only Peru and Egypt"]

# ╔═╡ 626de1de-e12a-4e67-9d0c-eed4b9c74d1b
yaxis = [length(only_in_ghana), length(only_in_peru), length(only_in_egypt), length(all_countries), length(ghana_to_egypt), length(peru_to_egypt)]

# ╔═╡ 1eae0dbb-a20d-4daf-ab1b-c1ecc6b4858d
bar(xaxis,yaxis, label = "", xaxis = "Locations", yaxis = "Kmer Count", bar_width = 0.5,size = (900,600))

# ╔═╡ 46c7eda6-98b7-4706-85c8-6922985e8f8a
md"""
Unlike what I predicted, there are actually more kmers that exist only in Peru and Egypt than in Ghana and Egypt.
This implies that geographic region and proximity don't have the only, or at least not the greatest, impact on the mutation and similarity of the virus.
Of course, this data is hard to make conclusions about without also knowing how features like population size and density, disease response, and other factors played out in each country.
It should also be noted that the size of the data sets vary quite a bit;
both Ghana and Peru have around 100-200 total sequences in the fasta, but Egypt has around 700.
The Egypt data's much larger scale could skew the results because the other countries' smaller sample sizes might mean their data does not well represent the country as a whole.
One interesting observation is that Peru, which is the most geographically separated from the other two countries, also has the most unique 12mers of its own. This does suggest to some degree that geographic separation allows for the virus to develop in unique ways, but the process of development and similarity to other virus locations is more complex than simple location on the globe.

"""

# ╔═╡ Cell order:
# ╠═cbb613d0-e913-11eb-0d6c-cb8b7e8c571a
# ╠═02f5942b-721a-4e58-bc99-9ca3d6e5bf33
# ╟─f52e5561-ee04-4d95-bfce-a8574e7c31d9
# ╠═c76fd317-869c-43d1-ad8f-735f13f2da46
# ╠═cdf022a2-ccd4-4746-8008-8c77e29c3950
# ╠═91ab0a31-cf34-4454-a8a6-3c7a644633dd
# ╠═dfb58341-dc84-4c37-a729-9e7afef2e5ee
# ╠═03ec5984-a462-410b-9403-24b4c0e94a21
# ╠═da281e5e-afe7-4fec-a709-424493561783
# ╠═24c15bf4-9079-4aa4-97dd-e383a34fc718
# ╟─aacf8425-eeae-4f0d-b4b2-5dbd0daf5603
# ╠═abeb5ee2-fd2d-4643-90ef-e1b86959ceed
# ╠═f5c9f7d4-311c-4545-a0de-d3060d356055
# ╠═3ab6f125-1735-4188-91e5-e9c87ea02814
# ╟─8de6f315-e8b9-4677-be8f-63f632347677
# ╠═3652390f-28cb-4497-af79-7b245f78a893
# ╠═432fce45-9755-4221-a08b-73529b67d1b9
# ╠═b1a52631-6d3d-4f99-8b2c-7fc4ae15012e
# ╟─be6670fa-a026-4838-b2f3-a94eee5c98b1
# ╠═f93f92fa-0e75-47c3-8fce-93c720a38f2e
# ╠═f5beccb9-b9fa-4b42-afd4-c6ffe0857409
# ╠═3e10a923-60da-4db0-b856-de045d1faa5e
# ╠═cf88bfcf-2350-43c2-9136-16fea916ff9a
# ╠═626de1de-e12a-4e67-9d0c-eed4b9c74d1b
# ╠═1eae0dbb-a20d-4daf-ab1b-c1ecc6b4858d
# ╠═46c7eda6-98b7-4706-85c8-6922985e8f8a
