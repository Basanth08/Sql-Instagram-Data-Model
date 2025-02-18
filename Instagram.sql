CREATE TABLE users(
	user_id SERIAL PRIMARY KEY,
	name varchar(50) NOT NULL,
	email varchar(50) UNIQUE NOT NULL,
	phone_number VARCHAR(20) UNIQUE
);

CREATE TABLE posts(
    post_id SERIAL PRIMARY KEY,
    user_id INTEGER NOT NULL,
    caption TEXT,
    image_url VARCHAR(200),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY(user_id) REFERENCES users(user_id)
);

CREATE TABLE comments(
	comment_id SERIAL PRIMARY KEY,
	post_id INTEGER NOT NULL,
	user_id INTEGER NOT NULL,
	comment_text TEXT NOT NULL,
	created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	FOREIGN KEY ( post_id) REFERENCES posts(post_id),
	FOREIGN KEY (user_id) REFERENCES users(user_id)
);

CREATE TABLE likes(
	like_id SERIAL PRIMARY KEY,
	post_id INTEGER NOT NULL,
	user_id INTEGER NOT NULL,
	created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	FOREIGN KEY ( post_id) REFERENCES posts(post_id),
	FOREIGN KEY (user_id) REFERENCES users(user_id)
);

CREATE TABLE followers(
	follower_id SERIAL PRIMARY KEY,
	user_id INTEGER NOT NULL,
	follower_user_id INTEGER NOT NULL,
	created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	FOREIGN KEY (user_id) REFERENCES users(user_id)
);

-- Inserting into Users table
INSERT INTO Users (name, email, phone_number)
VALUES
    ('John Smith', 'johnsmith@gmail.com', '1234567890'),
    ('Jane Doe', 'janedoe@yahoo.com', '0987654321'),
    ('Bob Johnson', 'bjohnson@gmail.com', '1112223333'),
    ('Alice Brown', 'abrown@yahoo.com', NULL),
    ('Mike Davis', 'mdavis@gmail.com', '5556667777');
	
ALTER TABLE posts
ADD COLUMN image_url VARCHAR(200);

INSERT INTO posts (user_id, caption, image_url)
VALUES
    (1, 'Beautiful sunset', '<https://www.example.com/sunset.jpg>'),
    (2, 'My new puppy', '<https://www.example.com/puppy.jpg>'),
    (3, 'Delicious pizza', '<https://www.example.com/pizza.jpg>'),
    (4, 'Throwback to my vacation', '<https://www.example.com/vacation.jpg>'),
    (5, 'Amazing concert', '<https://www.example.com/concert.jpg>');

-- Inserting into Comments table
INSERT INTO comments (post_id, user_id, comment_text)
VALUES
    (1, 2, 'Wow! Stunning.'),
    (1, 3, 'Beautiful colors.'),
    (2, 1, 'What a cutie!'),
    (2, 4, 'Aww, I want one.'),
    (3, 5, 'Yum!'),
    (4, 1, 'Looks like an awesome trip.'),
    (5, 3, 'Wish I was there!');

INSERT INTO likes (post_id, user_id)
VALUES
    (1, 2),
    (1, 4),
    (2, 1),
    (2, 3),
    (3, 5),
    (4, 1),
    (4, 2),
    (4, 3),
    (5, 4),
    (5, 5);

-- Inserting into Followers table
INSERT INTO followers (user_id, follower_user_id)
VALUES
    (1, 2),
    (2, 1),
    (1, 3),
    (3, 1),
    (1, 4),
    (4, 1),
    (1, 5),
    (5, 1);

-- Updating the Caption of post Id 3
UPDATE posts
SET caption = 'Best pizza ever!!!'
WHERE post_id = 3;

-- Selecting all the posts where user_id is 1
SELECT * FROM posts
WHERE user_id = 1;

-- Selecting all the posts and ordering them by created_at in descending order
SELECT * FROM posts
ORDER BY created_at DESC;

-- Counting the number of likes for each post and showing only the posts with more than 2 likes
SELECT posts.post_id, COUNT(Likes.like_id) AS num_likes
FROM posts
LEFT JOIN Likes ON posts.post_id = likes.post_id
GROUP BY posts.post_id
HAVING COUNT(likes.like_id) > 2;

-- Finding the total number of likes for all posts
SELECT SUM(num_likes) AS total_likes
FROM (
    SELECT COUNT(likes.like_id) AS num_likes
    FROM posts
    LEFT JOIN likes ON posts.post_id = likes.post_id
    GROUP BY posts.post_id
) AS likes_by_post; 
 

-- Finding all the users who have commented on post_id 1
SELECT name
FROM users
WHERE user_id IN (
    SELECT user_id
    FROM Comments
    WHERE post_id = 1
);

-- Ranking the posts based on the number of likes
SELECT post_id, num_likes, RANK() OVER (ORDER BY num_likes DESC) AS rank
FROM (
    SELECT posts.post_id, COUNT(likes.like_id) AS num_likes
    FROM posts
    LEFT JOIN likes ON posts.post_id = likes.post_id
    GROUP BY posts.post_id
) AS likes_by_post;

-- Finding all the posts and their comments using a Common Table Expression (CTE)
WITH post_comments AS (
    SELECT posts.post_id, posts.caption, comments.comment_text
    FROM posts
    LEFT JOIN Comments ON posts.post_id = comments.post_id
)
SELECT *
FROM post_comments;

-- Categorizing the posts based on the number of likes
SELECT
    post_id,
    CASE
        WHEN num_likes = 0 THEN 'No likes'
        WHEN num_likes < 5 THEN 'Few likes'
        WHEN num_likes < 10 THEN 'Some likes'
        ELSE 'Lots of likes'
    END AS like_category
FROM (
    SELECT Posts.post_id, COUNT(Likes.like_id) AS num_likes
    FROM Posts
    LEFT JOIN Likes ON Posts.post_id = Likes.post_id
    GROUP BY Posts.post_id
) AS likes_by_post;
  

SELECT * FROM users;
SELECT * FROM posts;
SELECT * FROM comments;
SELECT * FROM likes;
SELECT * FROM followers;


	