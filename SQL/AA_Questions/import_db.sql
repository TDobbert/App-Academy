PRAGMA foreign_keys = ON;

CREATE TABLE users (
  id INTEGER PRIMARY KEY,
  fname TEXT NOT NULL,
  lname TEXT NOT NULL
);

CREATE TABLE questions (
  id INTEGER PRIMARY KEY,
  title TEXT NOT NULL,
  body TEXT,
  users_id INTEGER NOT NULL,

  FOREIGN KEY (users_id) REFERENCES users(id)
);

CREATE TABLE question_follows (
  users_id INTEGER,
  questions_id INTEGER,

  FOREIGN KEY (users_id) REFERENCES users(id),
  FOREIGN KEY (questions_id) REFERENCES questions(id)
);

CREATE TABLE replies (
  id INTEGER PRIMARY KEY,
  questions_id INTEGER NOT NULL,
  parent_id INTEGER,
  users_id INTEGER NOT NULL,
  body TEXT,

  FOREIGN KEY (questions_id) REFERENCES questions(id),
  FOREIGN KEY (parent_id) REFERENCES replies(id),
  FOREIGN KEY (users_id) REFERENCES users(id)
);

CREATE TABLE question_likes (
  users_id INTEGER,
  questions_id INTEGER,
  likes INTEGER,

  FOREIGN KEY (users_id) REFERENCES users(id),
  FOREIGN KEY (questions_id) REFERENCES questions(id)
);

INSERT INTO
  users(fname, lname)
VALUES
  ('John', 'Doe'),
  ('Alex', 'Smith'),
  ('Jane', 'Doe');

INSERT INTO
  questions(title, body, users_id)
VALUES
  ('who', 'Who are you?', 1),
  ('where', 'Where am I?', 2);

INSERT INTO
  question_follows(users_id, questions_id)
VALUES
  (1, 1),
  (2, 2),
  (3, 1);

INSERT INTO
  replies(questions_id, parent_id, users_id, body)
VALUES
  (1, NULL, 1, 'I don''t know'),
  (2, NULL, 2, 'California'),
  (1, 1, 3, 'No clue' );

INSERT INTO
  question_likes(users_id, questions_id, likes)
VALUES
  (1, 1, 1),
  (2, 2, 0),
  (3, 1, 1);