function [idx] = classify(u, w_train, img_test, mean_image)
  img_size = size(img_test, 1) * size(img_test, 2);
  
  img_test = double(img_test);
  
  new_projection = img_test - mean_image;
  projection_flat = reshape(new_projection, img_size, 1);
  w_test = u' * projection_flat;
  
  idx = 1;
  w_idx = norm(w_train(:,1) - w_test, 2);
  
  for i=2:size(w_train, 2)
    w_calc = norm(w_train(:,i) - w_test, 2);  
    if w_calc < w_idx
      w_idx = w_calc;
      idx = i;
    endif
  endfor
endfunction
