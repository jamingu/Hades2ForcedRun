---@meta _
-- globals we define are private to our plugin!
---@diagnostic disable: lowercase-global

-- Choose the next room (layout, boons, etc.)
modutil.mod.Path.Wrap("ChooseNextRoomData", function(base, ...)
	local forcedRoom = generateForcedRoom(...)
	if forcedRoom ~= nil then
		return forcedRoom
	else
		return base(...)
	end
end)

-- Choose the Room Rewards
modutil.mod.Path.Wrap("ChooseRoomReward", function(base, run, room, rewardStoreName, previouslyChosenRewards, args)
	local forcedRoomRewards = getForcedRoomRewards(run, room)

	if forcedRoomRewards then
		args.ForcedRewards = forcedRoomRewards
	end

	return base(run, room, rewardStoreName, previouslyChosenRewards, args)
end)

-- Choose the encounter waves, parameters must be passed instead of '...' otherwise it bugs for the opening room
modutil.mod.Path.Wrap("ChooseEncounter", function(base, currentRun, room, args)
	local forcedEncounterData = generateForcedEncounterData(currentRun, room, args)

	if forcedEncounterData ~= nil then
		local encounter = SetupEncounter(forcedEncounterData, room)
		return encounter
	else
		return base(currentRun, room, args)
	end
end)

-- Choose the starting room (intro/opening)
modutil.mod.Path.Wrap("ChooseStartingRoom", function(base, ...)
	return generateForcedStartingRoom(...)
end)

-- Force the traits offered in the boon list
modutil.mod.Path.Wrap("SetTraitsOnLoot", function(base, lootData, args)
	local isForced = generateForcedRewardTraits(lootData, args)

	if isForced then
		return
	else
		return base(lootData, args)
	end
end)

-- Force the shop options
modutil.mod.Path.Wrap("FillInShopOptions", function(base, args)
	local forcedShopOptions = generateForcedShopOptions(args)

	if forcedShopOptions ~= nil then
		return { StoreOptions = forcedShopOptions}
	else
		return base(args)
	end
end)

-- Room start
modutil.mod.Path.Wrap("StartRoom", function(base, ...)
	forcedStartRoom(...)

	return base(...)
end)


----------------------------------------------
----------------------------------------------
-------------------------------------------------

-- Force spawn positions
modutil.mod.Path.Wrap("SelectSpawnPoint", function(base, ...)
	return MySelectSpawnPoint(...)
end)

-- Force next spawns
modutil.mod.Path.Wrap("GetNextSpawn", function(base, ...)
	return MyGetNextSpawn(...)
end)

-- Force webs room cocoon reward 
modutil.mod.Path.Wrap("SetupArachneCombatEncounter", function(base, ...)
	return MySetupArachneCombatEncounter(...)
end)

-- Force cocoons positions
modutil.mod.Path.Wrap("SpawnArachneCocoons", function(base, ...)
	local isForced = MySpawnArachneCocoons(...)
	if isForced then
		return
	else
		return base(...)
	end
end)

-- Arachne costume choice
modutil.mod.Path.Wrap("ArachneCostumeChoice", function(base, ...)
	local isForced = MyArachneCostumeChoice(...)
	if isForced then
		return
	else
		return base(...)
	end
end)

-- Force gold pots count
modutil.mod.Path.Wrap("HandleBreakableSwap", function(base, ...)
	return MyHandleBreakableSwap(...)
end)