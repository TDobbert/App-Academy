require_relative 'questions_database'
require_relative 'question_follow'
require_relative 'question_like'
require_relative 'user'
require_relative 'reply'
require_relative 'model_base'

class Question < ModelBase
  attr_accessor :id, :title, :body, :users_id

  def self.find_by_id(id)
    data = QuestionsDatabase.instance.execute(<<-SQL, id)
    SELECT
      *
    FROM
      questions
    WHERE
      id = ?
    SQL
    Question.new(data.first)
  end

  def self.find_by_author_id(users_id)
    data = QuestionsDatabase.instance.execute(<<-SQL, users_id)
      SELECT
        *
      FROM
        questions
      WHERE
        users_id = ?
    SQL
    raise "#{users_id} not in database" if data.nil?

    data.map { |datum| Question.new(datum) }
  end

  def self.most_liked(n)
    QuestionLike.most_liked_questions(n)
  end

  def initialize(options)
    @id = options['id']
    @title = options['title']
    @body = options['body']
    @users_id = options['users_id']
  end

  def author
    User.find_by_id(@users_id)
  end

  def replies
    Reply.find_by_question_id(@id)
  end

  def followers
    QuestionFollow.followers_for_question_id(@id)
  end

  def most_followed(n)
    QuestionFollow.most_followed_questions(n)
  end

  def likers
    QuestionLike.likers_for_question_id(@id)
  end

  def num_likes
    QuestionLike.num_likes_for_question_id(@id)
  end

  def save
    @id ? update : create
  end

  def create
    QuestionsDatabase.instance.execute(<<-SQL, @title, @body, @users_id)
      INSERT INTO
        questions (title, body, users_id)
      VALUES
        (?, ?, ?)
    SQL
    @id = QuestionsDatabase.instance.last_insert_row_id
  end

  def update
    QuestionsDatabase.instance.execute(<<-SQL, @title, @body, @users_id, @id)
      UPDATE
        questions
      SET
        title = ?, body = ?, users_id = ?
      WHERE
        id = ?
    SQL
  end
end
