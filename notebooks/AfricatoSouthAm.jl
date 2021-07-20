### A Pluto.jl notebook ###
# v0.14.8

using Markdown
using InteractiveUtils

# ╔═╡ cbb613d0-e913-11eb-0d6c-cb8b7e8c571a
using BioinformaticsBISC195

# ╔═╡ f52e5561-ee04-4d95-bfce-a8574e7c31d9
# first I am going to parse each file that contains code specific to each country Ghana, Egypt, Peru so that I have each set of genomes available to use

# ╔═╡ c76fd317-869c-43d1-ad8f-735f13f2da46
begin
	genomes_ghana = parse_fasta(joinpath(@__DIR__, "..", "data", "covgen_ghana.fasta"))
	genomes_egypt = parse_fasta(joinpath(@__DIR__, "..", "data", "covgen_egypt.fasta"))
	genomes_peru = parse_fasta(joinpath(@__DIR__, "..", "data", "covgen_peru.fasta"))
end

# ╔═╡ dfb58341-dc84-4c37-a729-9e7afef2e5ee
# now I want to get collections of all the kmers of a certain length (am using k = 3 for now) for each country

# ╔═╡ 8de6f315-e8b9-4677-be8f-63f632347677
# now I will use kmercombining to get a collection that contains only 3mers that exist in Egypt and Ghana, and Egypt and Peru. I can later get the lengths of these to compare how many kmers are in common for each

# ╔═╡ ad1f1d24-5f22-4d69-9338-cf8c1e1ec188
function kmercollecting(set, k)
    kmerdicts = Vector()
	for seq in set
		push!(kmerdicts, collect(keys(kmercount(seq, k))))
	end
	return kmerdicts	
end

# ╔═╡ 03ec5984-a462-410b-9403-24b4c0e94a21
begin
	kmers_ghana = kmercollecting(genomes_ghana[2], 3)
	kmers_egypt = kmercollecting(genomes_egypt[2], 3)
	kmers_peru = kmercollecting(genomes_peru[2], 3)
end

# ╔═╡ e74a273a-9451-4d09-b68a-796b57bc9245
function kmercombining(sets)
	newint = sets[1]
	for kmers in sets
		#@info newint
		newint = intersect(newint, kmers)
	end
	return newint
end

# ╔═╡ 3652390f-28cb-4497-af79-7b245f78a893
begin
	kmercombining([kmers_ghana, kmers_egypt])
	kmercombining([kmers_peru, kmers_egypt])
end

# ╔═╡ Cell order:
# ╠═cbb613d0-e913-11eb-0d6c-cb8b7e8c571a
# ╠═f52e5561-ee04-4d95-bfce-a8574e7c31d9
# ╠═c76fd317-869c-43d1-ad8f-735f13f2da46
# ╠═dfb58341-dc84-4c37-a729-9e7afef2e5ee
# ╠═03ec5984-a462-410b-9403-24b4c0e94a21
# ╠═8de6f315-e8b9-4677-be8f-63f632347677
# ╠═3652390f-28cb-4497-af79-7b245f78a893
# ╠═ad1f1d24-5f22-4d69-9338-cf8c1e1ec188
# ╠═e74a273a-9451-4d09-b68a-796b57bc9245
