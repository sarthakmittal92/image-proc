% Title
% PCA and Hyperplane Fitting

% Declaring Variables
M = load('points2D_Set1.mat');
[n,m] = size(M.x);
% estimating sample parameters
empmean = zeros(2,1);
covmean = zeros(2,2);

% Seed
rng(1);

% Logic
% X = Aw + u
% sorting eigenvalues of C in descending order
% taking pair (value and vector) corresponding to largest eigenvalue

% Working
X = transpose([M.x,M.y]);
for j = 1:2
  empmean(j) = sum(X(j,:)) / n;
end
for l = 1:n
  covmean = covmean + (X(:,l) - empmean) * transpose(X(:,l) - empmean);
end
covmean = covmean / n;

% principal eigen parameters
[V,D] = eig(covmean);
[d,index] = sort(diag(D),'descend');
Dsort = D(index,index);
Vsort = V(:,index);
empeigval = Dsort(1,1);
empeigvec = Vsort(:,1);

pmvend1 = empmean - empeigval * (empeigvec / sqrt(empeigvec(1)^2 + empeigvec(2)^2));
pmvend2 = empmean + empeigval * (empeigvec / sqrt(empeigvec(1)^2 + empeigvec(2)^2));
xpoints = [pmvend1(1),pmvend2(1)];
ypoints = [pmvend1(2),pmvend2(2)];

% Plotting
scatter(X(1,:),X(2,:),color = 'blue');
hold on;
plot(xpoints,ypoints, color = 'red');
legend('Scatter Plot','Principal Mode of Variation');
xlabel('X');
ylabel('Y');