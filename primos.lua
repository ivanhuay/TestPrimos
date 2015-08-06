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
]]

-- Define the class PrimeTest
PrimeTest = {fullTest=true, graphSpaces=false}

function PrimeTest:new()
	local m = {}
	self.__index = self
	return setmetatable(m,self)
end

-- Simple Test
function PrimeTest:SimpleTest(number)
	if number < 2 then
		return false,"Debe ingresar un numeor mayor que uno"
	elseif number == 2 then
		return true,"El numero es primo"
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
			return primo,"El numero "..number.." es primo"
		else
			return primo,"El numero "..number.." NO ES PRIMO, es divisible por "..divisor		
		end
	end
end
-- Exaustive Test
function PrimeTest:Test(number)
	if number < 2 then
		return false,"Debe ingresar un numeor mayor que uno"
	elseif number == 2 then
		return true,"El numero es primo"
	else
		return self:inteligentLoop(number)
	end
end

-- InteligentLoop - 

function PrimeTest:inteligentLoop(numero)
	limite = math.ceil(numero/2)
	i=1
	divi = 2;
	divisors = {}
	primo = true
	
	while divi <= limite do
		if numero%divi == 0 and divi ~= numero then
			primo = false
			divisors[#divisors+1] = divi
			divisors[#divisors+1] = numero/divi
			if self.fullTest == false then
			 break 
			end
		end
		limite = math.ceil(numero/i)
		divi = self:serieIncremento(i)
		
		i=i+1
	end

	if primo then
		return primo, "El numero "..numero.." es primo"
	else
		return primo, "El numero "..numero.." NO ES PRIMO, es divisible por "..self:divisoresToStr(divisors).." cantidad:"..#divisors		
	end
end
-- funcion simple para evitar los multiplos de 2 y de 3, de esta menera mejora el rendimiento del algoritmo
function PrimeTest:serieIncremento(i)
	--[[
		i = i-1
		if i == 0 then
			return 2 --little patch to solve 2 multiples
		end

	]]
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
function PrimeTest:getInmultiple(i,number,minnumber)
	
	dispercion = math.floor(number/2)
	
	cantidad = dispercion*2
	
	indice = math.ceil(i/cantidad)

	-- este arreglo puede facilitar la comparacion de elementos para resolver alguanas ecucaciones
	-- [1]g3(x1)-g2(x2) = 0 con un minimo en [2]a = x1+x2 es la solucion para el proximo numero primo
	-- esta solucion segun estoy viendo ahora no funcionaria para n-simos valores, para cada primo mas se necesita otro para de ecuacion [1] y [2]
	if minnumber then
		
		aprox = math.floor(minnumber/number)--lo que deberia valer el indice
		
		indice = indice + aprox -- una aproximacion temporal para elevar el indice y mantener la misma dispercion

		i = i + aprox*cantidad	-- sospecho que esta correccion puede servir para ajustar el i y que no tenga errores

	end	
	

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
function PrimeTest:serialTest(number,maxnumber)
	if not number then number = 2 end
	for i = 1, 100 do
		print(self:getInmultiple(i,number,maxnumber))
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
--Graph methos to understand Primes
function PrimeTest:GraphPrimes(col,maxnumber)
	self.fullTest = false
	
	for i = 1, maxnumber do
		prime,msg = self:Test(i)
		--print(msg)
		if(prime) then
			io.write("o")
		else
			if self.graphSpaces == true then
				io.write(" ")
			else
				io.write("-")
			end
				
		end
		if i % col == 0 then io.write("\n") end
	end
	
	io.write("\n")

	return "Grafico de testing finalizado, n° de columnas "..col.." y maxnumber: "..maxnumber
end


-- Initialize funtion 
function PrimeTest:init(arg)
	local isprime,msg = false,"Init message"
	
	if(arg[1]=='-e')then
		isprime,msg = self:Test(tonumber(arg[2]))
	elseif arg[1] == '-s' then
		isprime,msg = self:SimpleTest(tonumber(arg[2]))
	elseif arg[1] == '-t' then
		msg = self:serialTest(tonumber(arg[2]),tonumber(arg[3]))
	elseif arg[1] == '-g' then
		msg = self:GraphPrimes(arg[2],arg[3])
	elseif arg[1] == '-ge' then
		self.graphSpaces = true	
		msg = self:GraphPrimes(arg[2],arg[3])
	else

		isprime,msg = self:SimpleTest(tonumber(arg[1]))
	end

	print(msg);

end

--control para comando
if not arg[1] or ((arg[1] == '-e' or arg[1] == '-s') and not arg[2]) or (arg[1] == '-g' and (not arg[2] or not arg[3]))then
	print(usage_str)
	os.exit(0)
end

-- Initialize PrimeTest

p = PrimeTest:new()

p:init(arg)
