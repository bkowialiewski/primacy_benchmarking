function [S, F] = genParams()

    % create struct for fixed parameters
    S.n_sim = 10^4;
    S.n_items = 6;

    % free parameters
    F.alpha = 10.0;
    F.gamma = 0.9;
    F.sigma = 0.5;
    F.delta = 0.8;

end