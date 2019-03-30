addpath("../src")

load("../data/movies.mat");
load("../data/movieParams.mat");

% Reduce the data set size for faster run time
num_users = 4; num_movies = 5; num_features = 3;
X = X(1:num_movies, 1:num_features);
Theta = Theta(1:num_users, 1:num_features);
Y = Y(1:num_movies, 1:num_users);
R = R(1:num_movies, 1:num_users);

% Evaluate cost function
J = cofiCostFunc([X(:) ; Theta(:)], Y, R, num_users, ...
                 num_movies, num_features, 0);

printf("Cost at loaded parameters: %f\n", J);
printf("Expected cost            : 22.22\n");

%% Testing gradient
printf("Checking gradient (without regularization) ... \n");
checkCostFunction;

%% Regularization
J = cofiCostFunc([X(:) ; Theta(:)], Y, R, num_users, ...
                 num_movies, num_features, 1.5);
printf("Cost at loaded parameters (lambda = 1.5): %f\n", J);
printf("Expected cost                           : 31.34\n");

printf("Checking gradient (with regularization) ...\n");
checkCostFunction(1.5);
