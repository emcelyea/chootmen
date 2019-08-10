local M = {}

local json = require( "json" )
local saveLocation = system.DocumentsDirectory
local filename = 'a1b2c3.json'

local persistantFields = {
  dmg = 10,
  hp = 10,
  multiplier = 1
}

function M.save( t )
  if t == nil then return end
    local path = system.pathForFile( filename, saveLocation )
    local file, errorString = io.open( path, "w" )
    print('saving', path)
  if not file then
    print( "File error: " .. errorString )
    return false
  else
    file:write( json.encode( t ) )
    io.close( file )
    return true
  end
end

function M.load()
  local path = system.pathForFile( filename, saveLocation )
  local file, errorString = io.open( path, "r" )
  if not file then
    print( "File error: " .. errorString )
    return persistantFields
  else
    local contents = file:read( "*a" )
    local t = json.decode( contents )
    io.close( file )
    return t
  end
end

return M