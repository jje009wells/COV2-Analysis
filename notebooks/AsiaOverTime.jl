### A Pluto.jl notebook ###
# v0.14.8

using Markdown
using InteractiveUtils

# ╔═╡ ac9a9a63-808b-4353-b55c-e9e27414f3ed
using BioinformaticsBISC195

# ╔═╡ 1c40fe75-627d-43de-8d59-1a34cf82399a
# as I was writing this function, I realized it would also be helpful to have a function that gives an easier way of deconstructing the header and particular picking out the important parts of the date description

# ╔═╡ 8caeb780-e92e-11eb-35b2-7d9a19f314cd
function monthlycomparison(original, allSeq)
    score = Vector() # each index of vector will tell how many months have passed in Dec 19, can use this in the graph I think
	monthsPassed = 0 #keeps track of the months that have passed since Dec 2019 in the scores vector
	prevMonth = 12
	prevYear = 2019
	#maybe do a thing where if months passed is a multiple of 12, then reset the current year? use months passed to help handle the issue with the change of the year
    for seq in allSeq
		currentMonth = parse(Int64, seq[2][6:7])
		currentYear = parse(Int64, seq[2][1:4])
		@info "current month $currentMonth"
		@info "current year $currentYear"
        if currentMonth + 1 == prevMonth  # check the month and year here, will have to parse headers
            push!(score, maximum(swscorematrix(original, seq)))
		end
	end
end

# ╔═╡ 919a7a78-0a07-4776-a407-f4a0e94cecfe
#testing the best way to break up the headers

# ╔═╡ aff348a5-04f9-4d7c-a596-afb46309af04
begin
	genomes_peru = parse_fasta(joinpath(@__DIR__, "..", "data", "covgen_peru.fasta"))
	headers_peru = fasta_header(genomes_peru[1][1])
	
end

# ╔═╡ ebf42cb1-2fb6-4f4c-8814-e9bd771dcfa2
monthlycomparison("AGGT", genomes_peru)

# ╔═╡ Cell order:
# ╠═ac9a9a63-808b-4353-b55c-e9e27414f3ed
# ╠═1c40fe75-627d-43de-8d59-1a34cf82399a
# ╠═8caeb780-e92e-11eb-35b2-7d9a19f314cd
# ╠═919a7a78-0a07-4776-a407-f4a0e94cecfe
# ╠═aff348a5-04f9-4d7c-a596-afb46309af04
# ╠═ebf42cb1-2fb6-4f4c-8814-e9bd771dcfa2
