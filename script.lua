Ticker = 0
Start = false
Units_Table = {}
Paths_Table ={}

SecTechTop = {TMPL1, TMPL2, TMPL3}
SecTechBot = {MISS1, MISS2, MISS3}
SecTechMid = {FIXT1, FIXT2, FIXT3}


Factorys = {"e1factory","e2factory" ,"e3factory" ,"e4factory" ,"e5factory" ,"e22factory", "rmbofactory" ,"carfactory1", "carfactory2", "carfactory3", "carfactory4", "carfactory5", "carfactory6", "carfactory7" ,"carfactory8", "airfact1" ,"airfact2", "secretfactory1", "secretfactory2", "secretfactory3", "secretfactory4", "carfactorybg","carfactory10", "airfact0" , "sillyfact1", "sillyfact2", "sillyfact3", "sillyfact4", "sillyfact5", "sillyfact6", "leviathanfact"}
QueueUnits = {"e1new", "e2new","e3new","e4new","e5new","e22new","rmbonew", "jeepnew","mtnknew","msamnew","htnknew", "artynew", "ftnknew","mlrsnew","bikenew","orcanew","helinew","tmplangel","fatwr","guntank","moico","bggynew","stnknew", "trannew", "sillyca", "harvnew", "sillybadr", "flagplat", "discthrow", "lstnew", "leviathan"}
QueueUnitsIndex = {}
Values = {10,14,20,18,25,25,100, 30,45,50,100, 40, 30,20,20,55,60,120,120,70,160,30,45,25,200,150,200,175,100,150,1000}
CashValuesLeft = {0,0,0}
CashValuesRight = {0,0,0}

-- The Cash Bonus of the Stock Marked building
ExtraCash = function()	
	for i = 1,#TeamLeft do
		if TeamLeft[i] ~= nil and TeamLeft[i].HasPrerequisites({"cash2"}) then
		
			local stockmarked = Map.ActorsInBox(Map.TopLeft, Map.BottomRight, function(C)
				return C.Owner == TeamLeft[i] and (C.Type == "cash2" or C.Type == "cash2t2" or C.Type == "cash2t3" or C.Type == "cash2t4" or C.Type == "cash2t5" or C.Type == "cash2t6" or C.Type == "cash2t7" or C.Type == "cash2t8" or C.Type == "cash2t9" or C.Type == "cash2t10" or C.Type == "cash2t11" or C.Type == "cash2t12" or C.Type == "cash2t13" or C.Type == "cash2t14" or C.Type == "cash2t15" or C.Type == "cash2t16")
			end)	
		
			local cashier = 0
			for a=1,#TeamRight do
				if TeamRight[a] ~= nil and not TeamRight[a].HasNoRequiredUnits() then
					cashier = cashier + CashValuesRight[a]
				end
			end		
			TeamLeft[i].Cash = TeamLeft[i].Cash + cashier
			Media.FloatingText("+" .. tostring(cashier) .. "$", stockmarked[1].CenterPosition + WVec.New(0,-100,0), 30, TeamLeft[i].Color)
			Media.DisplayMessage("Player " .. TeamLeft[i].Name .. " earned: " .. tostring(cashier) .. " in stock exchanges!", prefix = "Stockmarked: ", TeamLeft[i].Color)
		end
	end
	for i = 1,#TeamRight do
		if TeamRight[i] ~= nil and TeamRight[i].HasPrerequisites({"cash2"}) then
			
			local stockmarked = Map.ActorsInBox(Map.TopLeft, Map.BottomRight, function(C)
				return C.Owner == TeamLeft[i] and (C.Type == "cash2" or C.Type == "cash2t2" or C.Type == "cash2t3" or C.Type == "cash2t4" or C.Type == "cash2t5" or C.Type == "cash2t6" or C.Type == "cash2t7" or C.Type == "cash2t8" or C.Type == "cash2t9" or C.Type == "cash2t10" or C.Type == "cash2t11" or C.Type == "cash2t12" or C.Type == "cash2t13" or C.Type == "cash2t14" or C.Type == "cash2t15" or C.Type == "cash2t16")
			end)
			
			local cashier = 0
			for a=1,#TeamLeft do
				if TeamLeft[a] ~= nil and not TeamLeft[a].HasNoRequiredUnits() then
					cashier = cashier + CashValuesLeft[a]
				end
			end
			TeamRight[i].Cash = TeamRight[i].Cash + cashier
			local stockmarked = TeamRight[i].GetActorsByType("cash2")
			Media.FloatingText("+" .. tostring(cashier) .. "$", stockmarked[1].CenterPosition + WVec.New(0,-100,0), 30, TeamRight[i].Color)
			Media.DisplayMessage("Player " .. TeamLeft[i].Name .. " earned: " .. tostring(cashier) .. " in stock exchanges!", prefix = "Stockmarked: ", Color, TeamRight[i].Color)
		end
	end
	for i=1,3 do
		CashValuesLeft[i] = 0
		CashValuesRight[i] = 0
	end
	Trigger.AfterDelay(DateTime.Seconds(60),ExtraCash)
end

-- Neutral Techbuildings changing Owner via Proximity
Proxy1 = function()
	Trigger.OnEnteredProximityTrigger(Map.CenterOfCell(CPos.New(9,65)), WDist.FromCells(3), function(a, id)
		local mine = TMPL1.Owner
		local yours = a.Owner
		if yours ~= Player.GetPlayer("Neutral") and yours ~= Player.GetPlayer("Creeps") and Actor.CruiseAltitude(a.Type) == 0 then
			if yours == TeamLeft[1] or yours == TeamLeft[2] or yours == TeamLeft[3] then
				for i = 1,3 do
					if TeamLeft[i] ~= nil then
						SecTechTop[i].Owner = TeamLeft[i]
					end
				end
			elseif yours == TeamRight[1] or yours == TeamRight[2] or yours == TeamRight[3] then
				for i = 1,3 do
					if TeamRight[i] ~= nil then
						SecTechTop[i].Owner = TeamRight[i]
					end
				end
			end
		end
	end)
	Trigger.OnEnteredProximityTrigger(Map.CenterOfCell(CPos.New(118,64)), WDist.FromCells(3), function(a, id)
		local mine = MISS1.Owner
		local yours = a.Owner
		if yours ~= Player.GetPlayer("Neutral") and yours ~= Player.GetPlayer("Creeps") and Actor.CruiseAltitude(a.Type) == 0 then
			if yours == TeamLeft[1] or yours == TeamLeft[2] or yours == TeamLeft[3] then
				for i = 1,3 do
					if TeamLeft[i] ~= nil then
						SecTechBot[i].Owner = TeamLeft[i]
					end
				end
			elseif yours == TeamRight[1] or yours == TeamRight[2] or yours == TeamRight[3] then
				for i = 1,3 do
					if TeamRight[i] ~= nil then
						SecTechBot[i].Owner = TeamRight[i]
					end
				end
			end
		end
	end)	
	Trigger.OnEnteredProximityTrigger(Map.CenterOfCell(CPos.New(64,65)), WDist.FromCells(3), function(a, id)
		local mine = FIXT1.Owner
		local yours = a.Owner
		if yours ~= Player.GetPlayer("Neutral") and yours ~= Player.GetPlayer("Creeps") and Actor.CruiseAltitude(a.Type) == 0 then
			if yours == TeamLeft[1] or yours == TeamLeft[2] or yours == TeamLeft[3] then
				for i = 1,3 do
					if TeamLeft[i] ~= nil then
						SecTechMid[i].Owner = TeamLeft[i]
					end
				end
			elseif yours == TeamRight[1] or yours == TeamRight[2] or yours == TeamRight[3] then
				for i = 1,3 do
					if TeamRight[i] ~= nil then
						SecTechMid[i].Owner = TeamRight[i]
					end
				end
			end
		end
	end)	
