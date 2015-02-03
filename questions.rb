require 'singleton'
require 'sqlite3'

class QuestionsDatabase < SQLite3::Database
  include Singleton

  def initialize
    super(questions.db)
    self.results_as_hash = true
    self.type_translation = true
  end
end

class User

  def self.find_by_id(find_id)
    new_user = execute (<<-SQL, find_id)

    SELECT
      *
    FROM
      users
    WHERE
      id = ?

      SQL
      User.new(new_user)
  end

  def self.find_by_name(find_fname, find_lname)
    new_user = execute(<<-SQL, find_fname, find_lname)

    SELECT
      *
    FROM
      users
    WHERE
      fname = ? AND lname = ?

    SQL
    User.new(new_user)
  end

  attr_accessor :id, :fname, :lname
  def initialize( user_options = {})
    @id = user_options['id']
    @fname = user_option['fname']
    @lname = user_option['lname']
  end

  def authored_questions
    Question.find_by_author_id(@id)
  end

  def authored_replies
    Reply.find_by_user_id(@id)
  end
end



class Question

  def self.find_by_id(find_id)
    new_question = execute (<<-SQL, find_id)

    SELECT
      *
    FROM
      questions
    WHERE
      id = ?

      SQL
      Question.new(new_question)
  end

  def self.find_by_author_id(find_author)
    new_questions = execute(<<-SQL, find_author)

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

  attr_accessor :id, :title, :body, :author_id
  def initialize( question_options = {})
    @id = question_options['id']
    @title = question_options['title']
    @body = question_options['body']
    @author_id = question_options['author_id']
  end

  def author
    author_name = execute(<<-SQL, @author_id)

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

end




class Reply
  def self.find_by_id(find_id)
    new_reply = execute (<<-SQL, find_id)

    SELECT
      *
    FROM
      replies
    WHERE
      id = ?

      SQL
      Reply.new(new_reply)
  end

  def self.find_by_question_id(question_id)
    new_replies = execute(<<-SQL, question_id)

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
    new_replies = execute(<<-SQL, user_id)

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
    author_name = execute(<<-SQL, @replier_id)

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
    question = execute(<<-SQL, @question)

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
    parent = execute(<<-SQL, @parent_reply)

    SELECT
      body
    FROM
      replies
    WHERE
      id = ?
    SQL
  end

  def child_replies
    children = execute(<<-SQL, @id)

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

  def initialize

end
