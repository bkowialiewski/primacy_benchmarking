using StatsBase, Glob, Plots, BenchmarkTools, DelimitedFiles

include("functions/structs.jl")
include.(glob("functions/*.jl"))

# Our main function
function main()
    
    # generate initial parameters using a common function
    S, F = genParams()
    S.n_sim = 10^5
    # then generate multi-dimensional variables
    M = genMatrices(S)
    
    # run the simulation
    @time core(S, F, M)
    
    p = plot(M.score, ylim = (0, 1))
    display(p)

    writedlm("results/score.txt", M.score)
    
    return nothing
    
end

main()