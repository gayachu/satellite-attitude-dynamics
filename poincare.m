% Parameters
a = 0.4;
b = 0.175;
c = 0.4;

% Time settings
tspan = [0 10000];
dt = 0.0001;
t_eval = tspan(1):dt:tspan(2);

% Initial condition
x0 = [3; 4; 2];

% ODE system
satellite_ode = @(t, X) [
    (1/3)*X(2)*X(3) - a*X(1) + (1/sqrt(6))*X(3);
    -X(1)*X(3) + b*X(2);
    X(1)*X(2) - sqrt(6)*X(1) - c*X(3)
];

% Solve the ODE
[t, X] = ode45(satellite_ode, t_eval, x0);

x = X(:,1);
y = X(:,2);
z = X(:,3);




tol = 1e-5; % tolerance for plane crossing


figure;
mask_z0 = abs(z) < tol;
plot(x(mask_z0), y(mask_z0), '.');
xlabel('x'); ylabel('y'); title('Poincaré x-y');
axis equal;

%plot
figure;
mask_x0 = abs(x) < tol;
plot(y(mask_x0), z(mask_x0), '.');
xlabel('y'); ylabel('z'); title('Poincaré y-z');
axis equal;

figure;
mask_y0 = abs(y) < tol;
plot(z(mask_y0), x(mask_y0), '.');
xlabel('x'); ylabel('z'); title('Poincaré x-z');
axis equal;