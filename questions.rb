require 'singleton'
require 'sqlite3'

class QuestionsDatabase < SQLite3::Database
  include Singleton

  def initialize
    super('questions.db')
    self.results_as_hash = true
    self.type_translation = true
  end
end

class User

  def self.find_by_id(find_id)
    new_user = QuestionsDatabase.instance.execute(<<-SQL, find_id)

    SELECT
      *
    FROM
      users
    WHERE
      id = ?

      SQL
      User.new(new_user[0])
  end

  def self.find_by_name(find_fname, find_lname)
    new_user = QuestionsDatabase.instance.execute(<<-SQL, find_fname, find_lname)

    SELECT
      *
    FROM
      users
    WHERE
      fname = ? AND lname = ?

    SQL
    User.new(new_user[0])
  end

  attr_accessor :id, :fname, :lname
  def initialize( user_options = {})
    @id = user_options['id']
    @fname = user_options['fname']
    @lname = user_options['lname']
  end

  def authored_questions
    Question.find_by_author_id(@id)
  end

  def authored_replies
    Reply.find_by_user_id(@id)
  end

  def followed_questions
    QuestionFollower.followed_questions_for_user_id(@id)
  end

  def liked_questions
    QuestionLike.liked_questions_for_user_id(@id)
  end

  def average_karma
    #CAST(sum(l.liker_id) AS FLOAT)/CAST(count(q.id) AS FLOAT)
    karma = QuestionsDatabase.instance.execute(<<-SQL, @id)


    SELECT
    CAST(count(l.liker_id) AS FLOAT) / count(distinct(q.id))
    FROM
      questions q
    LEFT OUTER JOIN
      question_likes l ON q.id = l.question_id
    WHERE
      q.author_id = ?


      SQL

      karma[0].values[0]
    end
end



class Question

  def self.find_by_id(find_id)
    new_question = QuestionsDatabase.instance.execute(<<-SQL, find_id)

    SELECT
      *
    FROM
      questions
    WHERE
      id = ?

      SQL
      p new_question
      Question.new(new_question[0])
  end

  def self.find_by_author_id(find_author)
    new_questions = QuestionsDatabase.instance.execute(<<-SQL, find_author)

    SELECT
      *
    FROM
      questions
    WHERE
      author_id = ?
    SQL
    output = []
    new_questions.each do |question|
      output << Question.new(question)
    end
    output
  end

  def self.most_followed(n)
    QuestionFollower.most_followed_questions(n)
  end

  def self.most_liked(n)
    QuestionLike.most_liked_questions(n)
  end

  attr_accessor :id, :title, :body, :author_id
  def initialize( question_options = {})
    @id = question_options['id']
    @title = question_options['title']
    @body = question_options['body']
    @author_id = question_options['author_id']
  end

  def author
    author_name = QuestionsDatabase.instance.execute(<<-SQL, @author_id)

    SELECT
      fname, lname
    FROM
      users
    WHERE
      id = ?
    SQL
    author_name.join(" ")
  end

  def replies
    Reply.find_by_question_id(@id)
  end

  def followers
    QuestionFollower.followers_for_question_id(@id)
  end

  def likers
    QuestionLike.likers_for_question_id(@id)
  end

  def num_likes
    QuestionLike.num_likes_for_question_id(@id)
  end

end




class Reply
  def self.find_by_id(find_id)
    new_reply = QuestionsDatabase.instance.execute(<<-SQL, find_id)

    SELECT
      *
    FROM
      replies
    WHERE
      id = ?

      SQL
      Reply.new(new_reply[0])
  end

  def self.find_by_question_id(question_id)
    new_replies = QuestionsDatabase.instance.execute(<<-SQL, question_id)

    SELECT
      *
    FROM
      replies
    WHERE
      question = ?
    SQL
    output = []
    new_replies.each do |reply|
      output << Reply.new(reply)
    end
    output
  end

  def self.find_by_user_id(user_id)
    new_replies = QuestionsDatabase.instance.execute(<<-SQL, user_id)

    SELECT
      *
    FROM
      replies
    WHERE
      replier_id = ?
    SQL
    output = []
    new_replies.each do |reply|
      output << Reply.new(reply)
    end
    output
  end

  attr_accessor :question, :body, :id, :parent_reply, :replier_id
  def initialize(reply_options = {})

    @question = reply_options['question']
    @body = reply_options['body']
    @id = reply_options['id']
    @parent_reply = reply_options['parent_reply']
    @replier_id = reply_options['replier_id']

  end


  def author
    author_name = QuestionsDatabase.instance.execute(<<-SQL, @replier_id)

    SELECT
      fname, lname
    FROM
      users
    WHERE
      id = ?
    SQL
    author_name.join(" ")
  end

  def question
    question = QuestionsDatabase.instance.execute(<<-SQL, @question)

    SELECT
      title, body
    FROM
      questions
    WHERE
      id = ?
    SQL
    question.join(" ")
  end

  def parent_reply
    parent = QuestionsDatabase.instance.execute(<<-SQL, @parent_reply)

    SELECT
      body
    FROM
      replies
    WHERE
      id = ?
    SQL
  end

  def child_replies
    children = QuestionsDatabase.instance.execute(<<-SQL, @id)

    SELECT
      body
    FROM
      replies
    WHERE
      parent_reply = ?
    SQL
  end
end




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

c = QuestionLike.num_likes_for_question_id(1)
print c
