function [w_train] = training(u, A, num_eigen)
  w_train = (u(:, 1:num_eigen))' * A;
endfunction
