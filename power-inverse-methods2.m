% matrix
A = [2,-1,0;-1,2,-1;0,-1,2];

% initial guess
v0 = [1/sqrt(3); 1/sqrt(3); 1/sqrt(3)];

% actual e-values, for comparison
eigvals = eig(A);
lambda_max_true = max(eigvals); % largest e-val
lambda_min_true = min(eigvals); % smallest e-val

% initializing vectors for storing data
% for the power method
k_vals = [0;1;2;3;4;5]; % to print k in table
lambda_max_app = zeros(6,1);
lambda_max_error = zeros(6,1);
lambda_max_ratio = NaN(6,1);  % becuase we don't have a value for the fisrst ratio

% for the inverse method
lambda_min_app = zeros(6,1);
lambda_min_error = zeros(6,1);
lambda_min_ratio = NaN(6,1);

% Power method
v = v0;
%lambda_max_app(1) = 5;  % lambda(0)
lambda_max_app(1) = v' * A * v;  % Rayleigh quotient at k = 0

%lambda_max_error(1) = abs(5 - lambda_max_true);
lambda_max_error(1) = abs(lambda_max_app(1) - lambda_max_true);


for k = 1:5
    w = A*v;
    v = w/norm(w,2);
    lambda = v'*A*v;
    lambda_max_app(k+1)= lambda;
    lambda_max_error(k+1) = abs(lambda-lambda_max_true);
    lambda_max_ratio(k+1) = lambda_max_error(k+1)/lambda_max_error(k);
end

% inverse power method
v = v0;
lambda_min_app(1) = v'*A*v; % first lambda(k)
lambda_min_error(1) = abs(lambda_min_app(1)-lambda_min_true);


for k = 1:5
    w = A\v; % gets w
    v = w/norm(w,2);
    lambda = v'*A*v;
    lambda_min_app(k+1) = lambda;
    lambda_min_error(k+1) = abs(lambda-lambda_min_true);
    lambda_min_ratio(k+1) = lambda_min_error(k+1)/lambda_min_error(k);
end



% print the results

format long % at least 6 decimal digits

disp('Power method:');
disp('   k                      lambda^(k)              error            error ratio');
disp([k_vals, lambda_max_app, lambda_max_error, lambda_max_ratio]);

disp(' ');
disp('Inverse power method:');
disp('   k                      lambda^(k)              error            error ratio');
disp([k_vals, lambda_min_app, lambda_min_error, lambda_min_ratio]);

