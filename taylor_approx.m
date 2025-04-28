% Actual function
x = linspace(-4*pi,4*pi,500);
f = sin(x);

% Define the Taylor polynomials
p1 = x;
p3 = x-(x.^3)/factorial(3);
p5 = x-(x.^3)/factorial(3) + (x.^5)/factorial(5);
p7 = x-(x.^3)/factorial(3) + (x.^5)/factorial(5) - (x.^7)/factorial(7);

% figure
figure;

% Subplots:
% 1: f(x) and p1(x)
subplot(2,2,1);
plot(x,f,'b-',x,p1,'r--');
axis([-4*pi 4*pi -2 2]);
xlabel('x');
ylabel('y');
title('f(x) = sin(x) and p_1(x)');
legend('f(x) = sin(x)', 'p_1(x)');
grid on;

%2: f(x) and p3(x)
subplot(2,2,2);
plot(x,f,'b-',x,p3,'r--');
axis([-4*pi 4*pi -2 2]);
xlabel('x');
ylabel('y');
title('f(x) = sin(x) and p_3(x)');
legend('f(x) = sin(x)', 'p_3(x)');
grid on;

% 3: f(x) and p5(x)
subplot(2,2,3);
plot(x,f,'b-',x,p5,'r--');
axis([-4*pi 4*pi -2 2]);
xlabel('x');
ylabel('y');
title('f(x) = sin(x) and p_5(x)');
legend('f(x) = sin(x)', 'p_5(x)');
grid on;

% 4: f(x) and p7(x)
subplot(2,2,4);
plot(x,f,'b-',x,p7,'r--');
axis([-4*pi 4*pi -2 2]);
xlabel('x');
ylabel('y');
title('f(x) = sin(x) and p_7(x)');
legend('f(x) = sin(x)', 'p_7(x)');
grid on;
