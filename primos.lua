--Usage
usage_str = [[
Usage:
	isprime "number"
Example: isprime 10123

Parameters:
	-s: simple test, only check if the number is prime or not and show the first divisor. (setting by default)
	-e: exaustive test, check all the divisors
	-t: development features 
]]

-- Define the class PrimeTest
PrimeTest = {}

function PrimeTest:new()
	local m = {}
	self.__index = self
	return setmetatable(m,self)
end

-- Simple Test
function PrimeTest:SimpleTest(number)
	if number < 2 then
		return "Debe ingresar un numeor mayor que uno"
	elseif number == 2 then
		return "El numero es primo"
	else
		primo = true
		divisor = 1
		for i=2,number/2 do
			if number%i == 0 then
				primo = false
				divisor =i
				break
			end
		end
		if primo then
			return "El numero "..number.." es primo"
		else
			return "El numero "..number.." NO ES PRIMO, es divisible por "..divisor		
		end
	end
end
-- Exaustive Test
function PrimeTest:Test(number)
	if number < 2 then
		return "Debe ingresar un numeor mayor que uno"
	elseif number == 2 then
		return "El numero es primo"
	else
		return self:inteligentLoop(number)
	end
end

-- InteligentLoop - 

function PrimeTest:inteligentLoop(numero)
	limite = math.ceil(numero/2)
	i=1
	divi = 3;
	divisors = {}
	primo = true
	
	repeat
		if numero%divi == 0 then
			primo = false
			divisors[#divisors+1] = divi
			divisors[#divisors+1] = numero/divi
		end
		limite = math.ceil(numero/i)
		divi = self:serieIncremento(i)
		
		i=i+1
	until  divi > limite

	if primo then
		return "El numero "..numero.." es primo"
	else
		return "El numero "..numero.." NO ES PRIMO, es divisible por "..self:divisoresToStr(divisors).." cantidad:"..#divisors		
	end
end
-- funcion simple para evitar los multiplos de 2 y de 3, de esta menera mejora el rendimiento del algoritmo
function PrimeTest:serieIncremento(i)
	
	indice = math.ceil(i/2) 
	-- indice*2-1 --debo usar esto para mejorar la selecion
	
	if(i%2 == 0)then
		return indice*6+1
	else
		return 6*indice-1
	end
end


--FUNCIONA PERO AHORA DEBO CONSTRUIR UNA QUE ME PERMITA CONCATENAR LAS IDEAS Y OBTENER NUMEROS Q NO SEAN MULTIPLOS DE MAS DE UN NUMERO
--la idea de esta funcion es obtener una serie generica para conseguir los no multiplos de un numero
--como la que esta arriba para el 3 pero sin la correccion para los pares, despue hare otro con correcciones
--peor primero necesito la q no tiene correcciones para avanzar conceptualmente.
function PrimeTest:getInmultiple(i,number)
	
	dispercion = math.floor(number/2)
	
	cantidad = dispercion*2
	
	indice = math.ceil(i/cantidad)

	final_num = number*indice + self:getSum(i,dispercion)
	
	return "i: "..i.." --> num: "..final_num 
	
end
--FUNCION PARA TRAER LA SUMA ASOCIADA A LA SERIE DE GETINMULTIPLE
--ejemplo: d= 2 f(1)=-2 f(2)=-1 f(3)=1 f(4)=2 f(5)= -2 f(6)=-1
function PrimeTest:getSum(n,disp)
	
	cant = disp *2
	
	resp = (n-1) % cant

	resu = resp -disp 

	if resu>= 0 then resu = resu+1 end

	return resu
end
--TESTING:
--FUNCION DE TESTIN DE LAS NUEVAS FUNCIONES
function PrimeTest:serialTest(number)
	if not number then number = 2 end
	for i = 1, 100 do
		print(self:getInmultiple(i,number))
	end
	return "End of testing serie for numer: "..number
end




--FUNCIONES DE TEXTO PARA AVISOS
function PrimeTest:divisoresToStr(divisores)
	resp = ""
	for i=1, #divisores do
		resp = resp .. divisores[i]
		if i < #divisores then
			resp = resp ..", "
		end
	end
	return resp
end

-- Initialize funtion 
function PrimeTest:init(arg)
	local result = "Init message"
	
	if(arg[1]=='-e')then
		result = self:Test(tonumber(arg[2]))
	elseif arg[1] == '-s' then
		result = self:SimpleTest(tonumber(arg[2]))
	elseif arg[1] == '-t' then
		result = self:serialTest(tonumber(arg[2]))
	else
		if(arg[1] == '-s')then arg[1] = arg[2] end

		result = self:SimpleTest(tonumber(arg[1]))
	end

	print(result);

end

if not arg[1] or ((arg[1] == '-e' or arg[1] == '-s') and not arg[2]) then
	print(usage_str)
	os.exit(0)
end

-- Initialize PrimeTest

p = PrimeTest:new()

p:init(arg)
