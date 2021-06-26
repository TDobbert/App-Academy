require_relative 'questions_database'
require_relative 'user'
require_relative 'question'
require_relative 'model_base'

class Reply < ModelBase
  attr_accessor :id, :questions_id, :parent_id, :users_id, :body

  def self.find_by_id(id)
    data = QuestionsDatabase.instance.execute(<<-SQL, id)
    SELECT
      *
    FROM
      replies
    WHERE
      id = ?
    SQL
    Reply.new(data.first)
  end

  def self.find_by_user_id(users_id)
    data = QuestionsDatabase.instance.execute(<<-SQL, users_id)
      SELECT
        *
      FROM
        replies
      WHERE
        users_id = ?
    SQL
    raise "#{users_id} not in database" if data.nil?

    data.map { |datum| Reply.new(datum) }
  end

  def self.find_by_question_id(questions_id)
    data = QuestionsDatabase.instance.execute(<<-SQL, questions_id)
      SELECT
        *
      FROM
        replies
      WHERE
        questions_id = ?
    SQL
    raise "#{questions_id} not in database" if data.nil?

    data.map { |datum| Reply.new(datum) }
  end

  def self.find_by_parent_id(parent_id)
    data = QuestionsDatabase.instance.execute(<<-SQL, parent_id)
      SELECT
        *
      FROM
        replies
      WHERE
        parent_id = ?
    SQL
    raise "#{parent_id} not in database" if data.nil?

    data.map { |datum| Reply.new(datum) }
  end

  def initialize(options)
    @id = options['id']
    @questions_id = options['questions_id']
    @parent_id = options['parent_id']
    @users_id = options['users_id']
    @body = options['body']
  end

  def author
    User.find_by_id(@users_id)
  end

  def question
    Question.find_by_id(@questions_id)
  end

  def parent_reply
    raise 'no parent' if @parent_id.nil?

    Reply.find_by_id(@parent_id)
  end

  def child_replies
    Reply.find_by_parent_id(@id)
  end

  def save
    @id ? update : create
  end

  def create
    QuestionsDatabase.instance.execute(<<-SQL, @title, @body, @questions_id, @parent_id, @users_id)
      INSERT INTO
        replies (title, body, questions_id, parent_id, users_id)
      VALUES
        (?, ?, ?, ?, ?)
    SQL
    @id = QuestionsDatabase.instance.last_insert_row_id
  end

  def update
    QuestionsDatabase.instance.execute(<<-SQL, @title, @body, @questions_id, @parent_id, @users_id, @id)
      UPDATE
        replies
      SET
        title = ?, body = ?, questions_id = ?, parent_id = ?, users_id = ?
      WHERE
        id = ?
    SQL
  end
end
