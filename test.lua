
a = {}
function a:new()
	local m = {}
	self.__index = self
	return setmetatable(m,self)
end
function a:Test(number)
	return number
end

function execF(fun)
	print(fun)

	return fun(1,2,3,4)
end

