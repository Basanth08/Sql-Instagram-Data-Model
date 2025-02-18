# Instagram Database Clone

A comprehensive SQL database implementation that mirrors core Instagram functionality, demonstrating advanced SQL concepts and database design principles.

## 🎯 Project Overview

This project implements a relational database system that replicates key features of Instagram, including user management, post creation, commenting, liking, and follower relationships. It showcases various SQL concepts and best practices in database design.

## 🏗️ Database Schema

The database consists of five main tables:

### Users
- Primary user information storage
- Implements unique constraints on email and phone number
- Uses SERIAL for automatic ID generation
```sql
CREATE TABLE users(
    user_id SERIAL PRIMARY KEY,
    name varchar(50) NOT NULL,
    email varchar(50) UNIQUE NOT NULL,
    phone_number VARCHAR(20) UNIQUE
);
```

### Posts
- Stores user posts with captions and image URLs
- Implements timestamp tracking
- Links to users through foreign key constraints
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
- Manages user comments on posts
- Implements dual foreign key relationships
- Includes timestamp tracking
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
- Tracks user interactions with posts
- Implements many-to-many relationship
- Includes timestamp tracking
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
- Manages user follow relationships
- Implements self-referential relationship
- Includes timestamp tracking
```sql
CREATE TABLE followers(
    follower_id SERIAL PRIMARY KEY,
    user_id INTEGER NOT NULL,
    follower_user_id INTEGER NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);
```

## 🚀 Advanced SQL Concepts Demonstrated

### 1. Complex Queries
- Subqueries and derived tables
- Common Table Expressions (CTEs)
- Window functions for ranking
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
- GROUP BY clauses
- HAVING filters
- Aggregate functions (COUNT, SUM)
```sql
-- Posts with more than 2 likes
SELECT posts.post_id, COUNT(Likes.like_id) AS num_likes
FROM posts
LEFT JOIN Likes ON posts.post_id = likes.post_id
GROUP BY posts.post_id
HAVING COUNT(likes.like_id) > 2;
```

### 3. Join Operations
- LEFT JOIN for optional relationships
- Multiple table joins
- Self-joins in follower relationships

### 4. Data Categorization
- CASE statements for conditional logic
- Dynamic category assignment
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

## 🔑 Key Features

- **Referential Integrity**: Implemented through foreign key constraints
- **Automatic Timestamps**: Used DEFAULT CURRENT_TIMESTAMP
- **Data Validation**: Implemented through NOT NULL and UNIQUE constraints
- **Scalable Design**: Proper indexing through primary keys
- **Flexible Queries**: Support for complex data analysis and retrieval

## 📊 Database Statistics
- 5 core tables
- 15+ example queries
- Complete CRUD operations demonstrated
- Sample data included for testing

## 🛠️ Technologies Used
- PostgreSQL
- SQL Standard: SQL-92 compliant
- SERIAL data type for ID generation
- Timestamp tracking
- Referential constraints

## 🎓 Learning Outcomes
This project demonstrates proficiency in:
- Database schema design
- Complex SQL query writing
- Data relationship management
- Performance optimization techniques
- Data integrity maintenance

## 📝 Usage Examples

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

## 🔄 Future Enhancements
- Add support for story features
- Implement hashtag functionality
- Add location-based queries
- Implement post analytics
- Add user engagement metrics

## 📜 License
This project is available for educational purposes and demonstrates SQL database design and implementation concepts.
