-- =============================================================
-- Copyright RiceBurgerLabs 2018
-- =============================================================
-- =============================================================
-- main.lua
-- Takes a CSV file and outputs a file that can be used in project for translation

----------------------------------------------------------------------
--	Requires
----------------------------------------------------------------------

-- Code realize heavily on Roaming Gamers "Super Starter Kit"
-- You can find relevant information and downlod the latest version from the websites below
-- 	https://roaminggamer.github.io/RGDocs/pages/SSK2/
-- 	https://github.com/roaminggamer/SSK2

require "ssk2.loadSSK"
_G.ssk.init({
	launchArgs = ...,
	exportColors = false,
	exportCore = true,
	exportSystem = true,
	measure = false,
	useExternal = false,
	math2DPlugin = false,
	debugLevel = 0
	})
print( "SSK VERSION: " .. ssk.getVersion() )

----------------------------------------------------------------------
--	Main Code
----------------------------------------------------------------------
-- Visual Elements - text placeholder
local options = 
{
    text = "",     
    x = centerX,
    y = centerY,
    width = fullw * .9,
    font = native.systemFont,   
    fontSize = 18,
    align = "center"  -- Alignment parameter
}
local prompt = display.newText( options )

local function readCSVtoTable (fileName, outPutFile)
	-- parameters
		-- fileName - CSV file to be read
		-- outputfile -- name of destination file, will default to "translation.lua" if no file name is supplied

	if not ssk.files.util.exists(fileName) then
		prompt.text = "Specified CSV file '".. fileName .. "'' does not exist"
		return
	end
	local outPutFile = outPutFile or "translation.lua"
	
	-- remove output file if it already exists, otherwise it will append to end
	local path = system.pathForFile( outPutFile, system.DocumentsDirectory )
	ssk.files.util.rmFile(path)

	-- read in CSV file and parse it into a table
	local rawFile = io.readFileTable( fileName, system.ResourceDirectory ) -- read the file into a table, each line is a separate table entry
	local rawTableSplit = {}
	for i = 1, #rawFile do
		rawFile[i] = string.gsub( rawFile[i], "\r", "" )
		rawTableSplit[i] = string.split( rawFile[i], ",")
	end
	table.print_r(rawTableSplit)
	--
	-- extract important information from table
	--
	-- full name of languages
	-- used for commenting purposes
	local languages = {} 
	for i = 1, #rawTableSplit[1] do
		languages[i] = rawTableSplit[1][i]
	end

	-- 'code' used in program to when referencing language
	-- used in the actual table
	local code = {} 
	for i = 1, #rawTableSplit[2] do
		code[i] = rawTableSplit[2][i]
	end

	local tab = "    "

	-- append a new line to the file
	local function p(data)
		local data = string.gsub( data, "\n", "" )
		data = data .. "\n"
		--print(data) -- print out to the console what is being appended to the file
		io.appendFile( data , outPutFile)
	end
 
 	-- "header" information at the top of the file
	p("local public = {}")
	p("-- Translation file")
	p("local translations = {")

	-- loop throught the table rawTableSplit and append the translation information to the file
	for i = 3, #rawTableSplit do
		if rawTableSplit[i][2] == "Yes" then -- only include entries where there is a "Yes" in 'Include' column
			p(tab..[[["]]..rawTableSplit[i][3]..[["] = {]])
			for j = 4, #rawTableSplit[i] do
				p(tab..tab..[[["]]..code[j]..[["] = ]] .. [["]]..rawTableSplit[i][j] ..[["]]..",    -- " .. languages[j])
			end
			p(tab.."},")
		end
	end

	-- "Footer" information
	p("}")

	p([[local lang = system.getPreference( "locale", "language"):lower()]]) -- what language is the device using?

	-- function that will return translated text if it exists, else return the original text
	p("public.t = function(text)")
    p(tab .. "return translations[text] and translations[text][lang] or text")
	p("end")

	p("return public")


	prompt.text = "Check Sandbox Folder for file " .. outPutFile


	return true
end

-- call main function
readCSVtoTable("For Example - All.csv") -- change this line so it points correctly to the CSV file

