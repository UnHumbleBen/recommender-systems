%% Initialization
clear;
close all;
clc;
addpath("../src");
addpath("../lib");

movieList = loadMovieList();

%% Get your movie ratings
ratings = zeros(1682, 1);
getMovieRatings;

printf("New user ratings:\n");
for i = 1:length(ratings)
    if ratings(i) > 0
        printf("Rated %d for %s\n", ratings(i), movieList{i});
    endif
endfor


printf("\nTraining collaborative filtering...\n");
printf("Loading dataset...\n");
load("../data/movies.mat");
printf("Adding new user rating to data matrix...\n");
Y = [ratings Y];
R = [(ratings ~= 0) R];

printf("Normalizing ratings...\n");
[Ynorm, Ymean] = normalizeRatings(Y, R);

num_users = size(Y, 2);
num_movies = size(Y, 1);
num_features = 10;

printf("Initializing random parameters...\n");
% randn Return a matrix with normally  
% distributed random elements having 
% zero mean and variance one.
X = randn(num_movies, num_features);
Theta = randn(num_users, num_features);

initial_parameters = [X(:); Theta(:)];

%% option structure for fmincg
% "GradObj" "on" indicates we provide a gradient function
% "MaxIter" 100 specifies maximum number of iterations
options = optimset("GradObj", "on", "MaxIter", 100);

% Set regularization
lambda = 10;
printf("Minimizing cost function...\n");
% function handler
f = @(t)(cofiCostFunc(t, Ynorm, R, num_users, num_movies, num_features, lambda));
theta = fmincg(f, initial_parameters, options);

printf("Recommender system learning completed...\n");
X = reshape(theta(1:num_movies*num_features), num_movies, num_features);
Theta = reshape(theta(num_movies*num_features+1:end), ...
                num_users, num_features);

%% Get recommendations
p = X * Theta';
predictions = p(:, 1) + Ymean;

%% Sort ratings in descending order
% r contains the sorted predictions
% ix contains the index of the corresponding element in r
[r, ix] = sort(predictions, "descend");
printf("\nTop recommendations for you:\n");
for i=1:10
    j = ix(i);
    name = movieList{j};
    rating = r(i);
    printf("Predicting rating %.1f for movie %s\n", predictions(j), name);
endfor