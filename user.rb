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

    def save
      if @id.nil?
        QuestionsDatabase.instance.execute(<<-SQL, @fname, @lname)
        INSERT INTO
          users (fname, lname)
        VALUES
          (?, ?)
        SQL

        @id = QuestionsDatabase.instance.last_insert_row_id
      else
        QuestionsDatabase.instance.execute(<<-SQL, @fname, @lname, @id)
        UPDATE
          users
        SET
          fname = ?,
          lname = ?
        WHERE
          id = ?
        SQL
      end
    end

end
