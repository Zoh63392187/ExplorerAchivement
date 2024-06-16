local mq = require('mq')

local function AchCompletedStatus(ps)  
	if mq.TLO.Achievement(ps).Completed() == true then
		return true
	else 
		return false
	end
end

local function portOut()
	print('Porting out')
	mq.delay(5000)
	::Loop::
	local tmpZoneID = mq.TLO.Zone.ID()
	mq.cmd("/keypress forward")
	if mq.TLO.Me.AltAbilityReady("Gate")() then
		mq.cmd('/alt activate 1217')
	elseif mq.TLO.Me.ItemReady("Drunkard's Stein")() then
		mq.cmd("/useitem Drunkard's Stein")
	elseif mq.TLO.Me.AltAbilityReady("Origin")() then
		mq.cmd('/alt activate 331')
	elseif mq.TLO.Me.AltAbilityReady("Throne of Heroes")() then
		mq.cmd('/alt activate 511')
	elseif mq.TLO.Me.ItemReady("Philter of Major Translocation")() then
		mq.cmd("/useitem Philter of Major Translocation")	
	else 
		print('No port ready. Checking in 1 minutes again')
		mq.delay(60000)	
		goto Loop
	end
	mq.delay(2000)
	while mq.TLO.Me.Casting() or mq.TLO.Me.Zoning() do
		mq.delay(500)
	end
	if tmpZoneID == mq.TLO.Zone.ID() then
	 print('Gate failed - retrying!')
	 goto Loop
	end
end

local function setPortal(dis)  
	mq.cmd('/target zeflmin werlikanin')
	mq.cmd('/nav spawn npc zeflmin werlikanin')
	while mq.TLO.Navigation.Active() do
		mq.delay(500)
	end
	mq.cmd('/click right target')
	mq.delay(2000)
	mq.cmd('/portalsetter '..dis)
	mq.delay(15000)

	mq.cmd('/nav loc -23 -131 5')
	while mq.TLO.Navigation.Active() do
		mq.delay(500)
	end
	mq.delay(10000)
	mq.cmd('/notify largedialogwindow LDW_YesButton leftmouseup')
	mq.delay(2000)
	while mq.TLO.Navigation.Active() or mq.TLO.Me.Zoning() do
		mq.delay(500)
	end
end

local function fixS()  
	if mq.TLO.Me.Class.ShortName()=='BRD' and not mq.TLO.Me.Buff("Selo's Accelerando")() and not mq.TLO.Me.Buff("Selo's Accelerato")() and mq.TLO.Me.Level() >= 105 then
			mq.cmd("/alt act 3704")
		end
	if mq.TLO.Zone.ID() == 181 and mq.TLO.Math.Distance(-586,2784,6)() <= 30 then
		mq.cmd('/doortarget id 28')mq.delay(500)mq.cmd('/click left door')
	end
end


local function TravelTo(dis)
	mq.cmd("/travelto "..dis)
	mq.delay(500)
	while mq.TLO.Zone.ShortName() ~= dis do
		mq.delay(500)
		fixS()
	end
	print("Travel to "..mq.TLO.Zone.Name().." done!")
end

local function navLoc(loc)
	mq.cmd("/nav loc "..loc)
	mq.delay(500)
	while mq.TLO.Navigation.Active() or mq.TLO.Me.Zoning() do
		mq.delay(500)
	end
end

local function navTar(tar)
	mq.cmd("/nav target")
	mq.delay(500)
	while mq.TLO.Navigation.Active() do
		mq.delay(500)
	end
end

if (mq.TLO.Plugin("mq2boxr").IsLoaded() == false) then
	mq.cmd('/plugin boxr load')
	print('Plugin boxr loaded!')
	mq.delay(500)
end

-- Check Guild membership
-- Check plat for port

if not mq.TLO.Me.Buff("Group Perfected Levitation")() then
	mq.cmd("/beep")
	mq.cmd("/beep")
	print('\arError: You need to have Group Perfected Levitation')
	goto EndScript
end

if not mq.TLO.Me.Guild() then
	mq.cmd("/beep")
	mq.cmd("/beep")
	print('\arError: You need to be in a guild as we need access to small guildhall for port')
	goto EndScript
