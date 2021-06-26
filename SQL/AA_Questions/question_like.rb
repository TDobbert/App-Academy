require_relative 'questions_database'
require_relative 'user'
require_relative 'question'
require_relative 'model_base'

class QuestionLike < ModelBase
  attr_accessor :users_id, :questions_id, :likes

  def self.likers_for_question_id(questions_id)
    data = QuestionsDatabase.instance.execute(<<-SQL, questions_id)
      SELECT
        users.*
      FROM
        users
      JOIN
        question_likes ON question_likes.users_id = users.id
      WHERE
        question_likes.questions_id = ?
    SQL
    data.map { |datum| User.new(datum) }
  end

  def self.num_likes_for_question_id(questions_id)
    data = QuestionsDatabase.instance.execute(<<-SQL, questions_id)
      SELECT
        COUNT(*)
      FROM
        users
      JOIN
        question_likes ON question_likes.users_id = users.id
      WHERE
        question_likes.question_id = ?
    SQL
    data.first['count']
  end

  def self.liked_questions_for_user_id(users_id)
    data = QuestionsDatabase.instance.execute(<<-SQL, users_id)
      SELECT
        questions.*
      FROM
        questions
      JOIN
        question_likes ON question_likes.questions_id = questions.id
      WHERE
        question_likes.users_id = ?
    SQL
    data.map { |datum| Question.new(datum) }
  end

  def self.most_liked_questions(n)
    data = QuestionsDatabase.instance.execute(<<-SQL, n)
      SELECT
        questions.*
      FROM
        questions
      JOIN
        question_likes ON question_likes.questions_id = questions.id
      GROUP BY
        questions.id
      ORDER BY
        COUNT(*) DESC
      LIMIT
      ?
    SQL
    data.map { |datum| Question.new(datum) }
  end

  def initialize(options)
    @users_id = options['users_id']
    @questions_id = options['questions_id']
    @likes = options['likes']
  end
end
