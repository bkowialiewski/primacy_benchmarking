function main()

addpath('functions')

fileID = fopen('results/score.txt', 'w');

[S, F] = genParams();

S.n_sim = 10^5;

% pre-allocate memory for matrices
M = genMatrices(S);

% launch main function
M = core(S, F, M);

plot(1:S.n_items, M.score)
ylim([0,1])
xlim([0,S.n_items+1])

fprintf(fileID, [num2str(M.score), '\n']);
fclose(fileID);

end

