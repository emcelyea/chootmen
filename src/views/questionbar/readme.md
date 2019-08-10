# Questionbar View
* Render and manage the puzzlebar 
* Create a simple interface between the main program state and the puzzlebar functionality.

local questionbar = require 'src.questionbar.questionbar'
local function onQuestionRight() 
	-- perform logic
end
local function onQuestionWrong()
	-- perform logic
end
questionbar.render(onQuestionRight, onQuestionWrong)