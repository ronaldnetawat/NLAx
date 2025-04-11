% define matrix A (not used actually)
A = [2, -1; -1, 2];

% number of points for plotting
n_points = 1000;
omega_values = linspace(0, 2, n_points);
spectral_radius = zeros(1, n_points);

%calculating spectral radius for each omega
for i = 1:n_points
    omega = omega_values(i);

    % Create an empty 2x2 matrix B_omega for you to fill in
    B_omega = [1-omega, (1/2)*omega; (1/2)*omega*(1-omega), (1/4)*omega^2 + 1 - omega];


    %calculating the spectral radius (maximum absolute eigenvalue)
    eigenvalues = eig(B_omega);
    abs_eigenvalues = abs(eigenvalues);
    spectral_radius(i) = max(abs_eigenvalues);
end

% optimal omega value = where spectral radius is minimum
[min_spectral_radius, min_index] = min(spectral_radius);
optimal_omega = omega_values(min_index);

% display the optimal SOR and spectral radius as that point
fprintf('optimal SOR parameter (omega): %.6f\n', optimal_omega);
fprintf('minimum spectral radius: %.6f\n', min_spectral_radius);

% plotting
figure;
plot(omega_values, spectral_radius);
grid on;
xlabel('\omega');
ylabel('\rho(B_\omega)');
title('Spectral radius vs. Relaxation parameter');

