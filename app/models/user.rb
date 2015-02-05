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

    Poll.find_by_sql(<<-SQL)
      SELECT DISTINCT
        polls.*,
        COUNT(questions.*) AS question_count,
        COUNT(user_responses.*) AS response_count
      FROM
        polls
      JOIN
        questions
      ON
        polls.id = questions.poll_id
      LEFT OUTER JOIN
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
          responses.respondent_id = 3
      ) user_responses
      ON
        user_responses.question_id = questions.id
      GROUP BY
        polls.id
      HAVING
        COUNT(questions.*) = COUNT(user_responses.*)
      ORDER BY
        polls.id
    SQL


  end

end
