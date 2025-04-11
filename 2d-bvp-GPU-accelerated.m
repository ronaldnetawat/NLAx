%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Assignment Name:
% Author:
% Date:
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function m385bvp2d
%
% Steady state temperature on the unit square using Jacobi
% Optimized for M1 Mac using vectorization
%
clear;

tol = 10^-4; % set tolerance for stopping criterion

% Create figures to hold the plots
figure(1); % For mesh sizes 1/4, 1/8, 1/16
figure(2); % For mesh sizes 1/32, 1/64, 1/128

% Initialize table to store results
table = zeros(6, 3);


for icase = 1:6
    n = 2^(icase+1)-1; h = 1/(n+1); % mesh size
    x = 0:h:1; y = x; % arrays for plots

    % initialize solution and residual arrays
    w_new = zeros(n+2,n+2);
    w_old = zeros(n+2,n+2);
    res = zeros(n+2,n+2);

    % set nonzero boundary values (vectorized)
    w_new(:,n+2) = 1;
    w_old(:,n+2) = 1;

    % initialize control variables
    ratio = 1;
    k = 0;
    rn = []; % for residual norms

    % start iteration
    while ratio > tol
        k = k+1;
        % compute residual vector (vectorized)
        res(2:n+1,2:n+1) = (4*w_old(2:n+1,2:n+1) - w_old(3:n+2,2:n+1) - ...
                           w_old(1:n,2:n+1) - w_old(2:n+1,3:n+2) - ...
                           w_old(2:n+1,1:n))/h^2;

        % ratio of residual norms (Frobenius norm)
        rn(k) = norm(res,'fro');
        ratio = rn(k)/rn(1);

        % num. solution (vect.)
        w_new(2:n+1,2:n+1) = (w_old(3:n+2,2:n+1) + w_old(1:n,2:n+1) + ...
                             w_old(2:n+1,3:n+2) + w_old(2:n+1,1:n))/4;

        % maintain BC
        w_new(:,n+2) = 1;

        % heat flux (vectorized)
        flux = sum(w_new(:,2));

        % reset numerical solution for next step
        w_old = w_new;
    end

    % store results for output
    table(icase,1) = h;
    table(icase,2) = k;
    table(icase,3) = flux;

    % Select the appropriate figure and subplot based on case number
    if icase <= 3
        figure(1);
        subplot_idx = icase;
    else
        figure(2);
        subplot_idx = icase - 3; % Adjust index for second figure
    end

    % Draw contour plot
    subplot(2,3,subplot_idx);
    contour(x,y,w_new); hold on; axis square; axis([0 1 0 1]); caxis([0 1]);
    string = sprintf('h=1/%d',n+1); title(string);

    % Draw surface plot
    subplot(2,3,3+subplot_idx);
    mesh(x,y,w_new); caxis([0 1]);
    string = sprintf('h=1/%d',n+1); title(string);

    % Print progress to command window
    fprintf('Completed case %d with h = 1/%d (iterations: %d, flux: %.8f)\n', ...
            icase, n+1, k, flux);
end

% Display the results table with convergence analysis
disp('-------------------------------------------------');
disp('| Mesh size (h) | Iterations | Heat Flux        |');
disp('-------------------------------------------------');
for i = 1:6
    fprintf('| 1/%-11d | %-10d | %-16.8f |\n', round(1/table(i,1)), table(i,2), table(i,3));
end
disp('-------------------------------------------------');

% Analyze convergence rate
if size(table,1) > 1
    fprintf('\nConvergence Analysis:\n');
    for i = 2:size(table,1)
        ratio_h = table(i,1)/table(i-1,1);
        ratio_flux = abs(table(i,3) - table(i-1,3))/table(i-1,3);
        order = log(ratio_flux)/log(ratio_h);
        fprintf('Refining from h=1/%d to h=1/%d: Convergence order ≈ %.2f\n', ...
                round(1/table(i-1,1)), round(1/table(i,1)), order);
    end
end

% Return the results table
disp(table);
end
