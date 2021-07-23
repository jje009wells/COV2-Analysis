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

# ╔═╡ 00e96e55-c2e2-460d-b9d1-035af4f93e2c
function monthlycomparison2(original, allSeq, totalMonths)
	dates = Vector{String}()
	for headers in allSeq[1]
		header = fasta_header(string(">", headers))
		push!(dates, header[2][1:7])
		#@info dates
	end
	@info "2021-02" in dates
	@info length(dates)
	@info length(allSeq[1])
	
	#filling out dateIndices to hold ints that represent the indices of the next correct sequences to grab
	dateIndices = Vector()
	targetMonth = 1
	targetYear = 2020
	totalMonths = 16
	for i in 1:totalMonths
		targetString = string(targetYear, "-", lpad(targetMonth,2,"0"))
		@info targetString
		@info findfirst(targetString .== dates)
		push!(dateIndices, findfirst(targetString .== dates))
		if targetMonth == 12
			targetMonth = 1
			targetYear = targetYear+1
		else
			targetMonth = targetMonth+1
		end
	end
	
	score = Vector()
	for index in 1:16
		#println(index)
		println(dates[dateIndices[index]])
	end
	return dateIndices
end	

# ╔═╡ 919a7a78-0a07-4776-a407-f4a0e94cecfe
#testing the best way to break up the headers

# ╔═╡ bcfd3636-b637-4422-8e76-d57e8a3f51d9
genomes_asia = parse_fasta(joinpath(@__DIR__, "..", "data", "covgen_asia.fasta"))

# ╔═╡ bdc8235b-e5e3-4ac8-a32d-ec8352bf7a3b
md"""
The very first entry in the fasta file happens to be the first date needed, so no need to search for it
"""

# ╔═╡ ed391f93-add1-4f47-921d-a0bd43bebb59
originalDate = fasta_header(string(">", genomes_asia[1][1]))[2]

# ╔═╡ a745b6cd-9db9-4caf-869f-bab219f61020
monthlycomparison2(originalDate, genomes_asia, 16)

# ╔═╡ aff348a5-04f9-4d7c-a596-afb46309af04
function test()
	genomes_peru = parse_fasta(joinpath(@__DIR__, "..", "data", "covgen_peru.fasta"))
	headers_peru = Vector()
	for headers in genomes_peru[1]
		@info headers
		push!(headers_peru, fasta_header(string(">", headers)))
	end
	headers_peru
	#println(headers_peru)
	#monthlycomparison()
	dates = Vector{String}()
	for headers in genomes_peru[1]
		header = fasta_header(string(">", headers))
		push!(dates, header[2][1:7])
	end
	#println(dates)
	dateIndices = Vector()
	targetMonth = 1
	targetYear = 2020
	totalMonths = 16
	for i in 1:totalMonths
		targetString = string(targetYear, "-", lpad(targetMonth,2,"0"))
		@info targetString
		push!(dateIndices, findfirst(targetString .== dates))
		@info targetYear
		@info targetMonth
		if targetMonth == 12
			@info "its 12"
			targetMonth = 1
			targetYear = targetYear+1
		else
			@info "its not 12"
			targetMonth = targetMonth+1
		end
	end
	return dateIndices
end

# ╔═╡ 212b6540-407b-4e92-9db5-9ec5324c2262
dat = test()

# ╔═╡ Cell order:
# ╠═ac9a9a63-808b-4353-b55c-e9e27414f3ed
# ╠═1c40fe75-627d-43de-8d59-1a34cf82399a
# ╠═8caeb780-e92e-11eb-35b2-7d9a19f314cd
# ╠═00e96e55-c2e2-460d-b9d1-035af4f93e2c
# ╠═919a7a78-0a07-4776-a407-f4a0e94cecfe
# ╠═bcfd3636-b637-4422-8e76-d57e8a3f51d9
# ╠═bdc8235b-e5e3-4ac8-a32d-ec8352bf7a3b
# ╠═ed391f93-add1-4f47-921d-a0bd43bebb59
# ╠═a745b6cd-9db9-4caf-869f-bab219f61020
# ╠═aff348a5-04f9-4d7c-a596-afb46309af04
# ╠═212b6540-407b-4e92-9db5-9ec5324c2262
