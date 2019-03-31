# recommender-systems
Implementing and applying the collaborative filtering learning algorithm to a dataset of movie ratings

## Table of Contents
* [Movie ratings dataset](#movie-ratings-dataset)
* [Collaborative filtering learning algorithm](#collaborative-filtering-learning-algorithm)
* [Learning movie recommendations](#learning-movie-recommendations)
  * [Recommendations](#recommendations)
* [To-Do](#to\-do)

## Movie ratings dataset
The binary file **data/movies.mat** contains the variables ```Y```
and ```R```. 


* Let ```num_movies``` be the number of rows in ```Y```
, which is also the number of movies,
and ```num_users``` be the number of columns in ```Y```
, which is also the number of users.
```Y(i,j)``` stores the rating (from 1 to 5)
on the *ith* movie given by user *j*.
The matrix ```R``` has the same dimensions as ```Y```
(also ```num_movies``` *x* ```num_users```). 

* ```R(i, j) = 1``` if the *ith* movie was rated by the *jth* user.
Otherwise, ```R(i, j) = 0```.

The script in **tests/visualizeData.m** helps us visualize ```Y``` by
by computing the average movie rating for the first movie and outputting
the average rating to the screen. It also plots ```Y``` as colored image.
![Y dataset](figures/ratings.jpg)




The binary file **data/movieParams.mat** contains the variables
```X```, ```Theta```, ```num_movies```, ```num_users```, and
```num_features```. 


* ```num_movies``` and ```num_users``` are the same as the
variables defined earlier. 

* ```num_features``` is the number of columns in ```X```,
which is also the number of dimensions in the dataset.

* ```X``` is a ```num_movies``` *x* ```num_features``` matrix.
```X(i)``` is the feature vector for the *ith* movie.
```X(i, k)``` is the *kth* feature of the *ith* movie's feature vector.

* ```Theta``` is a ```num_users``` *x* ```num_features``` matrix.
```Theta(j)``` is the parameter vector for the *jth* user.
```Theta(j, k)``` is the *kth* parameter for the *jth* user's paramemter vector.



## Collaborative filtering learning algorithm
The function ```cofiCostFunc()``` in **src/cofiCostFunc.m** takes in the parameters
```params```, ```Y```, ```R```, ```num_users```, ```num_movies```, ```num_features```
and ```lambda``` and returns ```[J, grad]```.
* Arguments
  * ```Y```, ```R```, ```num_users```, ```num_movies```, ```num_features``` are defined
  the same as they are earlier.
  * ```params``` is a unrolled vector containing ```X``` and ```Theta```. This allows
  us to use packaged minimizers such as ```fmincg```.
  * ```lambda``` is the regularization parameter.
* Return values
  * ```J``` is the cost
  * ```grad``` is the gradient

## Learning movie recommendations
The script in **tests/movieReccomendation.m** generates some movie preferences (feel
free to modify them as you see fit). The list of all movies and their numbers can be
found in **data/movie_idx.txt**. 
### Recommendations
The script in **tests/movieRecommendations.m** trains the collaborative filtering model,
learning ```X``` and ```Theta```. ```Theta(j,:) * X(i, :)'``` predicts the rating for
*ith* movie from user *j*. The script computes the ratings for all the movies and users
and displays the movies that it reccommends.
* Sample run:
```
New user ratings:
Rated 4 for Toy Story (1995)
Rated 3 for Twelve Monkeys (1995)
Rated 5 for Usual Suspects, The (1995)
Rated 4 for Outbreak (1995)
Rated 5 for Shawshank Redemption, The (1994)
Rated 3 for While You Were Sleeping (1995)
Rated 5 for Forrest Gump (1994)
Rated 2 for Silence of the Lambs, The (1991)
Rated 4 for Alien (1979)
Rated 5 for Die Hard 2 (1990)
Rated 5 for Sphere (1998)

Top recommendations for you:
Predicting rating 4.6 for movie Star Wars (1977)
Predicting rating 4.6 for movie Shawshank Redemption, The (1994)
Predicting rating 4.5 for movie Maya Lin: A Strong Clear Vision (1994)
Predicting rating 4.5 for movie Close Shave, A (1995)
Predicting rating 4.5 for movie Schindler's List (1993)
Predicting rating 4.5 for movie Wrong Trousers, The (1993)
Predicting rating 4.5 for movie Titanic (1997)
Predicting rating 4.5 for movie Raiders of the Lost Ark (1981)
Predicting rating 4.5 for movie Wallace & Gromit: The Best of Aardman Animation (1996)
Predicting rating 4.5 for movie Empire Strikes Back, The (1980)
```

## To-Do
- [ ] improve consistency
  - [ ] tweak regularization parameter
  - [X] get rid of movies with low number of reviews
  - [ ] others...?
