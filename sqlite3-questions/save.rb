module Save

  def save
    table = self.class.to_s.downcase + 's'

    if table == "replys"
      table = 'replies'
    end

    vars = self.instance_variables
    new_vars = vars.map {|var| var.to_s.delete('@')}
    new_vars.shift

    value = []
    vars.each do |var|
      value << self.instance_variable_get(var)
    end

    if @id.nil?

      vstring = []
      value.shift

      new_vars.count.times do |x|
        vstring << '?'
      end
      new_vstring = vstring.join(', ')
      new_vars = new_vars.join(", ")


      QuestionsDatabase.instance.execute(<<-SQL, *value)
      INSERT INTO
        #{table} (#{new_vars})
      VALUES
        (#{new_vstring})
      SQL

      @id = QuestionsDatabase.instance.last_insert_row_id
    else
      value << value.shift

      set_string = new_vars.join(' = ?, ')
      QuestionsDatabase.instance.execute(<<-SQL, *value)
      UPDATE
        #{table}
      SET
        #{set_string}
      WHERE
        id = ?
      SQL
    end
  end

end
