using StatsBase, Glob, Plots, BenchmarkTools, DelimitedFiles

include("functions/structs.jl")
include.(glob("functions/*.jl"))

function benchmarking()
    
    # generate initial parameters using a common function
    S, F = genParams()
    # then generate multi-dimensional variables
    M = genMatrices(S)
    
    # run the simulation
    core(S, F, M)
    
end

rm("results/output.txt", force = true)
writedlm("results/output.txt", [@elapsed benchmarking() for i in 1:1000] .* 1000)