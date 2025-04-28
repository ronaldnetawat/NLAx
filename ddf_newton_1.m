function interpolation_template
% function to be interpolated
f = @(x) exp(-abs(x));

x = linspace(-5, 5, 1000); % Evaluation points

N_values = [4,8,16]; % Different number of interpolating points

figure;

for k = 1:length(N_values)
    N = N_values(k);

    % uniform points
    xi_uniform = linspace(-5,5,N+1)';
    p_uniform = myinterp(xi_uniform, f, x);

    % subplots
    subplot(length(N_values), 2, 2*k-1);
    plot(x, f(x), 'b-', x, p_uniform, 'r--');
    title(['uniform poitns, n=', num2str(N)]); % num2str converts num to string
    ylim([-1.5 1.5]);
    legend('f(x)', 'p(x)');
    hold on;

    % Chebyshev points
    xi_chebyshev = zeros(N+1, 1);
    h = pi/N;
    for i = 0:N
        theta_i = i*h;
        xi_chebyshev(i+1) = cos(theta_i);
    end

    p_chebyshev = myinterp(xi_chebyshev,f,x);

    subplot(length(N_values), 2, 2*k);  % subplots for Chebyshec
    plot(x, f(x), 'b-', x, p_chebyshev, 'g--');
    title(['Chebyshev points, n=', num2str(N)]);
    ylim([-1.5 1.5]);
    legend('f(x)', 'p(x)');
    hold off;
end

end


%%%%%%%%%%%
function p = myinterp(xi, f, x)
    fxi = f(xi);    % function evaluated at the interpolating points

    Fx = DivDiffTab(xi, fxi);

    a = Fx(1, :);   % the first row of Fx is the coefficients

    % compute the polynomial p following notes on page 5, chap 5
    n = numel(xi) - 1;
    p = a(n+1)*ones(size(x));
    for i = n:-1:1
        p = a(i) + p.*(x - xi(i));
    end

end

function Fx = DivDiffTab(x, fx)
% x is an array
% fx is the function to be interpolated, f, evaluated at the array x
% Fx is the matrix storing the coefficients; first row are the coefficients
% in Newton's form

Fx = nan(numel(x));     % initialize the matrix Fx

Fx(:, 1) = fx;          % fill the first column by the function values

for i = 1:numel(x)-1    % go column by column
    % the i+1-th column is obtained by the differences from the i-th column
    % remember to divide it by the corresponding difference of x values
    Fx(1 : end - i, i + 1) = (Fx(2 : end - i + 1, i) - Fx(1 : end - i, i))...
        ./(x(1 + i : end) - x(1 : end - i));



end

% you should at least verify your table against the table on page 4, chap5


end
