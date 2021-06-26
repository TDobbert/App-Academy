require 'active_support/inflector'
require_relative 'questions_database'

class ModelBase

  def self.table
    to_s.tableize
  end

  def self.all
    data = QuestionsDatabase.instance.execute(<<-SQL)
      SELECT
        *
      FROM
        #{table}
    SQL
    data.map { |datum| new(datum) }
  end

  def find_by_id(id)
    data = QuestionsDatabase.instance.execute(<<-SQL, id: id)
      SELECT
        *
      FROM
        #{table}
      WHERE
        id = :id
    SQL
    raise "#{id} not in database" if data.nil?

    new(data.first)
  end

  def accessor
    Hash[instance_variables.map do |name|
      [name.to_s[1..-1], instance_variable_get(name)]
    end]
  end

  def save
    id ? update : create
  end

  def create
    raise 'Already saved' unless id.nil?

    instance_attrs = accessor
    instance_attrs.delete('id')
    col_names = instance_attrs.keys.join(', ')
    question_marks = (['?'] * instance_attrs.count).join(', ')
    values = instance_attrs.values

    QuestionsDatabase.instance.execute(<<-SQL, *values)
      INSERT INTO
        #{table} (#{col_names})
      VALUES
        (#{question_marks})
    SQL
    @id = QuestionsDatabase.instance.last_insert_row_id
  end

  def update
    raise "#{self} not in database" if id.nil?

    instance_attrs = accessor
    instance_attrs.delete('id')
    set_line = instance_attrs.keys.map { |attr| "#{attr} = ?" }.join(', ')
    values = instance_attrs.values

    QuestionsDatabase.instance.execute(<<-SQL, *values, id)
      UPDATE
        #{table}
      SET
        #{set_line}
      WHERE
        id = ?
    SQL
    self
  end
end
