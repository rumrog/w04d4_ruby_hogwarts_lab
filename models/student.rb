require('PG')

class Student
    attr_reader :id
    attr_accessor :first_name, :second_name, :house, :age

    def initialize(options)
        @id = options['id'].to_i if options['id']
        @first_name = options['first_name']
        @second_name = options['second_name']
        @house = options['house']
        @age = options['age'].to_i
    end

    def save()
        sql = "INSERT INTO hogwarts
        (
            first_name,
            second_name
            house,
            age
        )
        VALUES
        (
            $1, $2, $3, $4
        )
        RETURNING *"
        values = [@first_name, @second_name, @house, @age]
        student_data = SqlRunner.run(sql, values)
        @id = student_data.first()['id'].to_i
    end

    def delete()
        sql = "DELETE FROM hogwarts
        WHERE id = $1"
        values = [@id]
        SqlRunner.run( sql, values )
    end

    def self.all()
        sql = "SELECT * FROM hogwarts"
        students = SqlRunner.run( sql )
        result = students.map { |student| Student.new( student )}
        return result  
    end

    def self.find(id)
        sql = "SELECT * FROM hogwarts
        WHERE id = $1"
        values = [id]
        student = SqlRunner.run( sql, values )
        resut = Student.new( student.first )
        return result
    end

end

