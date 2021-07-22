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
First, I am going to parse each file that contains code specific to each country (Ghana, Egypt, Peru) so that I have each set of genomes available to use
"""

# ╔═╡ c76fd317-869c-43d1-ad8f-735f13f2da46
genomes_ghana = parse_fasta(joinpath(@__DIR__, "..", "data", "covgen_ghana.fasta"))

# ╔═╡ cdf022a2-ccd4-4746-8008-8c77e29c3950
genomes_egypt = parse_fasta(joinpath(@__DIR__, "..", "data", "covgen_egypt.fasta"))

# ╔═╡ 91ab0a31-cf34-4454-a8a6-3c7a644633dd
genomes_peru = parse_fasta(joinpath(@__DIR__, "..", "data", "covgen_peru.fasta"))

# ╔═╡ dfb58341-dc84-4c37-a729-9e7afef2e5ee
md"""
Now, I want to get collections of all the kmers of a certain length for each country. I initially started with k = 3 as 3mers could represent specific amino acids that certain sequences have in common, but due to the sheer size of the data all 64 possible 3mers are represented in each graph and it is difficult to make comparisons across countries that way or pick out any specifc animo acids. 
I ended up going with 12mers because the larger size has more potential possibilities and specific kemrs taken from the sequence get more specific, though this not a perfect solution either. 
"""

# ╔═╡ 03ec5984-a462-410b-9403-24b4c0e94a21
begin
	kmers_allofghana = kmercollecting(genomes_ghana[2], 12)
	kmers_allofegypt = kmercollecting(genomes_egypt[2], 12)
	kmers_allofperu = kmercollecting(genomes_peru[2], 12)
end

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
I was initially going to use a function called kmercombining to get a collection that contains only 3mers that exist in Egypt and Ghana, and Egypt and Peru, but then found out a way to just use the preexisting intersect function for the same thing. I can later get the lengths of these to compare how many kmers are in common for each
"""

# ╔═╡ 3652390f-28cb-4497-af79-7b245f78a893
ghana_to_egypt = intersect([kmers_ghana, kmers_egypt]...)

# ╔═╡ 432fce45-9755-4221-a08b-73529b67d1b9
peru_to_egypt = intersect([kmers_peru, kmers_egypt]...)

# ╔═╡ b1a52631-6d3d-4f99-8b2c-7fc4ae15012e
all_countries = intersect([kmers_ghana, kmers_egypt, kmers_peru]...)

# ╔═╡ ad1f1d24-5f22-4d69-9338-cf8c1e1ec188
#=function kmercollecting(set, k)
    kmerdicts = Vector()
	for seq in set
		push!(kmerdicts, collect(keys(kmercount(seq, k))))
	end
	return kmerdicts	
end=#

# ╔═╡ e74a273a-9451-4d09-b68a-796b57bc9245
#=function kmercombining(sets)
	newint = sets[1]
	for kmers in sets
		#@info newint
		newint = intersect(newint, kmers)
	end
	return newint
end=#

# ╔═╡ e32867e2-81fa-4e70-ae11-bdd41c0358ad
# rather than re-write functions in your notebook, you can display the docs
# that you've already written
@doc parse_fasta

# ╔═╡ be6670fa-a026-4838-b2f3-a94eee5c98b1
md"""
Now I want to get the data ready to plot. It will be a bar chart with the count of kmers on the y axis and the x axis that has bars for the number of kmers in common across the entire country for each country, the kmers in common for all countries combined, how many exist only in Egypt and Ghana, and how many exist only in Egypt and Peru.
"""

# ╔═╡ f93f92fa-0e75-47c3-8fce-93c720a38f2e
begin
	only_in_ghana = setdiff([kmers_ghana, kmers_egypt, kmers_peru]...)
	only_in_peru = setdiff([kmers_peru, kmers_egypt, kmers_ghana]...)
	only_in_egypt = setdiff([kmers_egypt, kmers_ghana, kmers_peru]...)
end

# ╔═╡ cf88bfcf-2350-43c2-9136-16fea916ff9a
begin
	xaxis = ["Only Ghana", "Only Peru", "Only Egypt", "In All Countries", "Only Ghana and Egypt", "Only Peru and Egypt"]
	yaxis = [length(only_in_ghana), length(only_in_peru), length(only_in_egypt), length(all_countries), length(ghana_to_egypt), length(peru_to_egypt)]
end

# ╔═╡ 1eae0dbb-a20d-4daf-ab1b-c1ecc6b4858d
bar(xaxis,yaxis, label = "", xaxis = "Locations", yaxis = "Kmer Count", bar_width = 0.5,size = (920,600))

# ╔═╡ Cell order:
# ╠═cbb613d0-e913-11eb-0d6c-cb8b7e8c571a
# ╠═02f5942b-721a-4e58-bc99-9ca3d6e5bf33
# ╟─f52e5561-ee04-4d95-bfce-a8574e7c31d9
# ╠═c76fd317-869c-43d1-ad8f-735f13f2da46
# ╠═cdf022a2-ccd4-4746-8008-8c77e29c3950
# ╠═91ab0a31-cf34-4454-a8a6-3c7a644633dd
# ╟─dfb58341-dc84-4c37-a729-9e7afef2e5ee
# ╠═03ec5984-a462-410b-9403-24b4c0e94a21
# ╟─aacf8425-eeae-4f0d-b4b2-5dbd0daf5603
# ╠═abeb5ee2-fd2d-4643-90ef-e1b86959ceed
# ╠═f5c9f7d4-311c-4545-a0de-d3060d356055
# ╠═3ab6f125-1735-4188-91e5-e9c87ea02814
# ╟─8de6f315-e8b9-4677-be8f-63f632347677
# ╠═3652390f-28cb-4497-af79-7b245f78a893
# ╠═432fce45-9755-4221-a08b-73529b67d1b9
# ╠═b1a52631-6d3d-4f99-8b2c-7fc4ae15012e
# ╠═ad1f1d24-5f22-4d69-9338-cf8c1e1ec188
# ╠═e74a273a-9451-4d09-b68a-796b57bc9245
# ╠═e32867e2-81fa-4e70-ae11-bdd41c0358ad
# ╟─be6670fa-a026-4838-b2f3-a94eee5c98b1
# ╠═f93f92fa-0e75-47c3-8fce-93c720a38f2e
# ╠═cf88bfcf-2350-43c2-9136-16fea916ff9a
# ╠═1eae0dbb-a20d-4daf-ab1b-c1ecc6b4858d
