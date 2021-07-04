### A Pluto.jl notebook ###
# v0.14.8

using Markdown
using InteractiveUtils

# ╔═╡ 3324a4c1-0291-40d7-9869-7db1024f707a
function fasta_header(header)
    startswith(header, '>') || error("Invalid header (headers must start with '>')")

    ## Your code here
    splitVect = split(header[2:end], "|")
    returnTuple = ()
    for component in splitVect
        returnTuple = (returnTuple..., strip(component))
    end

    return returnTuple
end

# ╔═╡ 09c83c28-a88e-4d91-873d-8ade50ae691b
function parse_fasta(path)

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
	#total length across all sequences divided by number of sequences
	cov2Path = joinpath(@__DIR__, "..", "data", "cov2genseq.fasta")
	
	genomes = parse_fasta(cov2Path)
	seq_lengths = Vector()
	for sequence in genomes[2]
	    push!(seq_lengths, length(sequence))
	end
	
	
	mean_cov2_length = mean(seq_lengths)
	std_cov2_length = std(seq_lengths)
end

# ╔═╡ Cell order:
# ╠═3324a4c1-0291-40d7-9869-7db1024f707a
# ╠═09c83c28-a88e-4d91-873d-8ade50ae691b
# ╠═9cb89580-e0e4-11eb-08c7-ad14760a13d2