end

function Set (list)
  local set = {}
  for _, l in ipairs(list) do set[l] = true end
  return set
end	
	
-- Build Trigger Precheck, if buildingtypes Match
BuildTrigger = function(Unit)	
	local Facts = Set {"e1factory","e2factory" ,"e3factory" ,"e4factory" ,"e5factory" ,"e22factory", "rmbofactory" ,"carfactory1", "carfactory2", "carfactory3", "carfactory4", "carfactory5", "carfactory6", "carfactory7" ,"carfactory8", "airfact2" ,"airfact1", "secretfactory1", "secretfactory2", "secretfactory3", "secretfactory4", "carfactorybg","stnknew", "airfact0" }
	if Facts[Unit.Type] then
		StartBuilding(Unit)
	end
end

--Bountytigger, checks if the owner of the Attacker has the building build

-- Autoproduction of the fatories
StartBuilding = function(Bldng)
	for a,b in ipairs(Factorys) do
		local Producer = Bldng
		local Queue	= QueueUnits[a]
		local Number = a
		if Bldng.Type == b and not Producer.IsDead then
			Producer.Build({Queue},function(u) 
		end)
		Trigger.OnIdle(Producer,function(a) TriggerBuildagain(a,Queue,Number) end)
			local act = Actor.Create(Queue,true,{Owner = Producer.Owner,Location = Producer.Location+CVec.New(0,2), Facing = 0})
			break
		end
	end
end

-- Let units move along there destiny path when enter the world.
MovementTriggerUnits = function(Unit)
	for k,v in ipairs(QueueUnits) do
		if v == Unit.Type then
			MovementTrigger(Unit)	
		end
	end
end

-- Factories start building again when idleing
TriggerBuildagain = function(Producer,Queue,Number)
	if not Producer.IsDead then
		Producer.Build({Queue},function(u) 
		end)
	end 
end

-- restart all factories after the placeholder was build
RestartProduce = function(Unit)
	if Unit.Type == "placeholder" then
		Unit.Stop()
		Unit.Destroy()
		local Factorys = Map.ActorsInBox(Map.TopLeft, Map.BottomRight, function(C)
			return C.Type == "e1factory" or C.Type == "e2factory" or C.Type == "e3factory" or C.Type == "e4factory" or C.Type == "e5factory" or C.Type == "e22factory" or C.Type == "rmbofactory" or C.Type == "carfactory1" or C.Type == "carfactory2" or C.Type == "carfactory3" or C.Type == "carfactory4" or C.Type == "carfactory5" or C.Type == "carfactory6" or C.Type == "carfactory7" or C.Type == "carfactory8" or C.Type == "airfact2"or C.Type == "airfact1" or C.Type == "secretfactory1" or C.Type == "secretfactory2" or C.Type == "secretfactory3" or C.Type == "secretfactory4" or C.Type == "carfactorybg" or C.Type == "carfactory10" or C.Type == "airfact0"
		end)	
		for k,v in ipairs(Factorys) do
			if v.Owner == Unit.Owner then
				local de=k
				Trigger.AfterDelay(de, function() v.Owner = Player.GetPlayer("Neutral")  end)
				Trigger.AfterDelay(de+2, function() v.Owner = Unit.Owner end)
				Trigger.AfterDelay(de+4, function() v.Owner = Player.GetPlayer("Neutral")  end)
				Trigger.AfterDelay(de+6, function() v.Owner = Unit.Owner end)
				Trigger.AfterDelay(de+8, function() v.Owner = Player.GetPlayer("Neutral")  end)
				Trigger.AfterDelay(de+10, function() v.Owner = Unit.Owner end)
			end
		end
	end
end

-- spawn leviathan when someone forced to with the button
FinishLeviathan = function(Unit)
	if Unit.Type == "placeholderlevi" or Unit.Type == "placeholdsecondlev" then
		Unit.Stop()
		Unit.Destroy()
		local Factorys = Map.ActorsInBox(Map.TopLeft, Map.BottomRight, function(C)
			return  (C.Type == "leviathanfact" and C.Owner == Unit.Owner)
		end)	
		if Factorys ~= nil and Factorys[1] ~=nil and Factorys[1].Type == "leviathanfact" then
			local act = Actor.Create("leviathan",true,{Owner = Unit.Owner,Location = Factorys[1].Location+CVec.New(2,2), Facing = 0})
		end
	end
end

