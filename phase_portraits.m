% Parameters
a = 0.4;
b = 0.175;
c = 0.4;

% System of ODEs
f = @(t, X) [
    (1/3)*X(2)*X(3) - a*X(1) + (1/sqrt(6))*X(3);
    -X(1)*X(3) + b*X(2);
    X(1)*X(2) - sqrt(6)*X(1) - c*X(3)
];

% Initial condition
X0 = [3; 4; 2];

% Time span
tspan = [0 100];

% Solve ODE
[t, X] = ode45(f, tspan, X0);

% Plot 3D phase portrait
figure;
plot3(X(:,1), X(:,2), X(:,3), 'b');
xlabel('x');
ylabel('y');
zlabel('z');
title('3D Phase Portrait of the Chaotic Satellite System');
grid on;

% Plot 2D projections
figure;

plot(X(:,1), X(:,2), 'r');
xlabel('x'); ylabel('y');
title('Phase Portrait: x vs y');
grid on;

figure;
plot(X(:,2), X(:,3), 'g');
xlabel('y'); ylabel('z');
title('Phase Portrait: y vs z');
grid on;

figure;
plot(X(:,1), X(:,3), 'm');
xlabel('x'); ylabel('z');
title('Phase Portrait: x vs z');
grid on;