end

mq.cmd('/boxr pause')
print('If you break navigation it will skip target destination')

-- Faydwer Explorer
TravelTo("steamfontmts")
TravelTo("akanon")
TravelTo("mistmoore")
TravelTo("crushbone")
TravelTo("felwitheb")
TravelTo("unrest")
TravelTo("cauldron")
navLoc("-911 -1046 -344")
TravelTo("kedge")
TravelTo("kaladimb")
TravelTo("oceanoftears")
TravelTo("poknowledge")

-- Northeast Antonica Explorer
TravelTo("najena")
TravelTo("soldungb")
TravelTo("soldungc")
TravelTo("soltemple")
TravelTo("neriakd")
TravelTo("commonlands")
TravelTo("freeporteast")
navLoc("-1882 -1735 0")
mq.cmd("/face heading 360")
mq.delay(2000)
mq.cmd("/keypress forward hold")
mq.delay(5000)
mq.cmd("/keypress forward")
TravelTo("freeporteast")
TravelTo("befallen")
TravelTo("highkeep")
TravelTo("beholder")
TravelTo("rivervale")
TravelTo("poknowledge")

-- Northwest Antonica Explorer
TravelTo("everfrost")
TravelTo("halas")
TravelTo("permafrost")
TravelTo("blackburrow")
TravelTo("qeynos")
navLoc("-148 -594 -22")
mq.cmd("/face heading 270")
mq.delay(2000)
mq.cmd("/keypress forward hold")
mq.delay(5000)
mq.cmd("/keypress back hold")
mq.delay(5000)
mq.cmd("/keypress back")i
TravelTo("eastkarana")
TravelTo("qrg")
TravelTo("nedaria")
TravelTo("poknowledge")

-- Odus Explorer
TravelTo("toxxulia")
TravelTo("erudnext")
navLoc("-1405 -254 -42")
mq.cmd("/face heading 360")
mq.delay(2000)
mq.cmd("/keypress forward hold")
mq.delay(1000)
mq.cmd("/keypress forward")
TravelTo("erudnint")
TravelTo("erudnext")
navLoc("-644 -250 69")
mq.cmd("/face heading 270")
mq.delay(2000)
mq.cmd("/keypress forward hold")
mq.delay(1000)
mq.cmd("/keypress forward")
TravelTo("erudsxing")

TravelTo("erudnext")
navLoc("-349 -8 41")
mq.cmd("/face heading 360")
mq.delay(2000)
mq.cmd("/keypress forward hold")
mq.delay(1000)
mq.cmd("/keypress forward")
mq.cmd("/face heading 360")
mq.delay(2000)
mq.cmd("/keypress forward hold")
mq.delay(1000)
mq.cmd("/keypress forward")
TravelTo("paineel")
navLoc("604 -859 -80")
navLoc("593 -942 -93")
mq.cmd("/keypress forward")
mq.cmd("/face heading 360")
mq.delay(2000)
mq.cmd("/keypress forward hold")
mq.delay(1000)
mq.cmd("/keypress forward")
TravelTo("stonebrunt")
TravelTo("poknowledge")

-- Southeast Antonica Explorer
TravelTo("innothuleb")
TravelTo("grobb")
TravelTo("guktop")
TravelTo("gukbottom")
TravelTo("innothuleb")
TravelTo("northro")
TravelTo("poknowledge")

-- Southwest Antonica Explorer
TravelTo("rathemtn")
TravelTo("paw")
TravelTo("arena")
TravelTo("oggok")
TravelTo("cazicthule")
TravelTo("poknowledge")

-- The Plane Explorer
TravelTo("fearplane")
TravelTo("guildhall")
setPortal("hateplane")
portOut()

TravelTo("guildhall")
setPortal("airplane")
mq.cmd("/face heading 360")
mq.delay(2000)
mq.cmd("/keypress forward hold")
mq.delay(10000)
mq.cmd("/keypress forward")
TravelTo("freeporteast")
TravelTo("poknowledge")

--print(AchCompletedStatus('West Freeport Traveler'))
-- myAch(curAch.ID).Objective(hunterSpawn).Completed()

::EndScript::