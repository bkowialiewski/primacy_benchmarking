function core(S::Sng, F::Free, M::Mat)
    
    # create the primacy gradient
    createGradient(S, F, M)
    
    # iterate over the number of simulations
    for epoch in 1:S.n_sim        
        # re-set response suppression
        M.r .= 1.0
        # retrieve items one by one
        retrieval(S, F, M)        
    end

    M.score ./= Float64(S.n_sim)

    return nothing
    
end