class User < ActiveRecord::Base

  validates :user_name, presence: true,  uniqueness: true

  has_many(
    :authored_polls,
    class_name: "Poll",
    foreign_key: :author_id,
    primary_key: :id
  )

  has_many(
    :responses,
    class_name: "Response",
    foreign_key: :respondent_id,
    primary_key: :id
  )

  def completed_polls
    polls
  end

  def incomplete_polls
    polls(false)
  end

  private

  def polls(completed = true)
    operator = completed ? "=" : "!="
    Poll.select([
                  "polls.*",
                  "COUNT(questions.*) AS question_count",
                  "COUNT(user_responses.*) AS response_count"
                  ])
        .joins(:questions)
        .joins("LEFT JOIN
                  (
                    SELECT
                      answer_choices.*
                    FROM
                      answer_choices
                    JOIN
                      responses
                    ON
                      responses.answer_choice_id = answer_choices.id
                    WHERE
                      responses.respondent_id = #{self.id}
                  ) AS user_responses
                ON
                  user_responses.question_id = questions.id")
        .group("polls.id")
        .having("COUNT(questions.*) #{operator} COUNT(user_responses.*)")
        .order("polls.id")
  end

end
