# number of eigenface for training
n_training = 40;

test_path = 'D:\RESEARCH\PCA Eigenfaces\CroppedYale\yaleB04\yaleB04_P00A-005E-10.pgm';
test_img = imread(test_path);
[idx] = classify(u, w_train, test_img, mean_image, n_training);