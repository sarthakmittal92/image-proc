% Title
% Sampling from Multivariate Gaussian

% Declaring Variables
N = [10,100,1000,10000,100000];
u = [1;2];
C = [1.6250,-1.9486;-1.9486,3.8750];
% lower triangular cholesky decomposition
A = transpose(cholesky(C));
% choosing last value for demonstration
X = zeros(2,N(5));

% Seed
rng(1);

% Logic
% X = Aw + u

% Working
sample = 5;
B = A * randn(2,N(sample));
for j = 1:2
  for i = 1:N(sample)
      X(j,i) = B(j,i) + u(j);
  end
end

% Cholesky Decomposition
% solves A * A' = C
% https://in.mathworks.com/matlabcentral/answers/482145-cholesky-decomposition-column-wise-algorithm-implementation
function A = cholesky(C)
  [n,~] = size(C);
  A = zeros(n,n);
  for j = 1:n
    for i = 1:j-1
      sum1 = 0;
      for k = 1:i-1
        sum1 = sum1 + A(k,i) * A(k,j);
      end
      A(i,j) = (C(i,j) - sum1) / A(i,i);
    end
    sum2 = 0;
    for k = 1:j-1 
      sum2 = sum2 + A(k,j) * A(k,j);
    end
    A(j,j) = sqrt(C(j,j) - sum2);
  end
end