class QuestionFollower

  def self.followers_for_question_id(question_id)
      users = QuestionsDatabase.instance.execute(<<-SQL, question_id)

      SELECT
        users.id, users.fname, users.lname
      FROM
        question_followers
      JOIN
        users ON users.id = question_followers.follower_id
      WHERE
        question_followers.question_id = ?
      SQL
      output = []
      users.each do |user|
        output << User.new(user)
      end
      output
  end

  def self.followed_questions_for_user_id(user_id)
      questions = QuestionsDatabase.instance.execute(<<-SQL, user_id)

      SELECT
        questions.id, questions.title, questions.body, questions.author_id
      FROM
        question_followers
      JOIN
        questions ON questions.id = question_followers.question_id
      WHERE
        question_followers.follower_id = ?
      SQL
      output = []
      questions.each do |question|
        output << Question.new(question)
      end
      output
  end

  def self.most_followed_questions(n)
    questions = QuestionsDatabase.instance.execute(<<-SQL, n)

    SELECT
      questions.id, questions.title, questions.body, questions.author_id
    FROM
      question_followers
    JOIN
      questions ON questions.id = question_followers.question_id
    GROUP BY
      question_followers.question_id
    ORDER BY
      count(question_followers.follower_id) DESC
    LIMIT
      ?

    SQL
    output = []
    questions.each do |question|
      output << Question.new(question)
    end
    output
  end


  attr_accessor :question_id, :follower_id
  def initialize(follower_options = {})
    @question_id = follower_options['question_id']
    @follower_id = follower_options['follower_id']
  end

end
