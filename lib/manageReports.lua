--script inform table to gest all de satdout in program
local manageReports = {
	isPrimeMsg = {[true] = "El numero [num] es primo", [false] = "El numero [num] no es primo"},
	divisorMsg = ", Es divisible por: ",
	errorInvalid = " Debe ingresar un numero mayor que 1!"
}

function manageReports:new()
	local m = {}
	self.__index = self
	return setmetatable(m,self)
end

function manageReports:isPrime(prime, number, divisors)

	if number >= 2 then

		resp = string.gsub(self.isPrimeMsg[prime],"%[num%]",tostring(number))
		
		--divisors is not a required param
		if divisors then resp = resp..self.divisorMsg..self:divisoresToStr(divisors) end
	else

		resp = self.errorInvalid --posible need error handler
	
	end

	print(resp)

	return resp --por las dudas

end
--function to convert array of divisors to string separated by ","
function manageReports:divisoresToStr(divisores)

	--for some methods i use only one divisor to stop de loop
	if type(divisores) == "number" then
		return divisores
	end
	resp = ""

	for i=1, #divisores do
		resp = resp .. divisores[i]
		if i < #divisores then
			resp = resp ..", "
		end
	end
	return resp
end
function manageReports:inform (message)
	print(message)
	return message
end
function manageReports:error (message)
	error(message)
	return message
end


return manageReports