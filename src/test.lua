

require("lclass")

-- useage
local Person = _class("Person")

function Person:_init(name, age)
    self.name = name
    self.age = age
    print("person init", self, name, age)
end

function Person:say_hello()
    print("Person:", self.name, "say hello")
end

local Student = _class("Student", Person)

function Student:_init(name, age, grade)
    _super(Student, self)._init(name, age)

    self.grade = grade
    print('student init')
end

function Student:say_hello()
    _super(Student, self).say_hello()
    print('student say hello')
end

local new_person = Student("dennis", 43, 3)

new_person:say_hello()

print('new person', new_person)