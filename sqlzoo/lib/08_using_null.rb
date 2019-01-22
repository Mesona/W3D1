# == Schema Information
#
# Table name: teachers
#
#  id          :integer      not null, primary key
#  dept_id     :integer
#  name        :string
#  phone       :integer
#  mobile      :string
#
# Table name: depts
#
#  id          :integer      not null, primary key
#  name        :string       not null

require_relative './sqlzoo.rb'

def null_dept
  # List the teachers who have NULL for their department.
  execute(<<-SQL)
    SELECT
      teachers.name 
    FROM
      teachers
    WHERE
      dept_id IS NULL

  SQL
end

def all_teachers_join
  # Use a type of JOIN that will list all teachers and their department,
  # even if the department in NULL/nil.
  execute(<<-SQL)
    SELECT
      teachers.name, depts.name
    FROM
      teachers
    LEFT JOIN depts on teachers.dept_id = depts.id
  SQL
end

def all_depts_join
  # Use a different JOIN so that all departments are listed.
  # NB: you can avoid RIGHT OUTER JOIN (and just use LEFT) by swapping
  # the FROM and JOIN tables.
  execute(<<-SQL)
    SELECT
      teachers.name, depts.name
    FROM
      depts
    LEFT JOIN teachers on depts.id = teachers.dept_id
  SQL
end

def teachers_and_mobiles
  # Use COALESCE to print the mobile number. Use the number '07986
  # 444 2266' if no number is given. Show teacher name and mobile
  # #number or '07986 444 2266'
  execute(<<-SQL)
    SELECT
      teachers.name, COALESCE(mobile, '07986 444 2266')
    FROM
      teachers
  SQL
end

def teachers_and_depts
  # Use the COALESCE function and a LEFT JOIN to print the teacher name and
  # department name. Use the string 'None' where there is no
  # department.
  execute(<<-SQL)
    SELECT
      teachers.name, COALESCE(depts.name, 'None')
    FROM
      teachers
    LEFT JOIN depts on depts.id = teachers.dept_id
    
  SQL
end

def num_teachers_and_mobiles
  # Use COUNT to show the number of teachers and the number of
  # mobile phones.
  # NB: COUNT only counts non-NULL values.
  execute(<<-SQL)
    SELECT
      COUNT(teachers), COUNT(mobile)
    FROM
      teachers
  SQL
end

def dept_staff_counts
  # Use COUNT and GROUP BY dept.name to show each department and
  # the number of staff. Structure your JOIN to ensure that the
  # Engineering department is listed.
  execute(<<-SQL)
    SELECT
      depts.name, COUNT(dept_id)
    FROM
      depts
    LEFT JOIN teachers on teachers.dept_id = depts.id
    GROUP BY
      depts.name
  SQL
end

def teachers_and_divisions
  # Use CASE to show the name of each teacher followed by 'Sci' if
  # the the teacher is in dept 1 or 2 and 'Art' otherwise.
  execute(<<-SQL)
    SELECT
      teachers.name, CASE (dept_id)
        WHEN 1 then 'Sci'
        WHEN 2 then 'Sci'
        ELSE
          'Art'
        END
    FROM
      teachers
  SQL
end

def teachers_and_divisions_two
  # Use CASE to show the name of each teacher followed by 'Sci' if
  # the teacher is in dept 1 or 2, 'Art' if the dept is 3, and
  # 'None' otherwise.
  execute(<<-SQL)
    SELECT
      teachers.name, CASE (dept_id)
        WHEN 1 then 'Sci'
        WHEN 2 then 'Sci'
        WHEN 3 then 'Art'
        ELSE
          'None'
        END
    FROM
      teachers

  SQL
end
