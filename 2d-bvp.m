%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Assignment Name: Homework 4
% Author: Ron Netawat
% Date: 03/20/2025
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function m385bvp2d
%
% Steady state temperature on the unit square using Jacobi
%
clear;

tol = 10^-4; % set tolerance for stopping criterion
%
for icase = 1:3
    n = 2^(icase+1)-1; h = 1/(n+1); % set mesh size
    x = 0:h:1; y = x; % create x and y arrays for plots

%   initialize solution and residual arrays
    w_new = zeros(n+2,n+2);
    w_old = zeros(n+2,n+2);
    res = zeros(n+2,n+2);
%   set nonzero boundary values
    for j = 1:n+2
        w_new(j,n+2) = 1;
        w_old(j,n+2) = 1;
    end
%   initialize control variables
    ratio = 1;
    k = 0;

%   start iteration
    while ratio > tol
        k = k+1;
%       compute residual vector
        for i = 2:n+1
            for j = 2:n+1
                res(i,j)=(4*w_old(i,j) - w_old(i+1,j) - w_old(i-1,j) - w_old(i,j+1) - w_old(i,j-1))/h^2;
            end
        end
%           compute ratio of residual norms using Frobenius norm for
%           convenience
        rn(k) = norm(res,'fro');
        ratio = rn(k)/rn(1);
%           compute numerical solution
        for i = 2:n+1
            for j = 2:n+1
                w_new(i,j) = (w_old(i+1,j) + w_old(i-1,j) + w_old(i,j+1) + w_old(i,j-1))/4;
            end
        end
        flux = sum(w_new(:,2)); % compute heat flux, hint: use Matlab sum command
        w_old = w_new; % reset numerical solution for next step

    end

%   store results for output
    table(icase,1) = h;
    table(icase,2) = k;
    table(icase,3) = flux;

%   draw contour plot
    subplot(2,3,icase)
    contour(x,y,w_new); hold on; axis square; axis([0 1 0 1]); caxis([100 inf])
    string = sprintf('h=1/%d',n+1); title(string)
%   draw surface plot
    subplot(2,3,3+icase)
    mesh( x , y , w_new ); caxis([100 inf])
    string = sprintf('h=1/%d',n+1); title(string)
end
table
