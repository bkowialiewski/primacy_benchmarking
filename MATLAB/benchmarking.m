function benchmarking()

addpath('functions')

fileID = fopen('results/output.txt', 'w');
nBench = 1000;

for epoch = 1:nBench

    tic

    [S, F] = genParams();

    % pre-allocate memory for matrices
    M = genMatrices(S);

    % launch main function
    M = core(S, F, M);

    elapsed = toc;

    disp(epoch)

    fprintf(fileID, [num2str(elapsed * 1000), '\n']);

end

fclose(fileID);
disp(M.score)

end

