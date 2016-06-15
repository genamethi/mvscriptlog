--[[
A convoluted way to move PX script log to text directory and nag someone to reload txt files. VERSION 0.0.3 by amenay
Maybe I should put it on a timer.
Caution this restarts all scripts.
]]

io.output( Core.GetPtokaXPath() .. "/texts/scriptlog.txt" )

if not SetMan.GetBool( 55 ) then --Turn on Script Error Logging if not already.
	if SetMan.SetBool( 55, true ) then	--This shouldn't be necessary. A precaution against infinite loop caused by failure elsewhere.
		SetMan.Save()
		Core.SendToOps( "Now logging script errors." )
		Core.RestartScripts() --So we have a log of errors that might occur on restart
	end
end

local f,e = io.open( Core.GetPtokaXPath() .. "/logs/script.log" )

if e then
	Core.SendToOps( e )
elseif io.write( f:read( "a" ) ) then
	Core.SendToOps( "Successfully wrote script.txt to texts directory. Type !reloadtxt then !scriptlog to read." ) 
	io.flush()
	return 1 --Just cuz I'm crazy like this.
end