package.path = '../src/?.lua;' .. package.path

local est = require 'estrela'

est.scan '../src/modules'


local oop = est.require 'oop'

local Example = oop.class 'Example'

function Example:__init(value)
	self.value = value
end
