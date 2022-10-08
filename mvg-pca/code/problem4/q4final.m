% PCA

% loading the data set
load("mnist.mat");

% digits_train has all the data
% labels_train has the labels for digits

% looping on the digits
for digit = 0:9
  
  % filter out data as per the label from the 28 * 28 * 60000 sample set
  digitData = digits_train(:,:,labels_train == digit);
  % convert image matrix to float type
  image2D = im2double(digitData);
  % convert to concatenated column vector
  digitData = reshape(image2D, 784,[]);
  % define mean for each digit
  digitMean = sum(digitData, 2) / size(digitData, 2);
  % mean-centred data
  meanCentric = digitData - digitMean;
  % calculating covariance (MLE)
  cov = meanCentric * meanCentric' / size(digitData, 2);
  
  % finding eigenvalues and eigenvectors for covariance
  [V,D] = eig(cov);
  % sorting in descending order
  [~,X] = sort(diag(D),'descend');
  % sort diagonal elements
  Dsort = D(X,X);
  % correspondingly sort eigenvectors
  Vsort = V(:,X);
  % principal eigenvector and eigenvalue
  v1 = Vsort(:,1);
  e1 = Dsort(1,1);

  % plotting
  figure;
    % eigenvalue plot
    plot(diag(Dsort));
    title("Eigenvalues for " + string(digit));
  figure;
    % plots for mean, mean - sqrt(e1) * v1 and mean + sqrt(e1) * v1
    subplot(1,3,1); imshow(reshape(digitMean - sqrt(e1) * v1,[28 28]));
    title("\mu - sqrt(\lambda_1) * v_1 for " + string(digit))
    subplot(1,3,2); imshow(reshape(digitMean,[28 28]));
    title("\mu for " + string(digit))
    subplot(1,3,3); imshow(reshape(digitMean + sqrt(e1) * v1,[28 28]));
    title("\mu + sqrt(\lambda_1) * v_1 for " + string(digit))
    
end