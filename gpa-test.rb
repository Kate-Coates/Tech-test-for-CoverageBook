class Calculator
  attr_reader :name, :grades

# create a hash that maps letter grades to GPA values. 
# calculate GPA - use the mapping to convert grades to GPA values and calculate the average.
# generate the ammouncement - create a string using the relevant GPA and person's name.


=begin
Creating a constant using uppercase letters and putting it within the calculator class means that it can be accessed outside 
of the gpa method if  required or it can be put in the the gpa method as a local variable using lowercase letters, i.e, grade_points.
=end
GRADE_POINTS = {
  "A" => 4.0, "A-" => 3.7, "B+" => 3.3, "B" => 3.0, "B-" => 2.7, "C+" => 2.3, "C" => 2.0, "C-" => 1.7, 
  "D+" => 1.3, "D" => 1.0, "D-" => 0.7, "E+" => 0.5, "E" => 0.2, "E-" => 0.1, "F" => 0, "U" => -1.0
}

  def initialize(name, grades)
    @name = name
    @grades = grades
  end

=begin 
how the gpa method works - 
{ |grade| GRADE_POINTS[grade] || 0} this is a block of code that is passed to the .map method it goes through each of the grades in the grades array 
relating to each person and finds it's numerical value using GRADE_POINTS[grade] and creates a new array which is stored under the variable 
total_points
Then the .sum method is used to add all the points in the total_points array together. 
This is then divided by grades.size which gives the number of items in the array and therefore the average point score 
Then the .round(1) method is used to round the average point score to one decimal place.
=end
  def gpa
    total_points = grades.map { |grade| GRADE_POINTS[grade] || 0}.sum
    (total_points / grades.size).round(1)
  end

  def announcement
    "#{name} scored an average of #{gpa}"
  end
end

## Do not edit below here ##################################################

tests = [
  { in: { name: 'Andy',  grades: ["A"] }, out: { gpa: 4, announcement: "Andy scored an average of 4.0"  } },
  { in: { name: 'Beryl',  grades: ["A", "B", "C"] }, out: { gpa: 3, announcement: "Beryl scored an average of 3.0"  } },
  { in: { name: 'Chris',  grades: ["B-", "C+"] }, out: { gpa: 2.5, announcement: "Chris scored an average of 2.5"  } },
  { in: { name: 'Dan',  grades: ["A", "A-", "B-"] }, out: { gpa: 3.5, announcement: "Dan scored an average of 3.5"  } },

  # the test still fails because there is a typo in the tests, Beryl's name is in the last 3 announcements.
  { in: { name: 'Emma',  grades: ["A", "B+", "F"] }, out: { gpa: 2.4, announcement: "Beryl scored an average of 2.4"  } },
  { in: { name: 'Frida',  grades: ["E", "E-"] }, out: { gpa: 0.2, announcement: "Beryl scored an average of 0.2"  } },
  { in: { name: 'Gary',  grades: ["U", "U", "B+"] }, out: { gpa: 0.4, announcement: "Beryl scored an average of 0.4"  } },
]

# extension_for_more_advanced_error_handling = [
#   { in: { name: 'Non-grades',  grades: ["N"] } },
#   { in: { name: 'Non-strings',  grades: ["A", :B] } },
#   { in: { name: 'Empty',  grades: [] } },
#   { in: { name: 'Numbers',  grades: [1, 2] } },
#   { in: { name: 'Passed a string',  grades: "A A-" } },
# ]

tests.each do |test|
  user = Calculator.new(test[:in][:name], test[:in][:grades])

  puts "#{'-' * 10} #{user.name} #{'-' * 10}"

  [:gpa, :announcement].each do |method|
    result = user.public_send(method)
    expected = test[:out][method]

    if result == expected
      puts "✅ #{method.to_s.upcase}: #{result}"
    else
      puts "❌ #{method.to_s.upcase}: expected '#{expected}' but got '#{result}'"
    end
  end

  puts
end
