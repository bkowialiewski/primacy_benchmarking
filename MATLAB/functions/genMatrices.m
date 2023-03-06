function M = genMatrices(S)

% here we pre-allocate memory for all multi-dimensional structures we are
% gonna use
M.gradient = zeros(S.n_items, S.n_items);
M.r = ones(1, S.n_items);
M.score = zeros(1, S.n_items);

end