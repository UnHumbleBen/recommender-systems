function [J, grad] = cofiCostFunc(params, Y, R, num_users, ...
                                  num_movies, num_features, ...
                                  lambda)
%COFICOSTFUNC Collaborative filtering cost function
%   [J, grad] = COFICOSTFUNC(params, Y, R, num_users, ...
%   num_movies, num_features, lambda) returns the 
%   cost and gradient for the collaborative filtering
%   problem.
%

% Unfold params into X and Theta
totalX = num_movies * num_features;
X = reshape(params(1:totalX), num_movies, num_features);
Theta = reshape(params(totalX + 1: end), num_users, num_features);

% compute J
h = X * Theta';
Error = h - Y;
% filter out null ratings
Error = Error .* R;
% sum the squared errors
J = (0.5) * sum(sum(Error .^ 2));

% compute grad
gradX = (Error * Theta);
gradTheta = (Error' * X);
grad = [gradX(:); gradTheta(:)];


end                 