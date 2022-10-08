% Title
% Error in Covariance of Multivariate Gaussian
% may take around 40 seconds to run

% Declaring Variables
N = [10,100,1000,10000,100000];
M = 100;
u = [1;2];
C = [1.6250,-1.9486;-1.9486,3.8750];
% lower triangular cholesky decomposition
A = transpose(cholesky(C));
% record mean, matrix difference and frobenius-norm error
mean = zeros(2,M);
covmean = zeros(2,2);
coverr = zeros(M,5);

% Seed
rng(1);

% Logic
% X = Aw + u
% MLE for Covariance obtained by averaging A * A'
% sample points used to get back A
% Error calculated as told in question

% Working
for sample = 1:5
  X = zeros(2,N(sample));
  for k = 1:M
    B = A * randn(2,N(sample));
    for j = 1:2
      for i = 1:N(sample)
        X(j,i) = B(j,i) + u(j);
      end
      mean(j,k) = sum(X(j,:)) / N(sample); % MLE for Mean
    end
    covmean = zeros(2,2);
    for l = 1:N(sample)
      covmean = covmean + (X(:,l) - mean(:,k)) * transpose(X(:,l) - mean(:,k));
    end
    covmean = covmean / N(sample); % MLE for Covariance
    coverr(k,sample) = fronorm(covmean - C) / fronorm(C); % Frobenius-norm error
  end
end

% Plotting
boxplot(coverr, 'Labels', {'1','2','3','4','5'});
xlabel('log10(N)');
ylabel('Error in Covariance');

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

% Frobenium Norm of Matrix
function fro = fronorm(A)
  fro = 0;
  [n,m] = size(A);
  for i = 1:n
    for j = 1:m
      fro = fro + A(i,j) * A(i,j);
    end
  end
  fro = sqrt(fro);
end