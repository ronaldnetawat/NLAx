h = linspace(0.01, 0.5, 100);  % different values for h

% rho definitions for each method
rho_J = cos(pi*h);  % Jacobi
rho_GS = cos(pi*h).^2;  % Gauss-Seidel; the dot is used for element-wise operation
rho_SOR = (1-sin(pi*h))./(1+sin(pi*h)); % SOR

% plotting curves
figure;
plot(h, rho_J, 'r'); hold on; % used for multiple plots (referred the documentation)
plot(h, rho_GS, 'b');
plot(h, rho_SOR, 'g');

% for h = 1/2, 1/4, 1/8, 1/16
h_markers = [1/2,1/4,1/8,1/16];
rho_J_mk = cos(pi*h_markers);
rho_GS_mk = cos(pi*h_markers).^2; # dot is used for element-wise operation
rho_SOR_mk = (1-sin(pi*h_markers))./(1+sin(pi*h_markers));


% aesthetics :)
plot(h_markers, rho_J_mk, 'ro','MarkerFaceColor', 'r');
plot(h_markers, rho_GS_mk, 'bo','MarkerFaceColor', 'b');
plot(h_markers, rho_SOR_mk, 'go', 'MarkerFaceColor', 'g');

% aesthetics 2.0 :)
xlabel('h (meshs size)');
ylabel('\rho(B)');
title('Spectral radius vs Mesh size for the three iterative methods');
legend('Jacobi', 'Gauss-Seidel', 'SOR');
grid on;

