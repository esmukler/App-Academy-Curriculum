require_relative 'save'

class Reply
include Save

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

    @id = reply_options['id']
    @question = reply_options['question']
    @body = reply_options['body']
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
