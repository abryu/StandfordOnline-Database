--Q1
--Find the names of all reviewers who rated Gone with the Wind.
SELECT DISTINCT name FROM Reviewer Re INNER JOIN Rating R ON Re.rID = R.rID INNER JOIN Movie M ON R.mID = M.mID WHERE title = 'Gone with the Wind';

--Q2
--For any rating where the reviewer is the same as the director of the movie, return the reviewer name, movie title, and number of stars. 
SELECT name, title ,stars FROM Reviewer Re INNER JOIN Rating R USING (rID) INNER JOIN Movie M USING (mID) WHERE name = director;

--Q3
--Return all reviewer names and movie names together in a single list, alphabetized. 
--(Sorting by the first name of the reviewer and first word in the title is fine; no need for special processing on last names or removing "The".) 
SELECT name FROM Reviewer UNION SELECT title FROM Movie ORDER BY name,title;

--Q4
--Find the titles of all movies not reviewed by Chris Jackson. 
SELECT title FROM Movie WHERE mID NOT IN (SELECT R.mID FROM Movie M JOIN Rating R USING (mID) JOIN Reviewer Re using (rID) WHERE name = 'Chris Jackson');

--Q5
--For all pairs of reviewers such that both reviewers gave a rating to the same movie, return the names of both reviewers. Eliminate duplicates, 
--don't pair reviewers with themselves, and include each pair only once. For each pair, return the names in the pair in alphabetical order. 
SELECT DISTINCT R1.name, R2.name FROM Reviewer R1, Reviewer R2, Rating Ra1, Rating Ra2 WHERE R1.rID = Ra1.rID AND R2.rID = Ra2.rID AND Ra1.mID = Ra2.mID AND R1.name < R2.name;

--Q6
--For each rating that is the lowest (fewest stars) currently in the database, return the reviewer name, movie title, and number of stars. 
SELECT name, title, stars FROM Movie JOIN Rating USING (mID) JOIN Reviewer USING (rID) WHERE stars = (SELECT MIN (stars) FROM Rating);

--Q7
--List movie titles and average ratings, from highest-rated to lowest-rated. 
--If two or more movies have the same average rating, list them in alphabetical order. 
SELECT title, AVG (stars) AS ave FROM Movie M JOIN Rating USING (mID) GROUP BY M.mID ORDER BY ave DESC, title;

--Q8
--Find the names of all reviewers who have contributed three or more ratings. 
SELECT name FROM Reviewer JOIN Rating USING (rID) GROUP BY rID HAVING COUNT (rID) > 2;

--Q9
--Some directors directed more than one movie. For all such directors, return the titles of all movies directed by them, along with the director name. 
--Sort by director name, then movie title. (As an extra challenge, try writing the query both with and without COUNT.) 

--Q10
--Find the movie(s) with the highest average rating. Return the movie title(s) and average rating. 
--(Hint: This query is more difficult to write in SQLite than other systems; 
--you might think of it as finding the highest average rating and then choosing the movie(s) with that average rating.) 

--Q11
--Find the movie(s) with the lowest average rating. Return the movie title(s) and average rating. 
--(Hint: This query may be more difficult to write in SQLite than other systems; 
--you might think of it as finding the lowest average rating and then choosing the movie(s) with that average rating.) 

--Q12
--For each director, return the director's name together with the title(s) of the movie(s) they directed that received the highest rating among all of their movies, 
--and the value of that rating. Ignore movies whose director is NULL. 
SELECT director, title, MAX (stars) FROM Movie JOIN Rating USING (mID) WHERE director IS NOT NULL GROUP BY director;