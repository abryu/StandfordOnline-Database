--Q1
--Find the titles of all movies directed by Steven Spielberg. 
SELECT title FROM Movie M WHERE M.director = 'Steven Spielberg';

--Q2
--Find all years that have a movie that received a rating of 4 or 5, and sort them in increasing order. 
SELECT DISTINCT year FROM Movie M JOIN Rating R ON M.mID = R.mID WHERE stars IN (4,5) ORDER BY year;

--Q3
--Find the titles of all movies that have no ratings. 
SELECT DISTINCT title FROM Movie WHERE mID NOT IN (SELECT mID FROM Rating);

--Q4
--Some reviewers didn't provide a date with their rating. Find the names of all reviewers who have ratings with a NULL value for the date. 
SELECT name FROM Reviewer INNER JOIN Rating ON Reviewer.rID = Rating.rID WHERE Rating.ratingDate IS NULL;

--Q5
--Write a query to return the ratings data in a more readable format: reviewer name, movie title, stars, and ratingDate. 
--Also, sort the data, first by reviewer name, then by movie title, and lastly by number of stars. 
SELECT name, title, stars, ratingDate FROM Movie M INNER JOIN Rating R ON M.mID = R.mID INNER JOIN Reviewer Re ON Re.rID = R.rID ORDER BY name, title, stars;

--Q6
--For all cases where the same reviewer rated the same movie twice and gave it a higher rating the second time, 
--return the reviewer's name and the title of the movie. 
SELECT name, title FROM Movie M, Reviewer Re, Rating R1, Rating R2 WHERE M.mID = R1.mID AND Re.rID = R1.rID AND R1.rID = R2.rID AND R2.mID = M.mID
AND R1.stars < R2.stars AND R1.ratingDate < R2.ratingDate;

--Q7
--For each movie that has at least one rating, find the highest number of stars that movie received. 
--Return the movie title and number of stars. Sort by movie title. 
SELECT title, MAX (stars) FROM Movie, Rating WHERE Movie.mID = Rating.mID GROUP BY Rating.mID ORDER BY title;

--Q8
--For each movie, return the title and the 'rating spread', that is, the difference between highest and lowest ratings given to that movie. 
--Sort by rating spread from highest to lowest, then by movie title. 
SELECT title, MAX (stars) - MIN (stars) AS spread FROM Movie INNER JOIN Rating ON Movie.mID = Rating.mID GROUP BY Movie.title ORDER BY spread DESC, title;

--Q9
--Find the difference between the average rating of movies released before 1980 and the average rating of movies released after 1980. 
--(Make sure to calculate the average rating for each movie, then the average of those averages for movies before 1980 and movies after. 
--Don't just calculate the overall average rating before and after 1980.) 
SELECT before.resultAve - after.resultAve
FROM
(SELECT AVG(ave) AS resultAve FROM 
(SELECT AVG(stars) AS ave
FROM Movie, Rating 
WHERE Movie.mID = Rating.mID AND year < 1980
GROUP BY title)) AS before
,
(SELECT AVG(ave) AS resultAve FROM 
(SELECT AVG(stars) AS ave
FROM Movie, Rating 
WHERE Movie.mID = Rating.mID AND year > 1980
GROUP BY title)) AS after;