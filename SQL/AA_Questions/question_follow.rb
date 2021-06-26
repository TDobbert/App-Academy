require_relative 'questions_database'
require_relative 'user'
require_relative 'question'
require_relative 'model_base'

class QuestionFollow < ModelBase
  attr_accessor :users_id, :questions_id

  def self.followers_for_question_id(questions_id)
    data = QuestionsDatabase.instance.execute(<<-SQL, questions_id)
      SELECT
        users.*
      FROM
        users
      JOIN
        question_follows ON question_follows.users_id = users.id
      WHERE
        questions_id = ?
    SQL
    data.map { |datum| User.new(datum) }
  end

  def self.followed_questions_for_user_id(users_id)
    data = QuestionsDatabase.instance.execute(<<-SQL, users_id)
      SELECT
        questions.*
      FROM
        questions
      JOIN
        question_follows ON question_follows.question_id = questions.id
      WHERE
        users_id = ?
    SQL
    data.map { |datum| Question.new(datum) }
  end

  def self.most_followed_questions(n)
    data = QuestionsDatabase.instance.execute(<<-SQL, n)
      SELECT
        questions.*
      FROM
        questions
      JOIN
        question_follows ON question_follows.questions_id = questions.id
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
  end
end
