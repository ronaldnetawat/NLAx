% range of x-vals
x = linspace(-3,3,500);

% calculating f(x) for range of x
fx = exp(-abs(x));

% calculate p2(x)
p2x = 1 + x.^2*(exp(-1)-1);

% Create the plot
plot(x,fx,'b-');
hold on;
plot(x,p2x,'r--');
hold off;
xlabel('x');
ylabel('y');
title('Plot of f(x) and p2(x)');
legend('f(x) = e^{-|x|}', 'p2(x) = 1 + x^2(e^{-1} - 1)');
grid on;
