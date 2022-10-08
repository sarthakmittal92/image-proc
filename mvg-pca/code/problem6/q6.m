% PCA for Image Dataset

% directory
Dir = "data_fruit/";

% list of images
images = dir(fullfile(Dir,"*.png"));
num = length(images);

% store images
imageData = zeros([19200,num],"double"); 

for i = 1:num
  % read image
  image = fullfile(Dir,images(i).name);
  im = imread(image);
  % reshape into column vector and add to matrix
  imageData(:,i) = reshape(im,[19200, 1]);
end

% PCA calculation as before
imageMean = sum(imageData,2) / size(imageData,2);
finalData = imageData - imageMean; 
cov = finalData * finalData' / size(imageData,2);
% taking top 4 eigenvalues
[eVector, eValues] = eigs(cov,4);
    
% plotting all images
figure
  subplot(2,4,1), imagesc(rescale(reshape(imageMean,[80, 80, 3])))
  title("Mean of all fruit images")
  subplot(2,4,2), imagesc(rescale(reshape(eVector(:,1),[80, 80, 3])))
  title("1^{st} eigenvector")
  subplot(2,4,3), imagesc(rescale(reshape(eVector(:,2),[80, 80, 3])))
  title("2^{nd} eigenvector")
  subplot(2,4,4), imagesc(rescale(reshape(eVector(:,3),[80, 80, 3])))
  title("3^{rd} eigenvector")
  subplot(2,4,5), imagesc(rescale(reshape(eVector(:,4),[80, 80, 3])))
  title("4^{th} eigenvector")

% top 10 eigenvalues
top10eValues = eigs(cov,10);
% graph
figure
  plot(top10eValues,"Marker",".")
  title("First 10 eigenvalues")

% finding reconstructed images on smaller dimension
% projection
weights = eVector' * imageData;
% reconstruction
restrucImages = eVector * weights + imageMean;

for i = 1:num
  figure
    % original image (add mean back)
    subplot(1,2,1), imshow(rescale(reshape(imageData(:,i) + imageMean,[80, 80,3])))
    title("Original image for " + num2str(i))
    % reconstructed image
    subplot(1,2,2), imshow(rescale(reshape(restrucImages(:,i),[80, 80,3])))
    title("Reconstructed image for " + num2str(i))
end

rng(18);

for i = 1:3
  % weights for linear combination
  w = randn(4,1) * norm(imageMean);
  % construct the image of fruit from the weights
  newImage = eVector * w + imageMean;
  %display the image
  figure, imshow(rescale(reshape(newImage,[80, 80,3]))) 
  title("Random image " + num2str(i))
end