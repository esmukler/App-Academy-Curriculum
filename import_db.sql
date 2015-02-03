CREATE TABLE users (
  id INTEGER PRIMARY KEY,
  fname Varchar(255) NOT NULL,
  lname Varchar(255) NOT NULL
);

CREATE TABLE questions (
  id INTEGER PRIMARY KEY,
  title VARCHAR(255) NOT NULL,
  body VARCHAR(255) NOT NULL,
  author_id INTEGER NOT NULL,
  FOREIGN KEY (author_id) REFERENCES users(id)
);

CREATE TABLE question_followers (
  question_id INTEGER NOT NULL,
  follower_id INTEGER NOT NULL,
  FOREIGN KEY (question_id) REFERENCES questions(id),
  FOREIGN KEY (follower_id) REFERENCES users(id)
);

CREATE TABLE replies (
  id INTEGER PRIMARY KEY,
  question INTEGER NOT NULL,
  parent_reply INTEGER,
  replier_id INTEGER NOT NULL,
  body varchar(255) NOT NULL,
  FOREIGN KEY (question) REFERENCES questions(id),
  FOREIGN KEY (parent_reply) REFERENCES replies(id),
  FOREIGN KEY (replier_id) REFERENCES users(id)
);

CREATE TABLE question_likes(
  question_id INTEGER NOT NULL,
  liker_id INTEGER NOT NULL,
  FOREIGN KEY (question_id) REFERENCES questions(id),
  FOREIGN KEY (liker_id) REFERENCES users(id)
);


INSERT INTO
  users (fname, lname)
VALUES
  ('Albert', 'Einstein'),
  ('Kurt', 'Godel');


INSERT INTO
  questions (title, body, author_id)
VALUES
  ('hi', 'hello I am einstein', (SELECT id FROM users WHERE fname = 'Albert')),
  ('hey', 'it is kurt yo', (SELECT id FROM users WHERE fname = 'Kurt'));

INSERT INTO
  question_followers (question_id, follower_id)
VALUES
  ((SELECT id FROM questions WHERE title = 'hi'), (SELECT id FROM users WHERE fname = 'Kurt')),
  ((SELECT id FROM questions WHERE title = 'hey'), (SELECT id FROM users WHERE fname = 'Albert'));

INSERT INTO
  replies (question, parent_reply, replier_id, body)
VALUES
  ((SELECT id FROM questions WHERE title = 'hi'), NULL,
    (SELECT id FROM users WHERE fname = 'Kurt'), 'Einstein! You suck.'),
  ((SELECT id FROM questions WHERE title = 'hi'), (SELECT id FROM replies WHERE body = 'Einstein! You suck.'),
    (SELECT id FROM users WHERE fname = 'Albert'), 'Get off the Internet, dude!');

INSERT INTO
  question_likes (question_id, liker_id)
VALUES
  ((SELECT id FROM questions WHERE title = 'hi'), (SELECT id FROM users WHERE fname = 'Kurt')),
  ((SELECT id FROM questions WHERE title = 'hey'), (SELECT id FROM users WHERE fname = 'Albert'));
