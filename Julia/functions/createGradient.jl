function createGradient(S, F, M)

    # create gradient for each output position at the same time, resulting in a n-by-n matrix
    for i in 1:S.n_items
        M.gradient[:,i] .= collect(F.alpha .- (0.0:Float64(S.n_items - 1)) .* F.gamma) * F.delta^Float64(i-1)
    end

    return nothing
    
end