function m385bvp1d
% template for numerical solution of a two-point boundary value problem
% -y''=r, y(0)=alpha, y(1)=beta
clear; clf;
alpha = 0; beta = 1; lambda = 25;   % boundary conditions
for icase=1:4
    n = 2^icase-1; h = 1/(n+1);     % h = mesh size
    xe = 0:0.0025:1;                % fine mesh for plotting exact solution
    ye = (25/pi^2)*cos(pi*xe) + (1 + 50/pi^2)*xe - (25/pi^2);                          % exact solution on fine mesh
% Set up for numerical solution.
for i=1:n
    xh(i) = i*h;                    % mesh points
    yh(i) = (25/pi^2)*cos(pi*xh(i)) + (1 + 50/pi^2)*xh(i) - (25/pi^2);                       % exact solution at mesh points
    a(i) = -1; b(i) = 2; c(i) = -1;      % matrix elements
    r(i) = 25*cos(pi*xh(i));                        % right hand side vector
end
    r(1) = r(1) + alpha/h^2;                        % adjust for BC at x=0
    r(n) = r(n) + beta/h^2;                        % adjust for BC at x=1
    wh = h^2*LU_385(a,b,c,r);     % numerical solution
% output
    table(icase,1) = h;
    table(icase,2) = norm(yh-wh,inf);
    table(icase,3) = norm(yh-wh,inf)/h;
    table(icase,4) = norm(yh-wh,inf)/h^2;
    table(icase,5) = norm(yh-wh,inf)/h^3;
    xplot = [0 xh 1]; wplot = [alpha wh beta];
    subplot(2,2,icase); plot(xe,ye,xplot,wplot,'-o');
    string = sprintf('h=1/%d',n+1); title(string)
end
table
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function w = LU_385(a,b,c,r)
% input: a, b, c, r - matrix elements and right hand side vector
% output: w - solution of linear system
%
n = length(r);                      %size of vector r
%
% find L, U
u(1) = b(1);
for i=2:n
  l(i) = a(i)/u(i-1);
  u(i) = b(i) - l(i)*c(i-1);
end


% solve Lz = r
z(1) = r(1);
for i=2:n
  z(i) = r(i) - l(i)*z(i-1);
end
%
% solve Uw = z
w(n) = z(n)/u(n);
for i=n-1:-1:1
  w(i) = (z(i) - c(i)*w(i+1))/u(i);
end
%
