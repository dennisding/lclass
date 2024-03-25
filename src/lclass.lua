
local function print_table(t)
    print("print table", t)
    for key, value in pairs(t) do
        print(key, value)
    end
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
    print("name:", self.name, "say hello")
end

local new_person = Person("dennis", 43)

print_table(new_person)

new_person:say_hello()

print('new person', new_person)

print('hello x')