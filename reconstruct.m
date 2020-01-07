function [recon] = reconstruct (u, w_train, mean_image, num_eigen, num_image)
  proj = u(:,1:num_eigen) * w_train;
  recon = proj(:,num_image);
  recon = reshape(recon, size(mean_image));
  recon = recon + mean_image;
  imshow(uint8(recon));  
endfunction
