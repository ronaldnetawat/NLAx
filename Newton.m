
%
% Math 385, hw2, question2
% exercise on Newton's method for solving a nonlinear system
%
% To run this code, navigate to the directory that contains this file and
% type Newton in the Command Window.
function Newton
format long;
c1 = 0.5; c2 = 0.5;
for n = 1:6

  result(n,1) = n-1;

  result(n,2) = c1;

  result(n,3) = c2;

  result(n,4) = f(c1,c2);

  result(n,5) = g(c1,c2);

  answer = [c1; c2] - jacobian(c1,c2)\[f(c1,c2); g(c1,c2)];

  c1 = answer(1); c2 = answer(2);
end
result
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function ffun = f(c1,c2)
a0 = 20; b0 = 10; d0 = 10; k1 = 1.63e-4; k2 = 3.27e-3;
ffun = c1 + c2 - k1*(a0 - 2*c1 - c2)^2*(b0 - c1); % complete this line - this is an expression of the function f
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function gfun = g(c1,c2)
a0 = 20; b0 = 10; d0 = 10; k1 = 1.63e-4; k2 = 3.27e-3;
gfun = c1 + c2 - k2*(a0 - 2*c1 - c2)*(d0 - c2); % complete this line - this is an expression of the function g
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function j = jacobian(c1,c2)
a0 = 20; b0 = 10; d0 = 10; k1 = 1.63e-4; k2 = 3.27e-3;
j11 = 4*k1*(-2*c1 - c2 + a0)*(b0 - c1) + k1*(-2*c1 - c2 + a0)^2 + 1;
% fill the following four lines - they are entries of the Jacobian
matrix
j12 = 2*k1*(b0 - c1)*(-c2 - 2*c1 + a0) + 1;
j21 = 2*k2*(d0 - c2) + 1;
j22 = -2*k2*c2 + k2*(d0 - 2*c1 + a0) + 1;
j = [j11 j12; j21 j22]; % j is the 2 by 2 Jacobian matrix
