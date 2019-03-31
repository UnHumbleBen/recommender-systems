function movieList = loadMovieList()
%GETMOVIELIST reads the fixed movie list in
%movie_idx.txt and returns a cell array of the words
%   movieList = GETMOVIELIST() reads the fixed
%   movie list in movie_idx.txt and returns a
%   cell array of the words in movieList.

%% file pointer
fp = fopen("../data/movie_idx.txt");

% number of movies
n = 1682;

% initialize a cell array (since strings
% have different lengths, a matrix
% won't work)
movieList = cell(n, 1);
for i = 1:n
    % use fgets instead of fgetl to keep '\n' 
    line = fgets(fp);
    % idx gets the index
    % movieName gets the movie name
    % (but with some whitespace)
    [idx, movieName] = strtok(line, ' ');
    % remove whitespace and store into cell array
    movieList{i} = strtrim(movieName);
endfor

fclose(fp);

end