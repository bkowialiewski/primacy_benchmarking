function genParams()

    # define parameters
    n_sim = 10^4
    n_items = 6
    
    alpha = 10.0
    gamma = 0.9
    sigma = 0.5
    
    delta = 0.8
    
    # store them into structs
    S = Sng(n_sim, n_items)
    F = Free(alpha, gamma, sigma, delta)

    return S::Sng, F::Free

end