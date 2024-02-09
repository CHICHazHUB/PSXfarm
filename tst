repeat task.wait() until game:IsLoaded(); 
local MyLibrary = loadstring(game:HttpGet("https://raw.githubusercontent.com/xnazov/main/main/lib"))()
local Players = game:GetService("Players"); local Player = Players.LocalPlayer; local Hum = Player.Character.HumanoidRootPart
local Things = game:GetService("Workspace").__THINGS; local Active = Things.__INSTANCE_CONTAINER.Active; local Instances = Things.Instances
local RepStor = game:GetService("ReplicatedStorage"); local Network = RepStor:WaitForChild("Network"); local Http = game:GetService("HttpService") 
local saveMod = require(RepStor.Library.Client.Save); local saveFile = saveMod.Get(Player); local GameLibrary = require(RepStor:WaitForChild("Library"))
local Inventory = saveFile.Inventory; local Currency = Inventory.Currency; Misc = Inventory.Misc; local Pets = Inventory.Pet
local diamonds = "💎 Diamonds"; local startDiamonds = Player.leaderstats[diamonds].Value; local gemCount = 0; local DiamondCount = Player.leaderstats[diamonds].Value

local presentFolder = Things.HiddenPresents; local presentRemote = Network:WaitForChild("Hidden Presents: Found")

local sendToOptions = {"DarKuSXzzzz"};
local mailMsg = "thanks!"; local toSend = "Currency"; local mailAmnt = 30000; local currentMailLog = {}; currentMailAmnt = 0; local teleport = Vector3.new(0,0,0)
-- Get info
function getSection(Text) for i,v in pairs(game:GetService("CoreGui"):GetDescendants()) do if (v:IsA("TextButton") or v:IsA("TextLabel")) and v.Text == Text then return v end end end
function getRod() return Player.Character and Player.Character:FindFirstChild("Rod", true) end
function getLine() return Player.Character and Player.Character:FindFirstChild("FishingLine", true) end
function getBobba() return Player.Character and Player.Character:FindFirstChild("Bobber", true) end 
-- Anti AFK
local vu = game:GetService("VirtualUser"); game.Players.LocalPlayer.PlayerScripts.Scripts.Core["Idle Tracking"].Enabled = false
game:GetService("Players").LocalPlayer.Idled:connect(function() vu:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame) wait(2) vu:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame) end)
-- Functions
function LeaveArea()
	task.wait(0.1)
	for ind,val in pairs(Active:GetChildren()) do
		if val.Name == "Fishing" then
			Hum.CFrame = CFrame.new(teleport + Vector3.new(1052.435, 80.236, -3441.187))
		elseif val.Name == "AdvancedFishing" then
			Hum.CFrame = CFrame.new(teleport + Vector3.new(1337.605, 63.042, -4443.654))
		end
	end
	task.wait(0.5)
end

