class Response < ApplicationRecord
  belongs_to :answer_choice,
    primary_key: :id,
    foreign_key: :answer_choice_id,
    class_name: :AnswerChoice

  belongs_to :respondent,
    primary_key: :id,
    foreign_key: :respondent_id,
    class_name: :User

  has_one :question,
    through: :answer_choice,
    source: :question

  validate :respondent_not_a_poll_author, unless: -> { answer_choice.nil? }
  validate :not_a_duplicate_response, unless: -> { answer_choice.nil? }

  def sibling_responses
    self.question.responses.where.not(id: self.id)
  end

  def respondent_already_answered?
    sibling_responses.exists?(respondent_id: self.respondent_id)
  end

  def not_a_duplicate_response
    errors[:respondent_id] << 'Cannot vote twice' if respondent_already_answered?
  end

  def respondent_not_a_poll_author
    poll_author_id = Poll
      .joins(questions: :answer_choices)
      .where('answer_choices.id = ?', self.answer_choice_id)
      .pluck('polls.author_id')
      .first

    return unless poll_author_id == self.respondent_id

    errors[:respondent_id] << 'Cannot respond if poll author.'
  end
end
