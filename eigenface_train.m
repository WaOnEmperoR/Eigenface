list_content = [];
img_list = [];
img_list = cellstr(img_list);
n_person = 7;
# number of selected best eigenfaces
M = 70;
# number of eigenface for training
n_training = 40;

# image size
image_height = 192;
image_width = 168;  

# Dataset folder contains n folders
for i=1:n_person
  inner = num2str(i, '%02d');
  # path to folder
  concatenated = strcat("Dataset/", inner);
  # directory listing to get face images in folder 
  [list_content] = dir(concatenated);
  contentSize = size(list_content, 1);
  
  # the first two entry is a .. string, so we started at index 3 
  for j=3:contentSize
    img_list(end+1) = strcat(concatenated, "/", list_content(j).name); 
  endfor;
  
endfor;

img_list = img_list';
# the first element is empty
img_list = img_list(2:71,1);

images = [];

for j=1:size(img_list,1)
  path = char(img_list(j));
  images(j,:,:) = imread(path); 
endfor

# calculating mean image (uppercase psi)
m1 = mean(images);
m_temp = m1(1, :);
mean_image = reshape(m_temp, image_height, image_width);

substracted_images = [];

# original images - mean image (uppercase phi)
for j=1:size(images,1)
  tmp_img = images(j, :);
  tmp_img = reshape(tmp_img, image_height, image_width);  
  substracted_images(j, :, :) = tmp_img - mean_image;
endfor

begin_subs_img = substracted_images(1, :);
begin_subs_img = reshape(begin_subs_img, image_height * image_width, 1); 

A = [begin_subs_img];

for j=2:size(substracted_images, 1)
  begin_subs_img = substracted_images(j, :);
  begin_subs_img = reshape(begin_subs_img, image_height * image_width, 1); 

  A = [A begin_subs_img];   
endfor

L = A' * A;
# M eigenvectors with largest eigenvalues of A'A
[V, lambda] = eigs(L, M);

# u are eigenfaces
u = A * V;

# normalize eigenfaces
for i=1:M
  u(:,i) = u(:,i)/norm(u(:,i));  
endfor

# training, finding weight/coefficient for each image
[w_train] = training(u, A, n_training);

# image reconstruction
[recon] = reconstruct(u, w_train, mean_image, n_training, 25);
