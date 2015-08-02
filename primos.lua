function calcularPrimos(numero)
	if numero < 2 then
		return "Debe ingresar un numeor mayor que uno"
	elseif numero == 2 then
		return "El numero es primo"
	else
		primo = true
		divisor = 1
		for i=2,numero/2 do
			if numero%i == 0 then
				primo = false
				divisor =i
				break
			end
		end
		if primo then
			return "El numero "..numero.." es primo"
		else
			return "El numero "..numero.." NO ES PRIMO, es divisible por "..divisor		
		end
	end
end

function inteligentLoop(numero)
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
		divi = serieIncremento(i)
		
		i=i+1
	until  divi > limite

	if primo then
		return "El numero "..numero.." es primo"
	else
		return "El numero "..numero.." NO ES PRIMO, es divisible por "..divisoresToStr(divisors).." cantidad:"..#divisors		
	end
end

function serieIncremento(i)
	
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
function getInmultiple(i,number)
	dispercion = math.floor(number/2)
	
	cantidad = dispercion*2
	
	indice = math.ceil(i/cantidad)

	final_num = number*indice + getSum(i,dispercion)
		
	return final_num 
	
end

--FUNCION PARA TRAER LA SUMA ASOCIADA A LA SERIE DE GETINMULTIPLE
--ejemplo: d= 2 f(1)=-2 f(2)=-1 f(3)=1 f(4)=2 f(5)= -2 f(6)=-1
function getSum(n,disp)
	
	cant = disp *2
	
	resp = (n-1) % cant

	resu = resp -disp 

	if resu>= 0 then resu = resu+1 end

	return resu
end
--FUNCION DE TESTIN DE LAS NUEVAS FUNCIONES
function serialTest()
	for i = 1, 100 do
		print(getInmultiple(i,2))
	end
end

--FUNCIONES DE TEXTO PARA AVISOS
function divisoresToStr(divisores)
	resp = ""
	for i=1, #divisores do
		resp = resp .. divisores[i]
		if i < #divisores then
			resp = resp ..", "
		end
	end
	return resp
end

function esPrimo(numero)
	if numero < 2 then
		return "Debe ingresar un numeor mayor que uno"
	elseif numero == 2 then
		return "El numero es primo"
	else
		return inteligentLoop(numero)
	end
end


