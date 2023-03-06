function M = createGradient(S, F, M)

% compute the primacy gradient for each output position
% will result in a n-by-n matrix
for i = 1:S.n_items
    M.gradient(i,:) = (F.alpha - (0.0:(S.n_items - 1)) .* F.gamma) * F.delta^(i-1);
end

end