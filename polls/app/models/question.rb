class Question < ActiveRecord::Base

  validates :poll_id, presence: true
  validates :question_text, presence: true

  has_many(
    :answer_choices,
    class_name: "AnswerChoice",
    foreign_key: :question_id,
    primary_key: :id
  )

  belongs_to(
    :poll,
    class_name: "Poll",
    foreign_key: :poll_id,
    primary_key: :id
  )

  has_many(
    :responses,
    through: :answer_choices,
    source:  :responses
  )

  def results
    results = {}

    answer_counts = self.answer_choices
        .select(['answer_choices.*', "COUNT(responses.*) AS response_count"])
        .joins("LEFT JOIN responses ON answer_choices.id = responses.answer_choice_id")
        .where(['answer_choices.question_id = :id', id: self.id])
        .group('answer_choices.id')

    answer_counts.each do |answer_count|
      results[answer_count.answer_text] = answer_count.response_count
    end

    results
  end

  def results_includes
    results = {}

    answer_choices.includes(:responses).each do |answer_choice|
      results[answer_choice.answer_text] = answer_choice.responses.count
    end

    results
  end

  def results_n_plus_one
    results = {}

    answer_choices.each do |answer_choice|
      results[answer_choice.answer_text] = answer_choice.responses.count
    end

    results
  end

end
