
CommandLine = {
	--Usage
	usage_str = [[
	Usage:
		isprime "number"
	Example: isprime 10123

	Parameters:
		-s [number]: simple test, only check if the number is prime or not and show the first divisor. (setting by default)
		-e [number]: exaustive test, check all the divisors
		-t [number]  [minnumber](optional): development features to get serie of nonmultiples values 
		-g [col] [maxnumber]: for graph primes 
		-ge [col] [maxnumber]: for graph primes with spaces
		-f [num]: test con factorial de impares mayores que 1
	]]
	
}
function CommandLine:new()
	local m = {}

	self.__index = self

	return setmetatable(m,self)
end
-- Initialize funtion 
function CommandLine:init(arg)
	
	local PrimeTest = dofile("lib/primeTest.lua")

	prit = PrimeTest:new()

	local isprime,msg = false,"Init message"
	
	if(arg[1]=='-e')then
		isprime,msg = prit:Test(tonumber(arg[2]))
	elseif arg[1] == '-s' then
		isprime,msg = prit:SimpleTest(tonumber(arg[2]))
	elseif arg[1] == '-t' then
		msg = prit:serialTest(tonumber(arg[2]),tonumber(arg[3]))
	elseif arg[1] == '-g' then
		msg = prit:GraphPrimes(arg[2],arg[3])
	elseif arg[1] == '-ge' then
		self.graphSpaces = true	
		msg = prit:GraphPrimes(arg[2],arg[3])
	elseif arg[1] == "-f" then
		isprime,msg = prit:Test(tonumber(arg[2]),self.FactorialTest)

	else
		isprime,msg = prit:SimpleTest(tonumber(arg[1]))

	end

	
end
function CommandLine:check(arg)
	--control para comando
	if not arg[1] or ((arg[1] == '-e' or arg[1] == '-s') and not arg[2]) or (arg[1] == '-g' and (not arg[2] or not arg[3]))then
		print(self.usage_str)
		os.exit(0)
	end
	
end

-- Initialize PrimeTest
tstart = os.time()

c = CommandLine:new()

c:check(arg)

c:init(arg)

tend = os.time()

executionTime = os.difftime(tend,tstart)

print("El programa tardo ".. executionTime.."s en realizar la operacion!")