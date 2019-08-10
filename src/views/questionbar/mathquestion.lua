local MathQuestion = {}
-- operand generator functions
function fetchOperandEasy()
	local modifier = math.random(9)
	local num
	if modifier == 1 then
		return math.random(20)
	end
	return modifier
end

function fetchOperandMedium()
	local modifier = math.random(10)
	if modifier < 3 then
		return math.random(30)
	elseif modifier < 8 then
		return math.random(15)
	end
	return modifier
end

function fetchOperandHard()
	local modifier = math.random(10)
	if modifier < 3 then
		return math.random(50)
	elseif modifier < 8 then
		return math.random(101)
	end
	return math.random(15)
end

function fetchOperandImpossible()
	local modifier = math.random(10)
	if modifier < 3 then
		return math.random(101)
	elseif modifier < 8 then
		return math.random(150)
	else
		return math.random(50)
	end
end

-- generate operator
function fetchOperator(gametime)
	if gametime < 8000 then
		gametime = 8000
	end
	local modifier = math.random(100) + gametime / 8000
	local divisor = math.random(5)
	modifier = math.floor(modifier / divisor)
	local odd = modifier % 2 > 0
	if modifier < 75 then
		if odd then return '-' end
		return '+'
	else
		if odd then return '/' end
		return '*'
	end
end

local operations = {}
operations['+'] = function(left, right) return left + right end
operations['-'] = function(left, right) return left - right end
operations['*'] = function(left, right) return left * right end
operations['/'] = function(left, right) return left / right end

function MathQuestion.new(gametime)
	math.randomseed(os.time())
	local left, right, operator
	if gametime < 60000 then
		left = fetchOperandEasy()
		right = fetchOperandEasy()
		operator = fetchOperator(gametime)
	elseif gametime < 150000 then
		left = fetchOperandMedium()
		right = fetchOperandMedium()
		operator = fetchOperator(gametime) 
	elseif gametime < 300000 then
		left = fetchOperandHard()
		right = fetchOperandHard()
		operator = fetchOperator(gametime)
	else 
		left = fetchOperandImpossible()
		right = fetchOperandImpossible()
		operator = fetchOperator(gametime)		
	end
	-- ensure no negative answers
	if operator == '+' or operator == '-' then
		if left < right then
			local temp = left
			left = right
			right = temp
		end
	end

	-- ensure no decimal answers
	if operator == '/' then
		while left % right ~= 0 and right > 0 do
			right = right - 1
		end
	end

	return {
		answer = operations[operator](left, right),
		question = left..' '..operator..' '..right
	}
	--local problem = loadstring ''..left..operator..right
end

return MathQuestion