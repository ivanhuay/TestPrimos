-- Define the class PrimeTest

local PrimeTest = {fullTest=true, graphSpaces=false}

function PrimeTest:new()
	local m = {}
	
	local reports = dofile("./lib/manageReports.lua")

	self.__index = self

	self.reports = reports:new()

	return setmetatable(m,self)
end

-- Simple Test
function PrimeTest:SimpleTest(number)
	if number < 2 then
		primo =  false
	elseif number == 2 then
		
		return true

	else
		primo = true
		
		for i=2,number/2 do
			if number%i == 0 then
				primo = false
				divisor = i
				break
			end
		end
	end
		
	return self.reports:isPrime(primo,number,divisor)
end
-- Exaustive Test, ahora puedo pasarle la funcion que quiero que use para loop
function PrimeTest:Test(number,loopFunction)

	if number < 2 then
		primo =  false
	elseif number == 2 then
		primo = true
	else
		if not loopFunction then
			primo, divisors = self:inteligentLoop(number)
		else
			primo,divisors =  loopFunction(number,number)
		end
	end
	return self.reports:isPrime(primo,number,divisors)
end

-- InteligentLoop -- a inteligent loop only one loop, the loop select supose to be insite Test function

function PrimeTest:inteligentLoop(numero)
	limite = math.ceil(numero/2)
	
	i=1

	if(numero % 2 == 0)then return false,2 end
	-->if(numero % 3 == 0)then return false,3 end--supongo que tiene sentido que esto este comentado porq quiero justamente que el analisis sea detallado

	divi = 3;
	
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
		return primo
	else
		return primo,divisors		
	end
end

-- funcion simple para evitar los multiplos de 2 y de 3, de esta menera mejora el rendimiento del algoritmo
function PrimeTest:serieIncremento(i)
	
	indice = math.ceil(i/2) 
	
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

--funcion de testin para probar con la funcion que me dijo tomeo
function PrimeTest:FactorialTest(number)

	if number % 2 == 0 then

		primo = false

		msg = "The number "..number.. " is not prime, is divisible by 2"

		return primo
	
	end

	fact = 1
	
	primo = true
	
	sqrt = math.sqrt(number)
	
	if(math.ceil(sqrt) == sqrl)then return false,"The number "..number.." is a square!" end
	factText = ""
	
	for i = 3, number-2, 2 do
		factText = factText.." * "..i
		fact = fact*i
	end
	
	if fact % number == 0 or number == 2 then
	 
		primo = false 
	
	end

	return primo

end


--Graph methos to understand Primes
function PrimeTest:GraphPrimes(col,maxnumber)
	self.fullTest = false
	
	for i = 1, maxnumber do
		prime,msg = self:Test(i)
		
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

	return self.reports.inform("Grafico de testing finalizado, n° de columnas "..col.." y maxnumber: "..maxnumber)
end

return PrimeTest