WorldLoaded = function()
	
	for i,v in ipairs(QueueUnits) do
		QueueUnitsIndex[v] = i
	end
	-- Basic Trigger Start: Unitmovement/ Factorie production/ MCV unfolding
	Trigger.OnEnteredProximityTrigger(Map.CenterOfCell(CPos.New(64,64)),WDist.FromCells(128), function(a, id)
		for k,v in ipairs(QueueUnits) do
			if a.Type == v then
				MovementTriggerUnits(a)
			end
		end 
	end)
	Trigger.OnEnteredProximityTrigger(Map.CenterOfCell(CPos.New(64,64)),WDist.FromCells(128), function(a, id)
		if a.Type == "placeholder" then
			RestartProduce(a)
		end 
	end)
	Trigger.OnEnteredProximityTrigger(Map.CenterOfCell(CPos.New(64,64)),WDist.FromCells(128), function(a, id)
		if a.Type == "placeholderlevi" or a.Type == "placeholdsecondlev"then
			FinishLeviathan(a)
		end 
	end)

	
	Trigger.OnEnteredProximityTrigger(Map.CenterOfCell(CPos.New(64,64)),WDist.FromCells(128), function(a, id)
		for k,v in ipairs(Factorys) do
			if a.Type == v then
				StartBuilding(a)
			end
		end 
	end)	
	Trigger.AfterDelay(DateTime.Seconds(0), function()
		local MBFs = Map.ActorsInBox(Map.TopLeft, Map.BottomRight, function(a)
			return a.Type == "mcv" 
		end)	
		for k,v in ipairs(MBFs) do
			v.Deploy()
		end
	end)
	
	-- AI/ Bots cheats
	Trigger.AfterDelay(DateTime.Seconds(10), function()
		for i = 1,6 do
			local People = Player.GetPlayer("Multi" .. tostring(i-1))
			if People ~= nil and People.IsBot == true then
				if People.Name == "Easy AI" then
					People.Cash = People.Cash + 500
				end
				if People.Name == "Medium AI" then
					People.Cash = People.Cash + 1000
				end
				if People.Name == "Hard AI" then
					People.Cash = People.Cash + 2000
				end
			end
		end
		Media.DisplayMessage("Welcome to Conyard Wars!", prefix = "Conyard Wars: ")
		Trigger.AfterDelay(DateTime.Seconds(3), function()
			Media.DisplayMessage("Keep in mind: the price of each tech-building will increase by '400' with each tech-building you already build!", prefix = "Conyard Wars: ")
		end)
		Trigger.AfterDelay(DateTime.Seconds(10), function()
			Media.DisplayMessage("Regular unit-upgrades are found in two tabs under the 'Heading'!", prefix = "Conyard Wars: ")
		end)
	end)
	
	-- more AI/ Bots cheats
	for a = 1, 10 do
	Trigger.AfterDelay(DateTime.Minutes(a*2), function()
		for i = 1,6 do
			local People = Player.GetPlayer("Multi" .. tostring(i-1))
			if People ~= nil and People.IsBot == true then
				if People.Name == "Easy AI" then
					People.Cash = People.Cash + 500
					print(People.Name .. " got 500")
				end
				if People.Name == "Medium AI" then
					People.Cash = People.Cash + 1000
					print(People.Name .. " got 1000")
				end
				if People.Name == "Hard AI" then
					People.Cash = People.Cash + 2000
					print(People.Name .. " got 2000")
				end
			end
		end
	
	end)
	end

	-- Determinate the player and there MCV's/ Extra cash when an ally dies.
	Trigger.AfterDelay(DateTime.Seconds(5), function()
		BaseTopLeft = Map.ActorsInCircle(Map.CenterOfCell(CPos.New(28,12)),WDist.FromCells(7),function(a)
			return a.Type == "fact2" end)
		BaseBotLeft = Map.ActorsInCircle(Map.CenterOfCell(CPos.New(28,118)),WDist.FromCells(7),function(a)
			return a.Type == "fact2" end)
		BaseTopMid = Map.ActorsInCircle(Map.CenterOfCell(CPos.New(64,12)),WDist.FromCells(7),function(a)
			return a.Type == "fact2" end)
		BaseBotMid = Map.ActorsInCircle(Map.CenterOfCell(CPos.New(64,118)),WDist.FromCells(7),function(a)
			return a.Type == "fact2" end)
		BaseTopRight = Map.ActorsInCircle(Map.CenterOfCell(CPos.New(100,12)),WDist.FromCells(7),function(a)
			return a.Type == "fact2" end)
		BaseBotRight = Map.ActorsInCircle(Map.CenterOfCell(CPos.New(100,118)),WDist.FromCells(7),function(a)
			return a.Type == "fact2" end)
		if BaseTopLeft[1] ~= nil then
			BaseTopLeft = BaseTopLeft[1]
			Trigger.OnKilled(BaseTopLeft, function() 
				Units = Map.ActorsInBox(Map.TopLeft, Map.BottomRight, function(a)
					return a.Owner == BaseTopLeft.Owner
				end) --Player.GetPlayer("Neutral"
				for e,f in ipairs(Units) do
					if f.Type == "tmplnew" or f.Type == "missnew" or f.Type == "fixtech" then
						f.Owner = Player.GetPlayer("Neutral")
					elseif not f.IsDead then
						f.Kill()
					end
				end
				if BaseTopMid ~= nil and not BaseTopMid.IsDead and BaseTopMid.Type == "fact2" then
					local loc = BaseTopMid.Location + CVec.New(1,2)
					Actor.Create("extracash",true,{Owner = BaseTopMid.Owner,Location = loc, Facing = 0})
				end
				if BaseTopRight ~= nil and not BaseTopRight.IsDead and BaseTopRight.Type == "fact2" then
					local loc = BaseTopRight.Location + CVec.New(1,2)
					Actor.Create("extracash",true,{Owner = BaseTopRight.Owner,Location = loc, Facing = 0})
				end
			end)
		end
		if BaseBotLeft[1] ~= nil then
			BaseBotLeft = BaseBotLeft[1]
			Trigger.OnKilled(BaseBotLeft, function() 
				Units = Map.ActorsInBox(Map.TopLeft, Map.BottomRight, function(a)
					return a.Owner == BaseBotLeft.Owner
				end)
				for e,f in ipairs(Units) do
					if f.Type == "tmplnew" or f.Type == "missnew" or f.Type == "fixtech" then
						f.Owner = Player.GetPlayer("Neutral")
					elseif not f.IsDead then
						f.Kill()
					end
				end
				if BaseBotMid ~= nil and not BaseBotMid.IsDead and BaseBotMid.Type == "fact2" then
					local loc = BaseBotMid.Location + CVec.New(1,2)
					Actor.Create("extracash",true,{Owner = BaseBotMid.Owner,Location = loc, Facing = 0})
				end
				if BaseBotRight ~= nil and not BaseBotRight.IsDead and BaseBotRight.Type == "fact2" then
					local loc = BaseBotRight.Location + CVec.New(1,2)
					Actor.Create("extracash",true,{Owner = BaseBotRight.Owner,Location = loc, Facing = 0})
				end
			end)
		end
		if BaseTopMid[1] ~= nil then
			BaseTopMid = BaseTopMid[1]
			Trigger.OnKilled(BaseTopMid, function() 
				Units = Map.ActorsInBox(Map.TopLeft, Map.BottomRight, function(a)
					return a.Owner == BaseTopMid.Owner
				end)
				for e,f in ipairs(Units) do
					if f.Type == "tmplnew" or f.Type == "missnew" or f.Type == "fixtech" then
						f.Owner = Player.GetPlayer("Neutral")
					elseif not f.IsDead then
						f.Kill()
					end
				end
				if BaseTopLeft ~= nil and not BaseTopLeft.IsDead and BaseTopLeft.Type == "fact2" then
					local loc = BaseTopLeft.Location + CVec.New(0,2)
					Actor.Create("extracash",true,{Owner = BaseTopLeft.Owner,Location = loc, Facing = 0})
				end
				if BaseTopRight ~= nil and not BaseTopRight.IsDead and BaseTopRight.Type == "fact2" then
					local loc = BaseTopRight.Location + CVec.New(0,2)
					Actor.Create("extracash",true,{Owner = BaseTopRight.Owner,Location = loc, Facing = 0})
				end
			end)
		end
		if BaseBotMid[1] ~= nil then
			BaseBotMid = BaseBotMid[1]
			Trigger.OnKilled(BaseBotMid, function() 
				Units = Map.ActorsInBox(Map.TopLeft, Map.BottomRight, function(a)
					return a.Owner == BaseBotMid.Owner
				end)
				for e,f in ipairs(Units) do
					if f.Type == "tmplnew" or f.Type == "missnew" or f.Type == "fixtech" then
						f.Owner = Player.GetPlayer("Neutral")
					elseif not f.IsDead then
						f.Kill()
					end
				end
				if BaseBotLeft ~= nil and not BaseBotLeft.IsDead and BaseBotLeft.Type == "fact2"  then
					local loc = BaseBotLeft.Location + CVec.New(0,2)
					Actor.Create("extracash",true,{Owner = BaseBotLeft.Owner,Location = loc, Facing = 0})
				end
				if BaseBotRight ~= nil and not BaseBotRight.IsDead and BaseBotRight.Type == "fact2"  then
					local loc = BaseBotRight.Location + CVec.New(0,2)
					Actor.Create("extracash",true,{Owner = BaseBotRight.Owner,Location = loc, Facing = 0})
				end
			end)
		end
		if BaseTopRight[1] ~= nil then
			BaseTopRight = BaseTopRight[1]
			Trigger.OnKilled(BaseTopRight, function() 
				Units = Map.ActorsInBox(Map.TopLeft, Map.BottomRight, function(a)
					return a.Owner == BaseTopRight.Owner
				end)
				for e,f in ipairs(Units) do
					if f.Type == "tmplnew" or f.Type == "missnew" or f.Type == "fixtech" then
						f.Owner = Player.GetPlayer("Neutral")
					elseif not f.IsDead then
						f.Kill()
					end
				end
				if BaseTopLeft ~= nil and not BaseTopLeft.IsDead and BaseTopLeft.Type == "fact2" then
					local loc = BaseTopLeft.Location + CVec.New(2,2)
					Actor.Create("extracash",true,{Owner = BaseTopLeft.Owner,Location = loc, Facing = 0})
				end
				if BaseTopMid ~= nil and not BaseTopMid.IsDead and BaseTopMid.Type == "fact2" then
					local loc = BaseTopMid.Location + CVec.New(2,2)
					Actor.Create("extracash",true,{Owner = BaseTopMid.Owner,Location = loc, Facing = 0})
				end
			end)
		end
		if BaseBotRight[1] ~= nil then
			BaseBotRight = BaseBotRight[1]
			Trigger.OnKilled(BaseBotRight, function() 
				Units = Map.ActorsInBox(Map.TopLeft, Map.BottomRight, function(a)
					return a.Owner == BaseBotRight.Owner
				end)
				for e,f in ipairs(Units) do
					if f.Type == "tmplnew" or f.Type == "missnew" or f.Type == "fixtech" then
						f.Owner = Player.GetPlayer("Neutral")
					elseif not f.IsDead then
						f.Kill()
					end
				end
				if BaseBotLeft ~= nil and not BaseBotLeft.IsDead and BaseBotLeft.Type == "fact2" then
					local loc = BaseBotLeft.Location + CVec.New(2,2)
					Actor.Create("extracash",true,{Owner = BaseBotLeft.Owner,Location = loc, Facing = 0})
				end
				if BaseBotMid ~= nil and not BaseBotMid.IsDead and BaseBotMid.Type == "fact2" then
					local loc = BaseBotMid.Location + CVec.New(2,2)
					Actor.Create("extracash",true,{Owner = BaseBotMid.Owner,Location = loc, Facing = 0})
				end
			end)
		end
		
		
		count = true
		Proxy1()
				
		TeamLeft = {BaseTopLeft.Owner, BaseTopMid.Owner, BaseTopRight.Owner}
		TeamRight = {BaseBotLeft.Owner, BaseBotMid.Owner, BaseBotRight.Owner}
		
		Trigger.AfterDelay(DateTime.Seconds(60),ExtraCash)
		Start = true
		--print(tostring(BaseTopLeft.Owner) .. tostring(BaseTopMid.Owner) ..  tostring(BaseTopRight.Owner)) 
	end)

end


Tick = function()
	if Start then 
		Ticker = Ticker +1
		if Ticker >= 125 then
			Ticker = 0
			for i = 1,#TeamLeft do
				if TeamLeft[i] ~= nil and not TeamLeft[i].HasNoRequiredUnits() then
					local mathte = CashValuesLeft[i] + math.floor(TeamLeft[i].Cash/70)
					CashValuesLeft[i] = mathte
					print("From " .. TeamLeft[i].Name .. " -> added: " .. tostring(CashValuesLeft[i]))
				end
			end
			for i = 1,#TeamRight do
				if TeamRight[i] ~= nil and not TeamRight[i].HasNoRequiredUnits() then
					local mathte = CashValuesRight[i] + math.floor(TeamRight[i].Cash/70)
					CashValuesRight[i] = mathte
					print("From " .. TeamRight[i].Name .. " -> added: " .. tostring(CashValuesRight[i]))
				end
			end	
		end
	end
end

-- Units follow thier paths, reach checkpoints
IdleContinue = function(Unit)
	for k,v in pairs(Units_Table) do
		if v == Unit and not Unit.IsDead and Paths_Table[k][1] ~= nil then
			local X = Paths_Table[k][1].X
			local Y = Paths_Table[k][1].Y
			if (Unit.Location.X < X+3 and Unit.Location.X > X-3 ) and (Unit.Location.Y < Y+3 and Unit.Location.Y > Y-3 ) then					
				table.remove(Paths_Table[k],1)
			end
			if Paths_Table[k][1] ~= nil then
				local RandIntA = Utils.RandomInteger(-2,3)
				local RandIntB = Utils.RandomInteger(-2,3)
				if not Actor.CruiseAltitude(Unit.Type) == 0 then
					local RandIntA = Utils.RandomInteger(-3,4)
					local RandIntB = Utils.RandomInteger(-3,4)
				end
				Paths_Table[k][1] = Paths_Table[k][1] + CVec.New(RandIntA,RandIntB)
				Unit.AttackMove(Paths_Table[k][1],3)
			end
		elseif v == Unit and not Unit.IsDead and Paths_Table[k][1] == nil then
			Unit.Destroy()
		end
	end
end

-- removing paths of the tables when an unit dies
KilledUnit = function(Unit,self,killer)
	for k,v in ipairs(Units_Table) do
		if v == Unit then
			table.remove(Paths_Table,k)
			table.remove(Units_Table,k)
		end
	end
	OwnerKilled = self.Owner
	OwnerKiller = killer.Owner
	if OwnerKiller.HasPrerequisites({"cash3"}) and not OwnerKilled.IsAlliedWith(OwnerKiller) then		
		local cashgrant = Values[QueueUnitsIndex[Unit.Type]]
		Media.FloatingText("+" .. tostring(cashgrant) .. "$", self.CenterPosition + WVec.New(0,-100,0), 20, OwnerKiller.Color)
		OwnerKiller.Cash = OwnerKiller.Cash + cashgrant
		local Bounty = Map.ActorsInBox(Map.TopLeft, Map.BottomRight, function(C)
			return C.Owner == OwnerKiller and (C.Type == "cash3" or C.Type == "cash3t2" or C.Type == "cash3t3" or C.Type == "cash3t4" or C.Type == "cash3t5" or C.Type == "cash3t6" or C.Type == "cash3t7" or C.Type == "cash3t8" or C.Type == "cash3t9" or C.Type == "cash3t10" or C.Type == "cash3t11" or C.Type == "cash3t12" or C.Type == "cash3t13" or C.Type == "cash3t14" or C.Type == "cash3t15" or C.Type == "cash3t16")
		end)
		Media.FloatingText("+" .. tostring(cashgrant) .. "$", Bounty[1].CenterPosition + WVec.New(0,-100,0), 20, OwnerKilled.Color)

	end
end

-- Unit movement depending where they spawn
MovementTrigger = function(Unit)

	local RandIntA = Utils.RandomInteger(-2,3)
	local RandIntB = Utils.RandomInteger(-2,3)
	
	if not Actor.CruiseAltitude(Unit.Type) == 0 then
		local RandIntA = Utils.RandomInteger(-3,4)
		local RandIntB = Utils.RandomInteger(-3,4)
	end

	local	PathTopL1={CPos.New(32,26) + CVec.New(RandIntA,RandIntB),CPos.New(32,65),CPos.New(32,104),CPos.New(28,118)}
	local	PathTopL2={CPos.New(38,26) + CVec.New(RandIntA,RandIntB),CPos.New(38,46),CPos.New(45,46),CPos.New(64,65),CPos.New(64,118)}
	local	PathTopL3={CPos.New(38,26) + CVec.New(RandIntA,RandIntB),CPos.New(38,46),CPos.New(45,46),CPos.New(64,65),CPos.New(67,68),CPos.New(83,84),CPos.New(90,84),CPos.New(100,118)}

	local	PathTopM1={CPos.New(64,26) + CVec.New(RandIntA,RandIntB),CPos.New(64,65),CPos.New(64,104),CPos.New(64,118)}
	local	PathTopM2={CPos.New(64,26) + CVec.New(RandIntA,RandIntB),CPos.New(64,65),CPos.New(45,84),CPos.New(38,84),CPos.New(38,104),CPos.New(28,118)}
	local	PathTopM3={CPos.New(64,26) + CVec.New(RandIntA,RandIntB),CPos.New(64,65),CPos.New(67,68),CPos.New(83,84),CPos.New(90,84),CPos.New(100,118)}

	local	PathTopR1={CPos.New(96,26) + CVec.New(RandIntA,RandIntB),CPos.New(96,63),CPos.New(96,104),CPos.New(100,118)}
	local	PathTopR2={CPos.New(90,26) + CVec.New(RandIntA,RandIntB),CPos.New(90,46),CPos.New(83,46),CPos.New(64,65),CPos.New(64,118)}
	local	PathTopR3={CPos.New(90,26) + CVec.New(RandIntA,RandIntB),CPos.New(90,46),CPos.New(83,46),CPos.New(64,65),CPos.New(45,84),CPos.New(38,84),CPos.New(38,104),CPos.New(28,118)}
		
	local	PathBotL1={CPos.New(32,104) + CVec.New(RandIntA,RandIntB),CPos.New(32,65),CPos.New(32,26),CPos.New(28,12)}
	local	PathBotL2={CPos.New(38,104) + CVec.New(RandIntA,RandIntB),CPos.New(38,84),CPos.New(45,84),CPos.New(64,65),CPos.New(64,12)}
	local	PathBotL3={CPos.New(38,104) + CVec.New(RandIntA,RandIntB),CPos.New(38,84),CPos.New(45,84),CPos.New(64,65),CPos.New(83,46),CPos.New(90,46),CPos.New(90,26),CPos.New(100,12)}

	local	PathBotM1={CPos.New(64,104) + CVec.New(RandIntA,RandIntB),CPos.New(64,65),CPos.New(64,26),CPos.New(64,12)}
	local	PathBotM2={CPos.New(64,104) + CVec.New(RandIntA,RandIntB),CPos.New(64,65),CPos.New(46,46),CPos.New(38,46),CPos.New(38,26),CPos.New(28,12)}
	local	PathBotM3={CPos.New(64,104) + CVec.New(RandIntA,RandIntB),CPos.New(64,65),CPos.New(83,46),CPos.New(90,46),CPos.New(90,26),CPos.New(100,12)}

	local	PathBotR1={CPos.New(96,104) + CVec.New(RandIntA,RandIntB),CPos.New(96,63),CPos.New(96,26),CPos.New(100,12)}
	local	PathBotR2={CPos.New(90,104) + CVec.New(RandIntA,RandIntB),CPos.New(90,84),CPos.New(83,84),CPos.New(64,65),CPos.New(64,12)}
	local	PathBotR3={CPos.New(90,104) + CVec.New(RandIntA,RandIntB),CPos.New(90,84),CPos.New(83,84),CPos.New(64,65),CPos.New(46,46),CPos.New(38,46),CPos.New(38,26),CPos.New(28,12)}
	
	
	-- Movement Top Left
	if Unit.Location.Y < 64 and Unit.Location.X < 46 and not Unit.IsDead then
		MovementTopLeft(PathTopL1, PathTopL2, PathTopL3, Unit)
	-- Movement Bottom Left
	elseif Unit.Location.Y > 64 and Unit.Location.X < 46  and not Unit.IsDead then
		MovementBottomLeft(PathBotL1, PathBotL2, PathBotL3, Unit)
	-- Movement Top Mid
	elseif Unit.Location.Y < 64 and Unit.Location.X > 49 and Unit.Location.X < 81 and not Unit.IsDead then
		MovementTopMid(PathTopM1, PathTopM2, PathTopM3, Unit)	
	-- Movement Bottom Mid
	elseif Unit.Location.Y > 64 and Unit.Location.X > 49 and Unit.Location.X < 81 and not Unit.IsDead then
		MovementBottomMid(PathBotM1, PathBotM2, PathBotM3, Unit)	
	-- Movement Top Right
	elseif Unit.Location.Y < 64 and Unit.Location.X > 84 and not Unit.IsDead then
		MovementTopRight(PathTopR1, PathTopR2, PathTopR3, Unit)	
	-- Movement Top Right
	elseif Unit.Location.Y > 64 and Unit.Location.X > 84 and not Unit.IsDead then
		MovementBottomRight(PathBotR1, PathBotR2, PathBotR3, Unit)	
	end
	
end

-- Movement Top Left	
MovementTopLeft = function(PathTopL1, PathTopL2, PathTopL3, Unit)
		local Rndm = Utils.RandomInteger(1,3)
			if Unit.Location.X < 22 then
				table.remove(PathTopL1,1)
				table.remove(PathTopL2,1)
				table.remove(PathTopL3,1)
				table.remove(PathTopL1,1)
				table.remove(PathTopL2,1)
				table.remove(PathTopL3,1)
				
				table.insert(PathTopL1,1,CPos.New(17,26))
				table.insert(PathTopL1,2,CPos.New(17,59))
				table.insert(PathTopL1,3,CPos.New(9,65))
				table.insert(PathTopL1,4,CPos.New(17,72))
				table.insert(PathTopL1,5,CPos.New(17,82))
				table.insert(PathTopL1,6,CPos.New(32,84))
				
				table.insert(PathTopL2,1,CPos.New(17,26))
				table.insert(PathTopL2,2,CPos.New(17,59))
				table.insert(PathTopL2,3,CPos.New(9,65))
				table.insert(PathTopL2,4,CPos.New(17,59))
				table.insert(PathTopL2,5,CPos.New(17,49))
				
				table.insert(PathTopL3,1,CPos.New(17,26))
				table.insert(PathTopL3,2,CPos.New(17,59))		
				table.insert(PathTopL3,3,CPos.New(9,65))
				table.insert(PathTopL3,4,CPos.New(17,59))
				table.insert(PathTopL3,5,CPos.New(17,49))
			elseif Unit.Location.X > 37 and BaseBotMid ~= nil and not BaseBotMid.IsDead and BaseBotMid.Type == "fact2" then
				PathTopL1=PathTopL2
			elseif Unit.Location.X > 37 and BaseBotRight ~= nil and not BaseBotRight.IsDead and BaseBotRight.Type == "fact2" then
				PathTopL1=PathTopL3
				PathTopL2=PathTopL3
			end
			
		if BaseBotLeft.Type == "fact2" and BaseBotLeft ~= nil and not BaseBotLeft.IsDead then
		
			table.insert(Paths_Table,1,PathTopL1)
			table.insert(Units_Table,1,Unit)
			
			Unit.AttackMove(PathTopL1[1],3)
			Trigger.OnIdle(Unit,function() IdleContinue(Unit) end)
			Trigger.OnKilled(Unit, function(self,killer) KilledUnit(Unit,self,killer) end)
			
		elseif BaseBotMid.Type == "fact2" and BaseBotMid ~= nil and not BaseBotMid.IsDead and (Rndm == 1 or BaseBotRight.IsDead or BaseBotRight == nil or BaseBotRight.Type ~= "fact2") then
			table.insert(Paths_Table,1,PathTopL2)
			table.insert(Units_Table,1,Unit)
			
			Unit.AttackMove(PathTopL2[1],3)
			Trigger.OnIdle(Unit,function() IdleContinue(Unit) end)
			Trigger.OnKilled(Unit, function(self,killer) KilledUnit(Unit,self,killer) end)
			
		elseif BaseBotRight.Type == "fact2" and BaseBotRight ~= nil and not BaseBotRight.IsDead then
			table.insert(Paths_Table,1,PathTopL3)
			table.insert(Units_Table,1,Unit)
			
			Unit.AttackMove(PathTopL3[1],3)
			Trigger.OnIdle(Unit,function() IdleContinue(Unit) end)
			Trigger.OnKilled(Unit, function(self,killer) KilledUnit(Unit,self,killer) end)
			
		end
end
	
		-- Movement Bottom Left
MovementBottomLeft = function(PathBotL1, PathBotL2, PathBotL3, Unit)
		local Rndm = Utils.RandomInteger(1,3)
			if Unit.Location.X < 21 then
				table.remove(PathBotL1,1)
				table.remove(PathBotL2,1)
				table.remove(PathBotL3,1)
				table.remove(PathBotL1,1)
				table.remove(PathBotL2,1)
				table.remove(PathBotL3,1)
				
				table.insert(PathBotL1,1,CPos.New(17,104))
				table.insert(PathBotL1,2,CPos.New(17,72))
				table.insert(PathBotL1,3,CPos.New(9,65))
				table.insert(PathBotL1,4,CPos.New(17,59))
				table.insert(PathBotL1,5,CPos.New(17,49))
				table.insert(PathBotL1,6,CPos.New(32,46))
				
				table.insert(PathBotL2,1,CPos.New(17,104))
				table.insert(PathBotL2,2,CPos.New(17,72))
				table.insert(PathBotL2,3,CPos.New(9,65))
				table.insert(PathBotL2,4,CPos.New(17,72))
				table.insert(PathBotL2,5,CPos.New(17,82))
				
				table.insert(PathBotL3,1,CPos.New(17,104))
				table.insert(PathBotL3,2,CPos.New(17,72))
				table.insert(PathBotL3,3,CPos.New(9,65))
				table.insert(PathBotL3,4,CPos.New(17,72))
				table.insert(PathBotL3,5,CPos.New(17,82))
			elseif Unit.Location.X > 37 and BaseTopMid ~= nil and not BaseTopMid.IsDead and BaseTopMid.Type == "fact2"  then
				PathBotL1=PathBotL2
			elseif Unit.Location.X > 37 and BaseTopRight ~= nil and not BaseTopRight.IsDead and BaseTopRight.Type == "fact2"  then
				PathBotL1=PathBotL3
				PathBotL2=PathBotL3
			end
		if BaseTopLeft.Type == "fact2" and BaseTopLeft ~= nil and not BaseTopLeft.IsDead then
		
			table.insert(Paths_Table,1,PathBotL1)
			table.insert(Units_Table,1,Unit)
			
			Unit.AttackMove(PathBotL1[1],3)
			Trigger.OnIdle(Unit,function() IdleContinue(Unit) end)
			Trigger.OnKilled(Unit, function(self,killer) KilledUnit(Unit,self,killer) end)
			
		elseif BaseTopMid.Type == "fact2" and BaseTopMid ~= nil and not BaseTopMid.IsDead and (Rndm == 1 or BaseTopRight.IsDead or BaseTopRight == nil or BaseTopRight.Type ~= "fact2") then
		
			table.insert(Paths_Table,1,PathBotL2)
			table.insert(Units_Table,1,Unit)
			
			Unit.AttackMove(PathBotL2[1],3)
			Trigger.OnIdle(Unit,function() IdleContinue(Unit) end)
			Trigger.OnKilled(Unit, function(self,killer) KilledUnit(Unit,self,killer) end)
			
		elseif BaseTopRight.Type == "fact2" and BaseTopRight ~= nil and not BaseTopRight.IsDead then
		
			table.insert(Paths_Table,1,PathBotL3)
			table.insert(Units_Table,1,Unit)
			
			Unit.AttackMove(PathBotL3[1],3)
			Trigger.OnIdle(Unit,function() IdleContinue(Unit) end)
			Trigger.OnKilled(Unit, function(self,killer) KilledUnit(Unit,self,killer) end)
			
		end	
	end
	
		-- Movement Middle Up
	
MovementTopMid = function(PathTopM1, PathTopM2, PathTopM3, Unit)	
		local Rndm = Utils.RandomInteger(1,3)
		if BaseBotMid.Type == "fact2" and BaseBotMid ~= nil and not BaseBotMid.IsDead then
			table.insert(Paths_Table,1,PathTopM1)
			table.insert(Units_Table,1,Unit)
			
			Unit.AttackMove(PathTopM1[1],3)
			Trigger.OnIdle(Unit,function() IdleContinue(Unit) end)
			Trigger.OnKilled(Unit, function(self,killer) KilledUnit(Unit,self,killer) end)
			
		elseif BaseBotLeft.Type == "fact2" and BaseBotLeft ~= nil and not BaseBotLeft.IsDead and (Rndm == 1 or BaseBotRight.IsDead or BaseBotRight == nil or BaseBotRight.Type ~= "fact2") then
			table.insert(Paths_Table,1,PathTopM2)
			table.insert(Units_Table,1,Unit)
			
			Unit.AttackMove(PathTopM2[1],3)
			Trigger.OnIdle(Unit,function() IdleContinue(Unit) end)
			Trigger.OnKilled(Unit, function(self,killer) KilledUnit(Unit,self,killer) end)
			
		elseif BaseBotRight.Type == "fact2" and BaseBotRight ~= nil and not BaseBotRight.IsDead then
			table.insert(Paths_Table,1,PathTopM3)
			table.insert(Units_Table,1,Unit)
			
			Unit.AttackMove(PathTopM3[1],3)
			Trigger.OnIdle(Unit,function() IdleContinue(Unit) end)
			Trigger.OnKilled(Unit, function(self,killer) KilledUnit(Unit,self,killer) end)
			
		end	
	end
	
	
			-- Movement Middle Bottom
MovementBottomMid = function(PathBotM1, PathBotM2, PathBotM3, Unit)	
		local Rndm = Utils.RandomInteger(1,3)
		if BaseTopMid.Type == "fact2" and BaseTopMid ~= nil and not BaseTopMid.IsDead then
			table.insert(Paths_Table,1,PathBotM1)
			table.insert(Units_Table,1,Unit)
			
			Unit.AttackMove(PathBotM1[1],3)
			Trigger.OnIdle(Unit,function() IdleContinue(Unit) end)
			Trigger.OnKilled(Unit, function(self,killer) KilledUnit(Unit,self,killer) end)
			
		elseif BaseTopLeft.Type == "fact2" and BaseTopLeft ~= nil and not BaseTopLeft.IsDead and (Rndm == 1 or BaseTopRight.IsDead or BaseTopRight == nil or BaseTopRight.Type ~= "fact2") then
			table.insert(Paths_Table,1,PathBotM2)
			table.insert(Units_Table,1,Unit)
			
			Unit.AttackMove(PathBotM2[1],3)
			Trigger.OnIdle(Unit,function() IdleContinue(Unit) end)
			Trigger.OnKilled(Unit, function(self,killer) KilledUnit(Unit,self,killer) end)
			
		elseif BaseTopRight.Type == "fact2" and BaseTopRight ~= nil and not BaseTopRight.IsDead then
			table.insert(Paths_Table,1,PathBotM3)
			table.insert(Units_Table,1,Unit)
			
			Unit.AttackMove(PathBotM3[1],3)
			Trigger.OnIdle(Unit,function() IdleContinue(Unit) end)
			Trigger.OnKilled(Unit, function(self,killer) KilledUnit(Unit,self,killer) end)
			
		end
	end
	
	
			-- Movement Top Right
MovementTopRight = function(PathTopR1, PathTopR2, PathTopR3, Unit)	
		local Rndm = Utils.RandomInteger(1,3)
			if Unit.Location.X > 106 then
			
				table.remove(PathTopR1,1)
				table.remove(PathTopR2,1)
				table.remove(PathTopR3,1)
				table.remove(PathTopR1,1)
				table.remove(PathTopR2,1)
				table.remove(PathTopR3,1)
				
				table.insert(PathTopR1,1,CPos.New(110,26))
				table.insert(PathTopR1,2,CPos.New(110,58))
				table.insert(PathTopR1,3,CPos.New(118,64))
				table.insert(PathTopR1,4,CPos.New(110,71))
				table.insert(PathTopR1,5,CPos.New(110,82))
				table.insert(PathTopR1,6,CPos.New(96,84))
				
				table.insert(PathTopR2,1,CPos.New(110,26))
				table.insert(PathTopR2,2,CPos.New(110,58))
				table.insert(PathTopR2,3,CPos.New(118,64))
				table.insert(PathTopR2,4,CPos.New(110,58))
				table.insert(PathTopR2,5,CPos.New(110,49))
				
				table.insert(PathTopR3,1,CPos.New(110,26))
				table.insert(PathTopR3,2,CPos.New(110,58))
				table.insert(PathTopR3,3,CPos.New(118,64))
				table.insert(PathTopR3,4,CPos.New(110,58))
				table.insert(PathTopR3,5,CPos.New(110,49))
			
			elseif Unit.Location.X < 91 and BaseBotMid ~= nil and not BaseBotMid.IsDead and BaseBotMid.Type == "fact2"  then
				PathTopR1=PathTopR2
			elseif Unit.Location.X < 91 and BaseBotLeft ~= nil and not BaseBotLeft.IsDead and BaseBotLeft.Type == "fact2"  then
				PathTopR1=PathTopR3
				PathTopR2=PathTopR3
			end
		if BaseBotRight.Type == "fact2" and BaseBotRight ~= nil and not BaseBotRight.IsDead then
			table.insert(Paths_Table,1,PathTopR1)
			table.insert(Units_Table,1,Unit)
			
			Unit.AttackMove(PathTopR1[1],3)
			Trigger.OnIdle(Unit,function() IdleContinue(Unit) end)
			Trigger.OnKilled(Unit, function(self,killer) KilledUnit(Unit,self,killer) end)
			
		elseif BaseBotMid.Type == "fact2" and BaseBotMid ~= nil and not BaseBotMid.IsDead and (Rndm == 1 or BaseBotLeft.IsDead or BaseBotLeft == nil or BaseBotLeft.Type ~= "fact2") then
			table.insert(Paths_Table,1,PathTopR2)
			table.insert(Units_Table,1,Unit)
			
			Unit.AttackMove(PathTopR2[1],3)
			Trigger.OnIdle(Unit,function() IdleContinue(Unit) end)
			Trigger.OnKilled(Unit, function(self,killer) KilledUnit(Unit,self,killer) end)
			
		elseif BaseBotLeft.Type == "fact2" and BaseBotLeft ~= nil and not BaseBotLeft.IsDead then
			table.insert(Paths_Table,1,PathTopR3)
			table.insert(Units_Table,1,Unit)
			
			Unit.AttackMove(PathTopR3[1],3)
			Trigger.OnIdle(Unit,function() IdleContinue(Unit) end)
			Trigger.OnKilled(Unit, function(self,killer) KilledUnit(Unit,self,killer) end)
			
		end
	end
	
				-- Movement Bottom Right
MovementBottomRight = function(PathBotR1, PathBotR2, PathBotR3, Unit)	
		local Rndm = Utils.RandomInteger(1,3)
			if Unit.Location.X > 106 then
			
				table.remove(PathBotR1,1)
				table.remove(PathBotR2,1)
				table.remove(PathBotR3,1)
				table.remove(PathBotR1,1)
				table.remove(PathBotR2,1)
				table.remove(PathBotR3,1)
				
				table.insert(PathBotR1,1,CPos.New(110,104))
				table.insert(PathBotR1,2,CPos.New(110,71))
				table.insert(PathBotR1,3,CPos.New(118,64))
				table.insert(PathBotR1,4,CPos.New(110,58))
				table.insert(PathBotR1,5,CPos.New(110,49))
				table.insert(PathBotR1,6,CPos.New(96,46))
				
				table.insert(PathBotR2,1,CPos.New(110,104))
				table.insert(PathBotR2,2,CPos.New(110,71))
				table.insert(PathBotR2,3,CPos.New(118,64))
				table.insert(PathBotR2,4,CPos.New(110,71))
				table.insert(PathBotR2,5,CPos.New(110,82))
				
				table.insert(PathBotR3,1,CPos.New(110,104))
				table.insert(PathBotR3,2,CPos.New(110,71))
				table.insert(PathBotR3,3,CPos.New(118,64))
				table.insert(PathBotR3,4,CPos.New(110,71))
				table.insert(PathBotR3,5,CPos.New(110,82))
			elseif Unit.Location.X < 91 and BaseTopMid ~= nil and not BaseTopMid.IsDead and BaseTopMid.Type == "fact2" then
				PathBotR1=PathBotR2
			elseif Unit.Location.X < 91 and BaseTopLeft ~= nil and not BaseTopLeft.IsDead and BaseTopLeft.Type == "fact2" then
				PathBotR1=PathBotR3
				PathBotR2=PathBotR3
			end
			
		if BaseTopRight.Type == "fact2" and BaseTopRight ~= nil and not BaseTopRight.IsDead then
			table.insert(Paths_Table,1,PathBotR1)
			table.insert(Units_Table,1,Unit)
			
			Unit.AttackMove(PathBotR1[1],3)
			Trigger.OnIdle(Unit,function() IdleContinue(Unit) end)
			Trigger.OnKilled(Unit, function(self,killer) KilledUnit(Unit,self,killer) end)
			
		elseif BaseTopMid.Type == "fact2" and BaseTopMid ~= nil and not BaseTopMid.IsDead and (Rndm == 1 or BaseTopLeft.IsDead or BaseTopLeft == nil or BaseTopLeft.Type ~= "fact2") then
			table.insert(Paths_Table,1,PathBotR2)
			table.insert(Units_Table,1,Unit)
			
			Unit.AttackMove(PathBotR2[1],3)
			Trigger.OnIdle(Unit,function() IdleContinue(Unit) end)
			Trigger.OnKilled(Unit, function(self,killer) KilledUnit(Unit,self,killer) end)
			
		elseif BaseTopLeft.Type == "fact2" and BaseTopLeft ~= nil and not BaseTopLeft.IsDead then
			table.insert(Paths_Table,1,PathBotR3)
			table.insert(Units_Table,1,Unit)
			
			Unit.AttackMove(PathBotR3[1],3)
			Trigger.OnIdle(Unit,function() IdleContinue(Unit) end)
			Trigger.OnKilled(Unit, function(self,killer) KilledUnit(Unit,self,killer) end)
			
		end
	end

