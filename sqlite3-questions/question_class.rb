require_relative 'save'

class Question
include Save

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
