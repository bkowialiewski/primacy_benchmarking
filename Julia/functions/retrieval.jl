function retrieval(S::Sng, F::Free, M::Mat)
    
    for i in 1:S.n_items
        
        # create noise
        noise = randn(Float64, S.n_items) .* F.sigma
        
        # add it to overall activation and apply response suppression
        M.activation .= (M.gradient[:,i] .+ noise) .* M.r

        # select the most activated items
        selected = argmax(M.activation)

        # track recalled item
        M.r[selected] = 0.0

        if selected == i
            M.score[i] += 1.0
        end

    end
    
    return nothing
    
end