CREATE TABLE restaurant(
    id int primary key,
    name text,
    address varchar,
    category text
);

CREATE TABLE reviewer(
    id int primary key,
    name text,
    email varchar,
    karma int CHECK (karma > 0 OR karma < 7)
);

CREATE TABLE review(
    id serial primary key,
    reviewer_id int
    REFERENCES reviewer (id),
    stars int CHECK(stars <= 5 OR stars >= 1),
    title text,
    review varchar,
    restaurant_id int
    REFERENCES restaurant (id)
);

-- Run in terminal: psql <insert db name> -f <filename.sql>


-- Insert restaurant DATA 
INSERT INTO restaurant (id, name, address, category)
VALUES (1,'Grandma''s Kitchen', '420 Honeycomb Drive', 'Southern'),

(2, 'Smokey Village', '1234 Hedgeway Blvd', 'BBQ'),

(3, 'Chalupa Galore', '69 Victory Road', 'Mexican'),

(4, 'Greenies', '104 Railway Road', 'Vegetarian'),

(5, 'Wingdom', '111 Grand Royal Street', 'American'),

(6, 'China Supreme Hibachi', '94 Ape Road', 'Chinese'),

(7, 'Franky''s Bowl', '87 Rockford Drive', 'Mexican'),

(8, 'Striker''s', '40 Rompy Blvd', 'American'),

(9, 'Animal Kingdom', '07 Winter Street', 'BBQ');


-- Insert Reviewer DATA
INSERT INTO reviewer  (id, name, email, karma)
VALUES (1, 'George', 'DasGeorge23@hotmail.com', 3),

(2, 'Dory', 'nottherealdory01@yahoo.com', 5),

(3, 'Sasha', 'huskylover23@gmail.com', 6),

(4, 'Corvin', 'mustachemilk55@yahoo.com', 1),

(5, 'Brie', 'berrytequila8@hotmail.com', 4);


-- Insert Review DATA
INSERT INTO review (reviewer_id, restaurant_id, stars, title, review)
VALUES (1, 1, 3, 'meh', 'Food was okay, service was decent'),

(1, 2, 5, 'Great Experience', 'Service was excellent, food was prompt and fantastic!'),

(2, 3, 2, 'Worst place ever, don''t come here.', 'It took 20 minutes before the server even acknowledged us for drinks, and when we ordered food, it arrived cold'),

(2, 4, 4, 'Definitely will come back', 'First time trying this place and it was a pleasant experience, try the watermelon mimosa, its the best!'),

(3, 5, 5, 'AWESOME, GREAT SERVICE AND FOOD', 'Came here with zero expectations, and was thoroughly impressed by everything'),

(3, 6, 5, 'Their fish tacos are soooooo gooooooood', 'Hear me out, but you must try the fish tacos, they are a hidden gem!'),

(4, 7, 1, 'Let me save you the trouble, RUN!', 'The rumors were true and I wanted to confirm it for myself, the food is the nastiest I have ever tastest, the worst of it all are the hidden fees'),

(4, 8, 4, 'I found a new lunch joint', 'The service is really fast paced, which was slightly stressful, because of the huge line, but so far all of their food items are solid'),

(5, 9, 1, 'Wow, what a huge disappointment', 'I rarely find places that are this bad, let me just say I''m not coming here again'),

(5, 9, 3, 'Not bad, worth a try', 'Personally wasn''t blown away from the food, although service is decent, I feel like others would enjoy it more though');




-- Answer these questions with a query

-- 1. List all the reviews for a given restaurant given a specific restaurant ID
SELECT *
FROM review
WHERE restaurant_id = 1;

-- 2. List all the reviews for a given restaurant, given a specific restaurant name
SELECT * 
FROM review
INNER JOIN restaurant
ON review.restaurant_id = restaurant.id
WHERE restaurant.name = 'wingdom';

-- 3. List all the reviews for a given reviewer, given a specific author name
SELECT *
FROM review
INNER JOIN reviewer
ON review.reviewer_id = reviewer.id
WHERE reviewer.name = 'Dory';

-- 4. List all the reviews along with the restaurant they were written for. In the query result, select the restaurant name
-- and the review text.
SELECT restaurant.name, review.review
FROM restaurant, review
WHERE restaurant.id = review.restaurant_id;

-- 5. Get the average stars by restaurant. The result should have the restaurant name and its average star rating.
SELECT restaurant.name, avg(review.stars)
FROM restaurant, review
WHERE restaurant.id = review.restaurant_id
GROUP BY restaurant.name;

-- 6. Get the number of reviews written for each restaurant. The result should have the restaurant name and its review count.
SELECT restaurant.name, count(review.review)
FROM restaurant, review
WHERE restaurant.id = review.restaurant_id
GROUP BY restaurant.name;

-- 7. List all the reviews along with the restaurant, and the reviewer's name. The result should have the restaurant name, the review text, and the reviewer name. 
-- Hint: you will need to do a three-way join - i.e. joining all three tables together.
SELECT restaurant.name, reviewer.name, review.review
FROM restaurant, reviewer, review
WHERE restaurant.id = review.restaurant_id
AND reviewer.id = review.reviewer_id;

-- 8. Get the average stars given by each reviewer. (reviewer name, average star rating)
SELECT reviewer.name, avg(review.stars)
FROM reviewer, review
WHERE reviewer.id = review.reviewer_id
GROUP BY reviewer.name;

-- 9. Get the lowest star rating given by each reviewer. (reviewer name, lowest star rating)
SELECT reviewer.name, min(review.stars)
FROM reviewer, review
WHERE reviewer.id = review.restaurant_id
GROUP BY reviewer.name;

-- 10. Get the number of restaurants in each category. (category name, restaurant count)
SELECT category, count(category)
FROM restaurant
GROUP BY category;

-- 11. Get number of 5 star reviews given by restaurant. (restaurant name, 5-star count)
SELECT restaurant.name, count(review.stars)
FROM restaurant, review
WHERE review.stars = 5
AND restaurant.id = review.restaurant_id
GROUP BY restaurant.name;

-- 12. Get the average star rating for a food category. (category name, average star rating)
SELECT restaurant.category, avg(review.stars)
FROM restaurant, review
WHERE restaurant.id = review.restaurant_id
GROUP BY restaurant.category;