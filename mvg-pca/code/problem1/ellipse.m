% Title
% Sampling from a 2-D Ellipse

% Declaring Variables
N = 10000000; % number of points
a = 2 / 2; % semi-major axis
b = 1 / 2; % semi-minor axis

% Seed
rng(1);

% Logic
% (x/a)^2 + (y/b)^2 <= 1
% x = arcos(t), y = brsin(t)
% r^2 <= 1
% 0 <= t < 2 * pi

% Working
r = sqrt(rand(N,1)); % radial vector
t = 2 * pi * rand(N,1); % angular vector
X = b * (r .* cos(t)); % x-coordinate
Y = a * (r .* sin(t)); % y-coordinate

% Plotting
histogram2(X,Y,DisplayStyle = 'tile');
xlabel('X');
ylabel('Y');