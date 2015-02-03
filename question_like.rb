
class QuestionLike

  def self.likers_for_question_id(question_id)
    new_users = QuestionsDatabase.instance.execute(<<-SQL, question_id)

    SELECT DISTINCT
      users.id, users.fname, users.lname
    FROM
      question_likes
    JOIN
      users ON users.id = question_likes.liker_id
    WHERE
      question_likes.question_id = ?
    SQL
    output = []
    new_users.each do |user|
      output << User.new(user)
    end
    output
  end

  def self.num_likes_for_question_id(find_question_id)
    count = QuestionsDatabase.instance.execute(<<-SQL, find_question_id)

    SELECT
      COUNT(liker_id)
    FROM
      question_likes
    WHERE
      question_id = ?
    GROUP BY
      question_id
    SQL
    return count[0]['COUNT(liker_id)'] unless count[0].nil?
    0
  end

  def self.liked_questions_for_user_id(find_user_id)
    new_questions = QuestionsDatabase.instance.execute(<<-SQL, find_user_id)

    SELECT DISTINCT
      questions.id, questions.title, questions.body, questions.author_id
    FROM
      question_likes
    JOIN
      questions ON questions.id = question_likes.question_id
    WHERE
      question_likes.liker_id = ?
    SQL
    output = []
    new_questions.each do |question|
      output << Question.new(question)
    end
    output
  end

  def self.most_liked_questions(n)
    questions = QuestionsDatabase.instance.execute(<<-SQL, n)

    SELECT
      questions.id, questions.title, questions.body, questions.author_id
    FROM
      question_likes
    JOIN
      questions ON questions.id = question_likes.question_id
    GROUP BY
      question_likes.question_id
    ORDER BY
      count(question_likes.liker_id) DESC
    LIMIT
      ?

    SQL
    output = []
    questions.each do |question|
      output << Question.new(question)
    end
    output

  end

  attr_accessor :question_id, :liker_id
  def initialize(like_options = {})
    @question_id = like_options['question_id']
    @liker_id = like_options['liker_id']
  end
end
