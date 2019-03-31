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