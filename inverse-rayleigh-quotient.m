% Matrix
A = [2,1,1;1,3,1;1,1,4];

% True eigenvalues
true_eigs = eig(A);

% Initial guesses
V0 = [
    [1/sqrt(3); 1/sqrt(3); 1/sqrt(3)], ...
    [0; 1; 0], ...
    [0; 0; 1]
];

% Number of iterations
num_iters = 6;

% For each initial vector, apply Rayleigh Quotient Iteration
disp('Rayleigh Quotient Iteration:');
for j = 1:3
    fprintf('\nInitial vector v0 = [%g; %g; %g]\n', V0(:,j));

    v = V0(:,j);
    v = v / norm(v);
    lambda = v' * A * v; % Initial shift using Rayleigh quotient

    lambdas = zeros(num_iters,1);
    errors = zeros(num_iters,1);
    ratios = NaN(num_iters,1);

    for k = 1:num_iters
        % Solve (A - lambda*I)w = v
        w = (A - lambda * eye(size(A))) \ v;
        v = w / norm(w);
        lambda_new = v' * A * v;

        lambdas(k) = lambda_new;
        [~, closest_idx] = min(abs(true_eigs - lambda_new));
        true_val = true_eigs(closest_idx);
        errors(k) = abs(lambda_new - true_val);

        if k > 1
            ratios(k) = errors(k) / errors(k-1);
        end

        lambda = lambda_new;
    end

    % Display the results
    disp('   k     lambda^(k)        error          error ratio');
    disp([(0:num_iters-1)', lambdas, errors, ratios]);
end

