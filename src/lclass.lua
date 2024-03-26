
local function print_table(t)
    print("print table", t)
    for key, value in pairs(t) do
        print(key, value)
    end
end

function _super(type, instance)
    local wraper = {}

    local function _index(t, key)
        local super_method = nil
        while type._super ~= nil do
            super_method = type._super[key]
            if super_method ~= nil then
                break
            end
        end
        local function _method(...)
            if super_method ~= nil then
                return super_method(instance, ...)
            end
        end

        return _method
    end

    local meta = {__index = _index }
    setmetatable(wraper, meta)

    return wraper
end

function _class(name, super)
    local _new_class = {_type_name = name, _super = super}
    _new_class.__index = _new_class

    local function _call(type, ...)
            local instance = {}
            setmetatable(instance, _new_class)

            local _init = _new_class._init
            if _init ~= nil then
                _init(instance, ...)
            end

            return instance
    end

    setmetatable(_new_class, {__call = _call})

    return _new_class
end

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

-- print_table(new_person)

new_person:say_hello()

print('new person', new_person)
