printf("Loading movie ratings dataset.\n");
load("../data/movies.mat");

printf("Average rating for movie 1 (Toy Story): %f / 5\n",
        mean(Y(1, R(1, :))));

imagesc(Y);
ylabel("Movies");
xlabel("Users");
title("Moving ratings (more yellow indicate higher ratings, purple means no rating)");

% printf("Saving figure into figures/ratings.png\n");
% print -djpg ../figures/ratings.jpg