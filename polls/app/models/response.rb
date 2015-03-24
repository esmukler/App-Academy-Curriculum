class Response < ActiveRecord::Base
  validates :respondent_id, presence: true
  validates :answer_choice_id, presence: true

  validate  :respondent_has_already_answered_question
  validate  :author_cant_respond_to_own_poll

  belongs_to(
    :answer_choice,
    class_name: "AnswerChoice",
    foreign_key: :answer_choice_id,
    primary_key: :id
  )

  belongs_to(
    :respondent,
    class_name: "User",
    foreign_key: :respondent_id,
    primary_key: :id
  )

  has_one(
    :question,
    through: :answer_choice,
    source:  :question
  )

  has_one(
    :poll,
    through: :question,
    source:  :poll
  )

  def improved_sibling_responses
     a = Response.select("responses.*")
          .joins("JOIN answer_choices AS all_acs ON responses.answer_choice_id = all_acs.id")
          .joins("JOIN questions ON questions.id = all_acs.question_id")
          .joins("JOIN answer_choices AS our_ac ON our_ac.question_id = questions.id")
          .where("our_ac.id = :ac_id AND (:id IS NULL OR responses.id != :id)", ac_id: self.answer_choice_id, id: self.id)
  end

  def sibling_responses
    siblings = question.responses
    self.id.nil? ? siblings : siblings.where("responses.id != ?", self.id)
  end

  private

  def respondent_has_already_answered_question
    if sibling_responses.exists?(respondent_id: respondent_id)
      errors[:respondent_id] << "already answered this question."
    end
  end

  def parent_poll
    question.poll
  end

  def does_not_respond_to_own_poll

  end

  def author_cant_respond_to_own_poll
    if parent_poll.author_id == respondent_id
      errors[:respondent_id] << "can't respond to their own poll."
    end
  end

end
