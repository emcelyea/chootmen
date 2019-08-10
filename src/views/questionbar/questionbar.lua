local widget = require( "widget" )
local Mathquestion = require 'src.views.questionbar.mathquestion'

local questionbar = {}
questionbar.userAnswer = nil
questionbar.correctAnswer = 0
questionbar.totalGameTime = 0
questionbar.statsmanager = nil
-- displays stores all display objects
local displays = {}
function drawBackground()
	displays.bg = display.newRect(display.actualContentWidth/2, display.actualContentHeight-75, display.actualContentWidth, 150)
end

-- TIMER LOGIC
local questionTimer = {
	current = 8000,
	max = 8000,
	x1 = 0,
	x2 = display.actualContentWidth - 10,
	y = display.actualContentHeight - 4 
}

function updateTimer()
	-- @todo read fps from settings?
	questionTimer.current = questionTimer.current - 30
	questionbar.totalGameTime = questionbar.totalGameTime + 30
	-- timeout logic
	if questionTimer.current < 0 then
		questionbar.statsmanager.reset()
		questionTimer.current = questionTimer.max
		drawQuestion()
		-- resetuserAnswer()
		return
	end
	if questionTimer.line ~= nil then
		display.remove(questionTimer.line)
	end
	questionTimer.x2 = (questionTimer.current / questionTimer.max) * display.actualContentWidth
	questionTimer.line = display.newLine(questionTimer.x1, questionTimer.y, questionTimer.x2, questionTimer.y)
	questionTimer.line:setStrokeColor(1 - questionTimer.current / questionTimer.max, questionTimer.current / questionTimer.max, 0)
	questionTimer.line.strokeWidth = 6
end

-- QUESTION LOGIC
function round(num, numDecimalPlaces)
  if numDecimalPlaces and numDecimalPlaces>0 then
    local mult = 10^numDecimalPlaces
    return math.floor(num * mult + 0.5) / mult
  end
  return math.floor(num + 0.5)
end

function drawQuestion()

	local question = Mathquestion.new(questionbar.totalGameTime)
	questionbar.correctAnswer = question.answer

	if displays.question ~= nil then
		display.remove(displays.question)
	end
	if displays.multiplier ~= nil then
		display.remove(displays.multiplier)
	end

	local textOptions = {
		text = question.question,
		x = display.actualContentWidth / 6 - 16,
		y = display.actualContentHeight - 75,
		fontSize = 34
	}
	displays.question = display.newText(textOptions)
	displays.question:setFillColor(0,0,0)

	local multiplierOptions = {
		text = 'X'..round(questionbar.statsmanager.getMultiplier(), 2),
		x = display.actualContentWidth - 264,
		y = display.actualContentHeight - 75,
		fontSize = 34
	}
	displays.multiplier = display.newText(multiplierOptions)
	displays.multiplier:setFillColor(0,0,0)
end

-- Answer input logic

function resetInput()
	drawQuestion()
	questionbar.userAnswer = nil
	display.remove(displays.answer)
	questionTimer.current = questionTimer.max
end

local answerOptions = {
	x = display.actualContentWidth / 3,
	y = display.actualContentHeight - 75,
	fontSize = 34
}

function buttonclicked(e)
	if displays.answer ~= nil then 
		display.remove(displays.answer)
	end

	if questionbar.userAnswer ~= nil then
		questionbar.userAnswer = questionbar.userAnswer..e.target.id
	else
		questionbar.userAnswer = e.target.id
	end

	answerOptions.text = questionbar.userAnswer
	displays.answer = display.newText(answerOptions)
	displays.answer:setFillColor(0,0,0)

	local correct = questionbar.correctAnswer + 0
	local user = questionbar.userAnswer + 0
	-- answer correct
	if correct == user then
		local incrementCount = math.floor(1 + questionbar.totalGameTime / 60000)
		while incrementCount > 0 do
			questionbar.statsmanager.increment()
			incrementCount = incrementCount - 1
		end
		displays.answer:setFillColor(0,1,0.4)
		timer.performWithDelay(200, resetInput)
		return
	end
	-- answer cannot be right
	if correct < user or correct > user and correct < user * 10 then
		questionbar.statsmanager.reset()
		displays.answer:setFillColor(1,0.2,0.2)
		timer.performWithDelay(200, resetInput)
	end
end

function drawInputButtons()
	local numButtons = 0
	local buttonOptions
	while numButtons < 10 do
		buttonOptions = {
			id = numButtons,
			width = 40,
			height = 48,
			x = display.actualContentWidth/2 + 48 + (numButtons % 5 * 40),
			y = display.actualContentHeight - 100 + (math.floor(numButtons / 5) * 48),
			label = ''..numButtons,
      shape = "roundedRect",
      cornerRadius = 1,
      fillColor = { default={1,0,0,1}, over={1,0.1,0.7,0.4} },
      strokeColor = { default={1,0.4,0,1}, over={0.8,0.8,1,1} },
      strokeWidth = 4,
      onRelease = buttonclicked
		}
		displays['numbutton'..numButtons] = widget.newButton(buttonOptions) 
		numButtons = numButtons + 1
	end
end
-- PUBLIC EXPORT
function questionbar.render(statsmanager)
	if statsmanager == nil then
		print( "WARNING: " .. "QuestionBar Render called without arguments")
		return
	end

	questionbar.statsmanager = statsmanager
	drawBackground()
	drawInputButtons()
	drawQuestion()
end

function questionbar.onFrame()
	updateTimer()
end

return questionbar