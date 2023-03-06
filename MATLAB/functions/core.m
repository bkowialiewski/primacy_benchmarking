function M = core(S, F, M)

% pre-allocate the gradient before running all simulations
M = createGradient(S, F, M);

% iterate over number of simulations
for epoch = 1:S.n_sim
    % reset response suppression
    M.r = (M.r .* 0.0) + 1.0;
    % retrieve items one by one
    M = retrieval(S, F, M);
end

M.score = M.score / S.n_sim;

end