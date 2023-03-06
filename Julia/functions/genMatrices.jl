function genMatrices(S::Sng)

    gradient = zeros(Float64, S.n_items, S.n_items)
    activation = ones(Float64, S.n_items)
    r = ones(Float64, S.n_items)
    score = zeros(Float64, S.n_items)

    M = Mat(gradient, activation, r, score)

    return M::Mat

end