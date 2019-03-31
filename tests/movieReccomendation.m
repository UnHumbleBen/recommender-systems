%% Initialization
clear;
close all;
clc;
addpath("../src");

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