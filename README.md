# lclass
another lua class and module implement

# lclass example
```
require('lclass')

Person = _class('Person')

function Person:_init(name, age)
    self.name = name
    self.age = age
end

function Person:say_hello()
    print('say_hello in Person', self.name, self.age)
end

Student = _class('Student', Person)

function Student:_init(name, age, grade)
    _super(Student, self)._init(name, age)
    self.grade = grade
end

function Student:say_hello()
    _super(Student, self).say_hello()
    print('say_hello in Student', self.grade)
end
```
# lmodule excample
```
require('lmodule')

local gui = _import('gui')
gui.show_all()
```