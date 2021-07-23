### A Pluto.jl notebook ###
# v0.14.8

using Markdown
using InteractiveUtils

# ╔═╡ ac9a9a63-808b-4353-b55c-e9e27414f3ed
using BioinformaticsBISC195

# ╔═╡ 8699ff31-b4ed-4f74-ad90-f11a0c1bb024
using Plots

# ╔═╡ 00e96e55-c2e2-460d-b9d1-035af4f93e2c
#=function monthlycomparison(original, allSeq, totalMonths)
	dates = Vector{String}()
	for headers in allSeq[1]
		#@info headers
		header = fasta_header(headers)
		#@info "header" header[2]
		if length(header[2]) >= 7 #if its shorter than this then it does not have a month listed, so I can't use it and don't need it in the vector
			push!(dates, header[2][1:7])
			@info "header short" header[2][1:7]
		end
		#@info dates
	end

	
	#filling out dateIndices to hold ints that represent the indices of the next correct sequences to grab
	dateIndices = Vector()
	targetMonth = 1
	targetYear = 2020
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
	for index in dateIndices
		@info "index" index
		#@info original
		#@info allSeq[2][index]
		#@info "max"  maximum(swscorematrix(original, allSeq[2][index]))
		push!(score, maximum(swscorematrix(original, allSeq[2][index])))
	end
	return score
end	=#

# ╔═╡ 31bb927a-c189-485b-8888-622baec1b594
md"""
Collecting the data for all sequences in asia from the covgen_asia.fasta file.
"""

# ╔═╡ bcfd3636-b637-4422-8e76-d57e8a3f51d9
genomes_asia = parse_fasta(joinpath(@__DIR__, "..", "data", "covgen_asia.fasta"))

# ╔═╡ bdc8235b-e5e3-4ac8-a32d-ec8352bf7a3b
md"""
startingSeq is the very first sequence I am using, from Dec 2019, that will be compared against the other sequences each month to see how the sequence changes over time. The very first entry in the fasta file happens to be the first date needed, so no need to do any special search for it.
"""

# ╔═╡ 9e89e7d1-36ff-4337-b57d-769cf5aaed3e
startingSeq = genomes_asia[2][1]

# ╔═╡ 88756434-059e-4335-a34c-7947a7571625
md"""
Now the final calculations can be performed sing the monthlycomparison function. I initally wanted to make the total months be closer to 16 in order to get more data, but that ended being very time consuming so I cut it down to 12 in order to get a full year in.
"""

# ╔═╡ a745b6cd-9db9-4caf-869f-bab219f61020
monthly_scores = monthlycomparison(startingSeq, genomes_asia, 2)

# ╔═╡ aff348a5-04f9-4d7c-a596-afb46309af04
#=function test()
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
end=#

# ╔═╡ ef66799f-63c2-4bee-96b5-0bca9e614db8
md"""
Now I am going to make a scatter plot where the x axis is months since Dec 2019 and the y axis is the Smith-Waterman score for that month.
I predict the trendline will gradually decrease as the months pass because a lower SW score indicates less similarity, and as the virus mutates and develops it will get less and less similar to the original strand from Dec 2019.
"""

# ╔═╡ fce9f89f-8573-483e-816a-e8930ba8d79b
plot([1:2], monthly_scores, label = "", xaxis = "Months Since Dec 2019", yaxis = "Smith-Waterman Score", lw = 2, markershape = :circle)

# ╔═╡ 6a505319-edb4-4c6d-b716-a84539d1a99f
md"""
It is difficult to determine a conclusive trend for the graph, though there are a few areas where there is a brief downward trend (from months 2-8 with an outlier at 6).
It is important to note the scale of the graph- the scores have a range of around 300, which seems like a big range for a data set of this size. 
However, this is a rather limited sample of only one sequence per month being tested for an entire continent, and also only encompasses one year, so it is not a very accurate representation of the data as a whole.
It would be interesting to see if this trend continues for future months, or how it compares to different scoring algorithms or a more comprehensive method of scoring across many sequences.
"""

# ╔═╡ Cell order:
# ╠═ac9a9a63-808b-4353-b55c-e9e27414f3ed
# ╠═8699ff31-b4ed-4f74-ad90-f11a0c1bb024
# ╠═00e96e55-c2e2-460d-b9d1-035af4f93e2c
# ╟─31bb927a-c189-485b-8888-622baec1b594
# ╠═bcfd3636-b637-4422-8e76-d57e8a3f51d9
# ╟─bdc8235b-e5e3-4ac8-a32d-ec8352bf7a3b
# ╠═9e89e7d1-36ff-4337-b57d-769cf5aaed3e
# ╟─88756434-059e-4335-a34c-7947a7571625
# ╠═a745b6cd-9db9-4caf-869f-bab219f61020
# ╠═aff348a5-04f9-4d7c-a596-afb46309af04
# ╟─ef66799f-63c2-4bee-96b5-0bca9e614db8
# ╠═fce9f89f-8573-483e-816a-e8930ba8d79b
# ╟─6a505319-edb4-4c6d-b716-a84539d1a99f
