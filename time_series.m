% parameter values
a = 0.4;
b = 0.175;
c = 0.4;

% initial condition
X0 = [3;4;2];         

% Time span
t0 = 0;
tEnd = 100;
opts = odeset('RelTol',1e-8,'AbsTol',1e-10);

% Define the ODE right‐hand side
f = @(t, X) [ ...
    (1/3)*X(2)*X(3) - a*X(1) + X(3)/sqrt(6); ...
   -X(1)*X(3)       + b*X(2); ...
    X(1)*X(2) - sqrt(6)*X(1) - c*X(3) ...
];

% Integrate
[t, Y] = ode45(f, [t0 tEnd], X0, opts);

% Plot subplots
figure('Position',[100 100 600 800]);

subplot(3,1,1)
plot(t, Y(:,1),'b-','LineWidth',1.2)
ylabel('x(t)')
title(sprintf('Time Series (a=%.3f, b=%.3f, c=%.3f)',a,b,c))
grid on

subplot(3,1,2)
plot(t, Y(:,2),'r-','LineWidth',1.2)
ylabel('y(t)')
grid on

subplot(3,1,3)
plot(t, Y(:,3),'g-','LineWidth',1.2)
ylabel('z(t)')
xlabel('Time')
grid on

% Save figure
figName = sprintf('TimeSeries_a%.3f_b%.3f_c%.3f',a,b,c);
savefig([figName '.fig']);
print('-dpng','-r300',[figName '.png']);