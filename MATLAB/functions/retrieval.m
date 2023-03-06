function M = retrieval(S, F, M)

% iterate over the number of items
for i = 1:S.n_items

    % pre-allocate noise
    noise = randn(1,S.n_items) .* F.sigma;

    % compute current activation - blend of current primacy gradient, with
    % noise and current state of response suppression
    activation = (M.gradient(i,:) + noise) .* M.r;
    % select most activated item
    [~, selected] = max(activation);

    % track the state of response suppression
    M.r(selected) = 0.0;

    if selected == i
        M.score(i) = M.score(i) + 1.0;
    end

end

end