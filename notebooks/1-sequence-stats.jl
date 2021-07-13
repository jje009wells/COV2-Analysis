### A Pluto.jl notebook ###
# v0.14.8

using Markdown
using InteractiveUtils

# ╔═╡ 781f89b8-d61d-4e2c-9999-e0c86fe5732e
using BioinformaticsBISC195

# ╔═╡ 13535e83-f647-47b8-a0b9-0539103b6771
using Plots

# ╔═╡ 3324a4c1-0291-40d7-9869-7db1024f707a
function fasta_header(header)
    #this is code to read the headers of the different sequences and break them up appropriately
    startswith(header, '>') || error("Invalid header (headers must start with '>')")

    splitVect = split(header[2:end], "|")
    returnTuple = ()
    for component in splitVect
        returnTuple = (returnTuple..., strip(component))
    end

    return returnTuple
end

# ╔═╡ 09c83c28-a88e-4d91-873d-8ade50ae691b
function parse_fasta(path)
# this code parses the fasta file at the given path by storing each header and each individual sequence
    headersVect = Vector()
    seqVect = Vector()
    toBeCombined = Vector()


    for line in eachline(path)
        #@info "line is " line
        #@info "to be combined is" toBeCombined
        if startswith(line, '>')
            push!(headersVect, fasta_header(line))
            if size(toBeCombined,1) > 0
                push!(seqVect, join(toBeCombined))
                toBeCombined = Vector()
            end
        elseif line != ""
            push!(toBeCombined, line)

        end
        #@info "to be combined is" toBeCombined
    end
    push!(seqVect, join(toBeCombined))
    
    return (headersVect, seqVect)
end

# ╔═╡ 9cb89580-e0e4-11eb-08c7-ad14760a13d2
begin
	# Coronavirus mean and SD analysis
	
	using Statistics
	# gets access to the specific genome fasta file to be parsed
	cov2Path = joinpath(@__DIR__, "..", "data", "cov2genseq.fasta")
	
	genomes = parse_fasta(cov2Path)
	seq_lengths = Vector()
    # stores each indivual sequence length in one Vector for easier calculation later
	for sequence in genomes[2]
	    push!(seq_lengths, length(sequence))
	end
	
	# makes use of Statistics package functions mean() and std() to compute the analysis based on the data in the Vector created above
	mean_cov2_length = mean(seq_lengths)
	std_cov2_length = std(seq_lengths)
	
	println("Mean is $mean_cov2_length")
	println("Std Dev is $std_cov2_length")
		
end

# ╔═╡ 55de3beb-5c2a-4ffe-a0c9-156384595d3c
histogram(seq_lengths, label = "", xaxis = "Sequence Lengths", yaxis = "Count")

# ╔═╡ bb6c6a47-ecf7-42a6-aafb-c47e3a946ecf
begin
	#find the maximum and minimum lengths of the sequences in the file in order to help figure out if the sequences follow a normal distribution
	max = maximum(seq_lengths)
	println("Max is $max")
	min = minimum(seq_lengths)
	println("Min is $min")
end

# ╔═╡ 2073af8f-59f3-4d26-b8fc-77dd9da60a21
#filters out the sequences that are less than 25k in length
function filter25k(data)
	newHeaders = Vector()
	newSeq = Vector()
	i = 0
	for i in 1:length(data[1])
		if length(data[2][i]) > 25000
			push!(newSeq, data[2][i])
			push!(newHeaders, data[1][i])
			i = i - 1
		end
	end
	
	return (newHeaders, newSeq)
end

# ╔═╡ Cell order:
# ╠═781f89b8-d61d-4e2c-9999-e0c86fe5732e
# ╠═13535e83-f647-47b8-a0b9-0539103b6771
# ╠═55de3beb-5c2a-4ffe-a0c9-156384595d3c
# ╠═3324a4c1-0291-40d7-9869-7db1024f707a
# ╠═09c83c28-a88e-4d91-873d-8ade50ae691b
# ╠═9cb89580-e0e4-11eb-08c7-ad14760a13d2
# ╠═bb6c6a47-ecf7-42a6-aafb-c47e3a946ecf
# ╠═2073af8f-59f3-4d26-b8fc-77dd9da60a21