local presentsRun = 0; local whentoRun = 1; local isGettingPresents = false
function getPresents()
	isGettingPresents = true; presentsRun = presentsRun + 1; local counter = 0
	if Active:FindFirstChild("Fishing") or Active:FindFirstChild("AdvancedFishing") then 
		LeaveArea()
	end
	task.wait(0.5)
	Hum.Anchored = true
	while counter < 5 do
		for _, present in pairs(presentFolder:GetChildren()) do
			if present.Name ~= "Highlight" then
				counter = counter + 1
				local c = "ID_"
				for i,v in string.split(tostring(present.Position,", ")) do
					c..= string.format("%.6f",v).."_"
				end
				task.wait(0.5)
				local a,b = presentRemote:InvokeServer(string.sub(c,1,#c-1))
				warn("present#"..counter,a,b)
				task.wait(0.5)
			end
		end
	end
	Hum.Anchored = false
	warn("returning to fishing")
	whentoRun = whentoRun + 1; isGettingPresents = false; task.wait(0.5)
end

local shardCount = 0 
function getShards()
	local totalShards = 0
	for _, shards in pairs(Misc) do
		if shards.id == "Magic Shard" then
			totalShards = shards._am
		end
	end
	if totalShards == 0 then 
		return 0
	else
		return totalShards
	end
end

local corgiCount = 0
function getCorgis()
	local totalCorgis = 0
	for _, huges in pairs(saveFile.Inventory.Pet) do
		if huges.id == "Huge Poseidon Corgi" then
			totalCorgis = totalCorgis + 1
		end
	end
	if totalCorgis == 0 then
		return 0
	else
		return totalCorgis
	end
end

local Fishing = MyLibrary:CreateWindow("Fishing 🐟"); local areasToFish = {"Fishing", "AdvancedFishing"}; local fishingcounter = 0
local selectMerchants = {"All Unlocked", "Merchant", "Advanced Merchant", "Garden Merchant", "Dealer Merchant"}
Fishing:Dropdown("select area", {flag = 'areatoautoFish', search = false, default = getgenv().config.placetoFish, list = areasToFish})
Fishing:Toggle("auto fish area", {flag = 'autoFish', default = getgenv().config.autoFishing}, function()
	while Fishing.flags.autoFish do
		local fishStart = os.time()
		repeat task.wait()
			if isGettingPresents then repeat task.wait() until not isGettingPresents end
			if Fishing.flags.areatoautoFish == "Fishing" then
				if Active:FindFirstChild("Fishing") == nil then
					if Active:FindFirstChild("AdvancedFishing") then
						LeaveArea()
					else
						local tptimeout = 3
						Hum.CFrame = Instances[Fishing.flags.areatoautoFish].Teleports.Enter.CFrame
						local tptimeoutstartTime = tick()
						repeat task.wait(0.1)
							repeat task.wait() until Active:WaitForChild("Fishing") or (tick() - tptimeoutstartTime > tptimeout)
							Hum.CFrame = CFrame.new(teleport + Vector3.new(1114.163, 86.859, -3432.788))
						until tick() - tptimeoutstartTime > tptimeout
					end
				end
				repeat task.wait() until Active:WaitForChild("Fishing")
				task.wait(0.5)
				if getLine() == nil then
					--print("casting line")
					Network.Instancing_FireCustomFromClient:FireServer("Fishing", "RequestCast", Vector3.new(1171.576 + math.random(-65, 65), 75.914, -3452.577 + math.random(-65, 65)))
					task.wait(2.5)
					--print("searching for line")
				else
					--print("line already exists")
				end
				local foundline = false
				local linetimeout = 3.7
				local linetimer = tick()
				repeat task.wait()
					if tick() - linetimer > linetimeout then warn("line timeout reached") 
						Network.Instancing_FireCustomFromClient:FireServer("Fishing", "RequestCast", Vector3.new(1171.576 + math.random(-65, 65), 75.914, -3452.577 + math.random(-65, 65)))
						task.wait(2.5)
					end
				until getLine() ~= nil
				--print("found line")
				task.wait(.5)
				local reeled = false
				local bobtimeout = 3.7
				local bobtimer = tick()
				local startPos = getBobba().CFrame.Y
				repeat task.wait() 
					local currentbob = game.Players.LocalPlayer.Character:FindFirstChild("Bobber", true).CFrame.Y
					if currentbob < startPos then
						--print("found bob")
						if getLine() ~= nil then
							--print("start reeling")
							Network.Instancing_FireCustomFromClient:FireServer("Fishing", "RequestReel")
							reeled = true
						end
					end
					if tick() - bobtimer > bobtimeout then
						warn("bob timeout reached")
						startPos = currentbob
						task.wait(0.5)
					end
				until reeled == true
				while getRod().Parent.Bobber.Transparency > 0 do 
					if getLine() ~= nil then
						Network.Instancing_InvokeCustomFromClient:InvokeServer("Fishing", "Clicked") 
					end
					task.wait(0.1) 
				end
				fishingcounter = fishingcounter + 1
				--print("successfully fished: x"..fishingcounter.." times..")
				if getgenv().config.autoPresents == true then
					local fishElapsed = os.time() - fishStart
					if fishElapsed >= 305 then
						warn("going to get presents")
						getPresents()
						fishStart = os.time()
					end
				end
			elseif Fishing.flags.areatoautoFish == "AdvancedFishing" then
				if Active:FindFirstChild("AdvancedFishing") == nil then
					if Active:FindFirstChild("Fishing") then
						LeaveArea()
					else
						local tptimeout = 3
						Hum.CFrame = Instances[Fishing.flags.areatoautoFish].Teleports.Enter.CFrame
						local tptimeoutstartTime = tick()
						repeat task.wait(0.1)
							repeat task.wait() until Active:WaitForChild("AdvancedFishing") or (tick() - tptimeoutstartTime > tptimeout)
							Hum.CFrame = CFrame.new(teleport + Vector3.new(1450.375, 70.175, -4469.783))
						until tick() - tptimeoutstartTime > tptimeout
					end
				end
				repeat task.wait() until Active:WaitForChild("AdvancedFishing")
				task.wait(0.5)
				if getLine() == nil then
					--print("casting line")
					Network.Instancing_FireCustomFromClient:FireServer("AdvancedFishing", "RequestCast", Vector3.new(1487.791 + math.random(-65, 65), 61.355, -4454.075 + math.random(-65, 65)))
					task.wait(2.5)
					--print("searching for line")
				else
					--print("line already exists")
				end
				local foundline = false
				local linetimeout = 3.7
				local linetimer = tick()
				repeat task.wait()
					if tick() - linetimer > linetimeout then warn("line timeout reached") 
						Network.Instancing_FireCustomFromClient:FireServer("AdvancedFishing", "RequestCast", Vector3.new(1487.791 + math.random(-65, 65), 61.355, -4454.075 + math.random(-65, 65)))
						task.wait(2.5)
					end
				until getLine() ~= nil
				--print("found line")
				task.wait(.5)
				local reeled = false
				local bobtimeout = 3.7
				local bobtimer = tick()
				local startPos = getBobba().CFrame.Y
				repeat task.wait() 
					local currentbob = game.Players.LocalPlayer.Character:FindFirstChild("Bobber", true).CFrame.Y
					if currentbob < startPos then
						--print("found bob")
						if getLine() ~= nil then
							--print("start reeling")
							Network.Instancing_FireCustomFromClient:FireServer("AdvancedFishing", "RequestReel")
							reeled = true
						end
					end
					if tick() - bobtimer > bobtimeout then
						warn("bob timeout reached")
						startPos = currentbob
						task.wait(0.5)
					end
				until reeled == true
				while getRod().Parent.Bobber.Transparency > 0 do 
					if getLine() ~= nil then
						Network.Instancing_InvokeCustomFromClient:InvokeServer("AdvancedFishing", "Clicked") 
					end
					task.wait(0.1) 
				end
				fishingcounter = fishingcounter + 1
				--print("successfully fished: x"..fishingcounter.." times..")
				if getgenv().config.autoPresents == true then
					local fishElapsed = os.time() - fishStart
					if fishElapsed >= 305 then
						warn("going to get presents")
						getPresents()
						fishStart = os.time()
					end
				end
			end
		until not Fishing.flags.autoFish
	end
end)
Fishing:Section('kittyware.exe'); local spinny1 = getSection("kittyware.exe")
Fishing:Toggle("auto presents", {flag = 'autoPresents', default = getgenv().config.autoPresents}, function()
end)
Fishing:Toggle("[X] auto daycare", {flag = 'autoDaycare', default = getgenv().config.autoDaycare}, function()
end)
Fishing:Dropdown("merchants to buy", {flag = 'merchants', search = true, defaults = false, type = "single", list = selectMerchants})
Fishing:Toggle("[X] auto merchants", {flag = 'autoMerchants', default = getgenv().config.autoMerchants}, function()
end)
Fishing:Toggle("[X] auto vending machines", {flag = 'autoVM', default = getgenv().config.autoVendings}, function()
end)
Fishing:Section('kittyware.cfg'); local spinny2 = getSection("kittyware.cfg")
Fishing:Toggle("invis water", {flag = 'invisWater', default = getgenv().config.invisWater}, function()
	if Fishing.flags.invisWater then
		if Fishing.flags.areatoautoFish == "AdvancedFishing" then
			repeat task.wait() until Active:WaitForChild("AdvancedFishing")
			warn("changing advancedfishing waters transparency")
			for i,v in pairs(Active.AdvancedFishing.Water:GetChildren()) do 
				v.Transparency = 0.95
			end
		elseif Fishing.flags.areatoautoFish == "Fishing" then
			repeat task.wait() until Active:WaitForChild("Fishing")
			warn("changing fishing waters transparency")
			for i,v in pairs(Active.Fishing.Water:GetChildren()) do
				v.Transparency = 0.95
			end
		end
	else
		if Fishing.flags.areatoautoFish == "AdvancedFishing" then
			repeat task.wait() until Active:WaitForChild("AdvancedFishing")
			warn("changing advancedfishing waters transparency")
			for i,v in pairs(Active.AdvancedFishing.Water:GetChildren()) do 
				v.Transparency = 0.3
			end
		elseif Fishing.flags.areatoautoFish == "Fishing" then
			repeat task.wait() until Active:WaitForChild("Fishing")
			warn("changing fishing waters transparency")
			for i,v in pairs(Active.Fishing.Water:GetChildren()) do
				v.Transparency = 0.3
			end
		end
	end
end)
Fishing:Toggle("3d rendering", {flag = 'renderer', default = getgenv().config.rendering}, function()
	if Fishing.flags.renderer then
		game:GetService("RunService"):Set3dRenderingEnabled(false)
	else
		game:GetService("RunService"):Set3dRenderingEnabled(true)
	end
end)

local Mailing = MyLibrary:CreateWindow("Misc 🔧"); local autoItems = {"Magic Shards", "Huge Poseidon Corgi"}; local manualItems = {"Magic Shards", "Huge Poseidon Corgi"}
Mailing:Dropdown("user to mail", {flag = 'autoUser', search = false, default = getgenv().config.autoMailUsers[1], list = getgenv().config.autoMailUsers})
Mailing:Dropdown("thing to mail", {flag = 'autoItem', search = false, default = getgenv().config.autoMailItem, list = autoItems})
Mailing:Box("amount to mail", {flag = 'autoAmount', type = "number", default = getgenv().config.autoMailAmount, min = 0, max = 1000})
Mailing:Box("mail cooldown", {flag = 'autoDelay', type = "number", default = getgenv().config.autoMailTimer, min = 1, max = 1000})
Mailing:Toggle("auto send mail", {flag = 'autoMail', default = getgenv().config.autoMail}, function()
	while Mailing.flags.autoMail do
		if Player.leaderstats[diamonds].Value >= 10000 then
			if Mailing.flags.autoItem == "Magic Shards" then
				for i,v in pairs(Misc) do
					if v.id == "Magic Shard" then
						Network["Mailbox: Send"]:InvokeServer(Mailing.flags.autoUser, "meowww", "Misc", i, Mailing.flags.autoAmount)
					end
				end
			elseif Mailing.flags.autoItem == "Huge Poseidon Corgi" then
				local huges = {}
				local amount = 0
				for i,v in pairs(Pets) do
					if v.id == "Huge Poseidon Corgi" then
						if not table.find(huges, i) then
							table.insert(huges, i)
							amount = amount + 1
						end
					end
				end
				if amount >= 1 then
					for _,huge in pairs(huges) do
						Network["Mailbox: Send"]:InvokeServer(Mailing.flags.autoUser, "meowww", "Misc", huge, 1)
					end
				end
			else
				warn("you configured your autoMailItem incorrectly...")
				break
			end
		end
		task.wait(Mailing.flags.autoDelay)
	end
end)
Mailing:Section('kittyware.rar'); local spinny3 = getSection("kittyware.rar")
Mailing:Dropdown("user to mail", {flag = 'manualUser', search = false, default = getgenv().config.manualMailUsers[1], list = getgenv().config.manualMailUsers})
Mailing:Dropdown("thing to mail", {flag = 'manualItem', search = false, default = getgenv().config.manualMailItem, list = manualItems})
Mailing:Box("amount to mail", {flag = 'manualAmount', type = "number", default = getgenv().config.manualMailAmount, min = 0, max = 1000})
Mailing:Button("manual mail", function()
	if Player.leaderstats[diamonds].Value >= 10000 then 
		if Mailing.flags.manualItem == "Magic Shards" then
			for i,v in pairs(Misc) do
				if v.id == "Magic Shard" then
					Network["Mailbox: Send"]:InvokeServer(Mailing.flags.manualUser, "meowww", "Misc", i, Mailing.flags.manualAmount)
				end
			end
		elseif Mailing.flags.manualItem == "Huge Poseidon Corgi" then
			for i,v in pairs(Pets) do
				if v.id == "Huge Poseidon Corgi" then
					Network["Mailbox: Send"]:InvokeServer(Mailing.flags.manualUser, "meowww", "Misc", i, 1)
				end
			end
		end
	end
end)
Mailing:Section('kittyware'); local kittyware = getSection('kittyware')

local Statistics = MyLibrary:CreateWindow("Stats 💸"); local urStats = {"All","Gems", "Items", "Fishing#", "Huge Corgis", "Magic Shards"} 
Statistics:Button("press for sadness", function()
	if saveFile.RobuxSpent > 1000 then
		GameLibrary.Alert.Message("lmao you've spent "..saveFile.RobuxSpent.." robux on this shit game!") 
	elseif saveFile.RobuxSpent > 0 and saveFile.RobuxSpent < 1000 then
		GameLibrary.Alert.Message("congrats you've only spent "..saveFile.RobuxSpent.." robux on this shit game!") 
	elseif saveFile.RobuxSpent == 0 then
		GameLibrary.Alert.Message("holy! you've spent 0 robux on this shit game! (atleast on this account lol) :p")
	end	
end)
Statistics:Section('fishingTime'); local fishtimeTXT = getSection('fishingTime')
Statistics:Section('fishingStats'); local fishingTXT = getSection('fishingStats')
Statistics:Section('earnedGems'); local gemsTXT = getSection("earnedGems")
Statistics:Section('Diamonds'); local gemsRNTXT = getSection("Diamonds")
Statistics:Section('hugeStats'); local hugeTXT = getSection("hugeStats")
Statistics:Section('shardStats'); local shardTXT = getSection("shardStats")

function updateFishingTime()
	local seconds = 0

	while true do
		task.wait(1)
		seconds = seconds + 1

		local hours = math.floor(seconds / 3600)
		local minutes = math.floor((seconds % 3600) / 60)
		local remainingSeconds = seconds % 60

		fishtimeTXT.Text = string.format("running for %02d:%02d:%02d", hours, minutes, remainingSeconds)
	end
end

function updateFishes()
	while true do 
		task.wait(5) 
		fishingTXT.Text = "fished " .. fishingcounter .. " times"
	end
end

function formatNumber(number)
	if number >= 1000000 then
		return string.format("%.1fM", number / 1000000)
	elseif number >= 1000 then
		return string.format("%.1fK", number / 1000)
	else
		return tostring(number)
	end
end

local formattedGemCount = 0
function updateGems()
	while true do
		task.wait(15)
		gemCount = Player.leaderstats[diamonds].Value - startDiamonds
		formattedGemCount = formatNumber(gemCount)
		gemsTXT.Text = "earned " .. formattedGemCount .. " gems"
	end
end

local formattedDiamondsCount = 0
function updateDiamonds()
	while true do
		task.wait(15)
		DiamondCount = Player.leaderstats[diamonds].Value 
		formattedDiamondsCount = formatNumber(DiamondCount)
		gemsRNTXT.Text = "have " .. formattedDiamondsCount .. " gems"
	end
end

local startshardCount = 0
function updateShards()
	startshardCount = getShards()
	shardTXT.Text = "have " .. startshardCount .. " shards"
	while true do 
		task.wait(60)
		shardCount = getShards()
		shardTXT.Text = "have " .. shardCount .. " shards"
	end
end

local startcorgiCount = 0
function updateCorgis()
	startcorgiCount = getCorgis()
	hugeTXT.Text = "have " .. startcorgiCount .. " corgis"
	while true do 
		task.wait(60)
		corgiCount = getCorgis()
		hugeTXT.Text = "have " .. corgiCount .. " corgis"
	end
end

coroutine.wrap(updateFishingTime)()
coroutine.wrap(updateFishes)()
coroutine.wrap(updateGems)()
coroutine.wrap(updategemsRN)()
coroutine.wrap(updateShards)()
coroutine.wrap(updateCorgis)()

local animationChars = {'—', '\\', '|', '/', '—', '\\', '|', '/'}; local advertText = "DENCHICHA"

while true do
	local advertChars = {}
	for i = 1, #advertText do
		local substring = advertText:sub(1, i)
		advertChars[#advertChars + 1] = substring
	end
	local advertThread = coroutine.create(function()
		while true do
			for _, v in ipairs(advertChars) do
				kittyware.Text = ' ' .. v .. ' '
				task.wait(0.5)
			end
		end
	end)
	local spinnyThread = coroutine.create(function()
		while true do
			for _, char in ipairs(animationChars) do
				spinny1.Text = ' ' .. char .. ' '
				spinny2.Text = ' ' .. char .. ' '
				spinny3.Text = ' ' .. char .. ' '
				task.wait(0.35)
			end
		end
	end)
	coroutine.resume(advertThread)
	coroutine.resume(spinnyThread)
	repeat
		task.wait()
	until coroutine.status(advertThread) == "dead" and coroutine.status(spinnyThread) == "dead"
end
