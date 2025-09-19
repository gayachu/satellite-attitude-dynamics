% parameters    
b = 0.175;
c = 0.4;
a_values = linspace(0, 0.6, 300); % range of the parameter we are varying
x0 = [3; 4; 2]; % initial condtiton
tspan = [0 1000]; % time 
opts = odeset('RelTol',1e-8,'AbsTol',1e-10);

bifurcation_data = [];

for i = 1:length(a_values)
    a = a_values(i);
    % satellite ODE system
    f = @(t, X) [
        (1/3)*X(2)*X(3) - a*X(1) + (1/sqrt(6))*X(3);
        -X(1)*X(3) + b*X(2);
        X(1)*X(2) - sqrt(6)*X(1) - c*X(3)
    ];
    [t, X] = ode45(f, tspan, x0, opts);
    y = X(round(0.9*end):end, 1); % last 10 percent of the dataset.
    [pks,~] = findpeaks(y);
    bifurcation_data = [bifurcation_data; a*ones(size(pks)), pks];
end

figure;
plot(bifurcation_data(:,1), bifurcation_data(:,2), '.', 'Color', [0 0 0.6], 'MarkerSize', 6);
xlabel('a');
ylabel('x');
title('Bifurcation Diagram for Satellite System (varying a)');
axis([0.3 0.6 -4 4]);
