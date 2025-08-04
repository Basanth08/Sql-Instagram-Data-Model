# Instagram Database Clone

I created a comprehensive SQL database implementation that mirrors core Instagram functionality, demonstrating advanced SQL concepts and database design principles.

## 🎯 Project Overview

I built this project to implement a relational database system that replicates key features of Instagram, including user management, post creation, commenting, liking, and follower relationships. I designed it to showcase various SQL concepts and best practices in database design.

## 🏗️ Database Schema

I structured the database with five main tables:

### Users
- I implemented primary user information storage
- I added unique constraints on email and phone_number
- I used SERIAL for automatic ID generation
```sql
CREATE TABLE users(
    user_id SERIAL PRIMARY KEY,
    name varchar(50) NOT NULL,
    email varchar(50) UNIQUE NOT NULL,
    phone_number VARCHAR(20) UNIQUE
);
```

### Posts
- I created storage for user posts with captions and image URLs
- I implemented timestamp tracking
- I linked to users through foreign key constraints
```sql
CREATE TABLE posts(
    post_id SERIAL PRIMARY KEY,
    user_id INTEGER NOT NULL,
    caption TEXT,
    image_url VARCHAR(200),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY(user_id) REFERENCES users(user_id)
);
```

### Comments
- I designed user comment management on posts
- I implemented dual foreign key relationships
- I included timestamp tracking
```sql
CREATE TABLE comments(
    comment_id SERIAL PRIMARY KEY,
    post_id INTEGER NOT NULL,
    user_id INTEGER NOT NULL,
    comment_text TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (post_id) REFERENCES posts(post_id),
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);
```

### Likes
- I built user interaction tracking with posts
- I implemented many-to-many relationship
- I included timestamp tracking
```sql
CREATE TABLE likes(
    like_id SERIAL PRIMARY KEY,
    post_id INTEGER NOT NULL,
    user_id INTEGER NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (post_id) REFERENCES posts(post_id),
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);
```

### Followers
- I created user follow relationship management
- I implemented self-referential relationship
- I included timestamp tracking
```sql
CREATE TABLE followers(
    follower_id SERIAL PRIMARY KEY,
    user_id INTEGER NOT NULL,
    follower_user_id INTEGER NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);
```

## 🚀 Advanced SQL Concepts I Demonstrated

### 1. Complex Queries
- I used subqueries and derived tables
- I implemented Common Table Expressions (CTEs)
- I applied window functions for ranking
```sql
-- Example of post ranking based on likes
SELECT post_id, num_likes, RANK() OVER (ORDER BY num_likes DESC) AS rank
FROM (
    SELECT posts.post_id, COUNT(likes.like_id) AS num_likes
    FROM posts
    LEFT JOIN likes ON posts.post_id = likes.post_id
    GROUP BY posts.post_id
) AS likes_by_post;
```

### 2. Aggregation and Grouping
- I utilized GROUP BY clauses
- I applied HAVING filters
- I used aggregate functions (COUNT, SUM)
```sql
-- Posts with more than 2 likes
SELECT posts.post_id, COUNT(Likes.like_id) AS num_likes
FROM posts
LEFT JOIN Likes ON posts.post_id = likes.post_id
GROUP BY posts.post_id
HAVING COUNT(likes.like_id) > 2;
```

### 3. Join Operations
- I implemented LEFT JOIN for optional relationships
- I created multiple table joins
- I built self-joins in follower relationships

### 4. Data Categorization
- I used CASE statements for conditional logic
- I implemented dynamic category assignment
```sql
SELECT
    post_id,
    CASE
        WHEN num_likes = 0 THEN 'No likes'
        WHEN num_likes < 5 THEN 'Few likes'
        WHEN num_likes < 10 THEN 'Some likes'
        ELSE 'Lots of likes'
    END AS like_category
FROM ...
```

## 🔑 Key Features I Implemented

- **Referential Integrity**: I implemented through foreign key constraints
- **Automatic Timestamps**: I used DEFAULT CURRENT_TIMESTAMP
- **Data Validation**: I implemented through NOT NULL and UNIQUE constraints
- **Scalable Design**: I created proper indexing through primary keys
- **Flexible Queries**: I built support for complex data analysis and retrieval

## 📊 Database Statistics
- I created 5 core tables
- I wrote 15+ example queries
- I demonstrated complete CRUD operations
- I included sample data for testing

## 🛠️ Technologies I Used
- PostgreSQL
- SQL Standard: SQL-92 compliant
- SERIAL data type for ID generation
- Timestamp tracking
- Referential constraints

## 🎓 Learning Outcomes
I demonstrated proficiency in:
- Database schema design
- Complex SQL query writing
- Data relationship management
- Performance optimization techniques
- Data integrity maintenance

## 📝 Usage Examples I Created

### Finding User Activity
```sql
-- Get all comments by a specific user
SELECT name
FROM users
WHERE user_id IN (
    SELECT user_id
    FROM Comments
    WHERE post_id = 1
);
```

### Analyzing Post Engagement
```sql
-- Get total likes across all posts
SELECT SUM(num_likes) AS total_likes
FROM (
    SELECT COUNT(likes.like_id) AS num_likes
    FROM posts
    LEFT JOIN likes ON posts.post_id = likes.post_id
    GROUP BY posts.post_id
) AS likes_by_post;
```

## 🔄 Future Enhancements I'm Planning
- I plan to add support for story features
- I want to implement hashtag functionality
- I'm considering adding location-based queries
- I'll implement post analytics
- I plan to add user engagement metrics




