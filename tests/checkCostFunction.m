function checkCostFunction(lambda)
%CHECKCOSTFUNCTION Creates a collaborative filtering problem
%to check cost function and gradients
%   CHECKCOSTFUNCTION(lambda) Creates a collaborative filtering
%   to check your cost function and graidients, it will output
%   analytical gradients produced by cofiCostFunc() and
%   computeNumericalGradient().

% Set lambda
if ~exist('lambda', 'var') || isempty(lambda)
    lambda = 0;
endif

% Create small problem
X_t = rand(4, 3);
Theta_t = rand(5, 3);

% Zap out most entries
Y = X_t * Theta_t';
Y(rand(size(Y)) > 0.5) = 0;
R = zeros(size(Y));
R(Y ~= 0) = 1;

%% Run Gradient Checking
X = randn(size(X_t));
Theta = randn(size(Theta_t));
num_users = size(Y, 2);
num_movies = size(Y, 1);
num_features = size(Theta_t, 2);

numgrad = computeNumericalGradient(@(t) cofiCostFunc(t, Y, R, ...
                                   num_users, num_movies, ...
                                   num_features, lambda), ...
                                   [X(:); Theta(:)]);

[cost, grad] = cofiCostFunc([X(:); Theta(:)], Y, R, num_users, ...
                            num_movies, num_features, lambda);

disp([numgrad grad]);                        
printf("Left- Numerical Gradient, Right-Analytical Gradient\n");

diff = norm(numgrad - grad) / norm(numgrad+grad);
% '%g' format specifiers is either %f or %e depending on situation
printf("Relative Difference: %g\n", diff);
printf("Expected Difference: (less than 1e-9).\n");

end