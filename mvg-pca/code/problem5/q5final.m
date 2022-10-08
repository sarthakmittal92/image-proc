% PCA for Dimensionality Reduction

% load the data set
load("mnist.mat");

% looping the digits
for digit = 0:9

  % proceeding similar to previous question
  digitData = digits_train(:,:,labels_train == digit);
  image2D = im2double(digitData);
  digitData = reshape(image2D, 784,[]);
  digitMean = sum(digitData, 2) / size(digitData, 2);

  % finding projection matrix
  [projMat, basis] = q5function (digitData, 84);
  % reduced dimension data
  reducedData = basis * projMat;
  
  % plotting
  figure;
    axis equal;
    % picking an image and showing its reconstruction
    subplot(1, 2, 1);
    imagesc(reshape(digitMean + digitData(:, 40), [28 28]));
    title("Original image for " + string(digit))
    subplot(1, 2, 2);
    imagesc(reshape(digitMean + reducedData(:, 40), [28 28]));
    title("Reconstructed image for " + string(digit))

end

% function to reduce data (columnwise entries) into n dimensions
function [redMat, basis] = q5function (data, n)

  % finding mean
  mean = sum(data, 2) / size(data, 2);
  % mean-centric
  data = data - mean;
  % covariance (MLE)
  cov = data * data' / size(data, 2);
  
  % finding eigenvalues and eigenvectors
  [V, D] = eig(cov); 
  [~, ind] = sort(diag(D), 'descend');
  Vsort = V(:, ind);
  % basis from n largest eigenvectors
  basis = Vsort(:, 1:n);
  
  % reduced dimension data
  redMat = basis' * data;

end