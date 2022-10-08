% Title
% Sampling from a 2-D Triangle
% some cases may have k > N

% Declaring Variables
N = 10000000; % size of dataset
% full rectangle
Rx = rand(2 * N,1) * pi;
Ry = rand(2 * N,1) * exp(1);
% dataset points
X = zeros(N,1);
Y = zeros(N,1);

% Seed
rng(1);

% Logic
% roughly half of the rectangle is valid (area ratio)
% 0 <= x <= pi / 3, 0 <= y <= 3ex/pi
% pi / 3 <= x <= pi, 0 <= y <= 3e(pi - x)/2pi

% Working
k = 1; % counter
for i = 1:2 * N
  % limiting values
  x1 = pi / 3;
  y1 = 3 * exp(1) * Rx(i) / pi;
  y2 = 3 * exp(1) * (pi - Rx(i)) / (2 * pi);
  % accepting valid values
  if (Rx(i) <= x1 && Ry(i) <= y1 || (Rx(i) >= x1 && Ry(i) <= y2))
    X(k) = Rx(i);
    Y(k) = Ry(i);
    k = k + 1;
  end
end % k nearly equal to N (off by ~0.04%)

% slicing to approximate size
if (k < N)
  X = X(1:k);
  Y = Y(1:k);
end

% Plotting
histogram2(X,Y,DisplayStyle = 'tile');
xlabel('X');
ylabel('Y');