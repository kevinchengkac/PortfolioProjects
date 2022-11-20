/**Dashboard Highlights:
Fiction vs. Non Fiction count (pie graph) (filter by year?_
Count of Authors on Ranking [per year?] (bar graph/scatter plot)
Count of books per year (line graph)
List of rankings per year? (with filter for different years)**/

--Highlight everything in the spreadsheet
SELECT * FROM PortfolioProjects3..best_selling_books_2009_2021

--Order by star rating (descending), filter out NULL values via price column
SELECT * FROM PortfolioProjects3..best_selling_books_2009_2021
WHERE price is not null
ORDER BY ratings desc

/**Lists every author in the spreadsheet. There are some duplicates with different
formatting in there. Must find a way to group them together. Use UPDATE command, duh!**/
--Dups: DK, Erik Larson, George R. R. Martin, J.K. Rowling, J.D. Salinger
SELECT DISTINCT author FROM PortfolioProjects3..best_selling_books_2009_2021
WHERE author is not null

/**Dups:
10-Day Green Smootie Cleanse 
Born to Run
Burn After Writing
Catching Fire (Hunger Games)
Freedom
Little Blue Truck board book
Oh, the Places You'll Go!  
The Hunger Games (Book 1)
**/
SELECT DISTINCT title FROM PortfolioProjects3..best_selling_books_2009_2021
WHERE author is not null

--Update the duplicate author values
UPDATE PortfolioProjects3..best_selling_books_2009_2021 SET author = 'DK Publishing' WHERE author='DK'
UPDATE PortfolioProjects3..best_selling_books_2009_2021 SET author = 'Erik Larson' WHERE author='Eric Larson'
UPDATE PortfolioProjects3..best_selling_books_2009_2021 SET author = 'George R. R. Martin' WHERE author='George R.R. Martin'
UPDATE PortfolioProjects3..best_selling_books_2009_2021 SET author = 'J. K. Rowling' WHERE author='J.K. Rowling'
UPDATE PortfolioProjects3..best_selling_books_2009_2021 SET author = 'J. D. Salinger' WHERE author='J.D. Salinger'

--Update the duplicate book values
UPDATE PortfolioProjects3..best_selling_books_2009_2021 SET title = '110-Day Green Smoothie Cleanse: Lose Up to 15 Pounds in 10 Days!' WHERE title='10-Day Green Smoothie Cleanse'
UPDATE PortfolioProjects3..best_selling_books_2009_2021 SET title = 'Born to Run: A Hidden Tribe, Superathletes, and the Greatest Race the World Has Never Seen' WHERE title='Born to Run'
UPDATE PortfolioProjects3..best_selling_books_2009_2021 SET title = 'Burn After Writing (Pink)' WHERE title='Burn After Writing'
UPDATE PortfolioProjects3..best_selling_books_2009_2021 SET title = 'Catching Fire (The Hunger Games)' WHERE title='Catching Fire (Hunger Games)'
UPDATE PortfolioProjects3..best_selling_books_2009_2021 SET title = 'Freedom: A Novel' WHERE title='Freedom'
UPDATE PortfolioProjects3..best_selling_books_2009_2021 SET title = 'Little Blue Truck' WHERE title='Little Blue Truck board book'
UPDATE PortfolioProjects3..best_selling_books_2009_2021 SET title = 'Oh, the Places You''ll Go!' WHERE title='Oh, the Places You''ll Go! �'
UPDATE PortfolioProjects3..best_selling_books_2009_2021 SET title = 'The Hunger Games' WHERE title='The Hunger Games (Book 1)'

--Testing out updates (ex: J.K. Rowlings and Freedom: A Novel)
SELECT * FROM PortfolioProjects3..best_selling_books_2009_2021
WHERE 
	price is not null
	AND author like 'J. K. Rowling'
ORDER BY ratings desc

SELECT * FROM PortfolioProjects3..best_selling_books_2009_2021
WHERE
	price is not null
	AND title like 'Freedom%'

--Each row had a duplicate with them. This statement will get rid of those said duplicates. Ordered by the first column.
SELECT DISTINCT F1, price, ranks, title, no_of_reviews, ratings, author, cover_type, year, genre FROM PortfolioProjects3..best_selling_books_2009_2021
WHERE title is not null
ORDER BY F1

------------------------------SPECIFIC INFO THAT CAN BE VISUALIZED ON THE DASHBOARD---------------------------------------------
--Count total number of Fiction and Non Fiction books
SELECT COUNT(genre) AS ct_fiction FROM PortfolioProjects3..best_selling_books_2009_2021
WHERE genre = 'Fiction'

SELECT COUNT(genre) AS ct_nonfiction FROM PortfolioProjects3..best_selling_books_2009_2021
WHERE genre = 'Non Fiction'






