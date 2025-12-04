---@meta _
-- globals we define are private to our plugin!
---@diagnostic disable: lowercase-global

-- Choose the next room (layout, boons, etc.)
modutil.mod.Path.Wrap("ChooseNextRoomData", function(base, ...)
	local forcedRoom = generateForcedNextRoomData(...)
	if forcedRoom ~= nil then
		return forcedRoom
	else
		return base(...)
	end
end)

-- Choose the starting room (intro/opening)
modutil.mod.Path.Wrap("ChooseStartingRoom", function(base, ...)
	return generateForcedOpeningRoom(...)
end)

-- Choose the Room Rewards
modutil.mod.Path.Wrap("ChooseRoomReward", function(base, run, room, rewardStoreName, previouslyChosenRewards, args)
	-- Room generation in Fields is specific. It calls this method once for the door with the args "Door", then again for each "cage" rewards without the arg
	-- The first call should not generate the actual reward to account for this
	local setRewardIsGenerated = true
	if args and args.Door then
		setRewardIsGenerated = false
	end

	local forcedRewards = getForcedRoomRewards(run, room, setRewardIsGenerated)
	if forcedRewards then
		if args then
			args.ForcedRewards = forcedRewards
		end
		room.Reward = forcedRewards[1].Name
		room.ForceLootName = forcedRewards[1].LootName
		room.RewardOverrides = nil

		return forcedRewards[1].Name
	end

	return base(run, room, rewardStoreName, previouslyChosenRewards, args)
end)

-- Generate the encounter
modutil.mod.Path.Wrap("ChooseEncounter", function(base, currentRun, room, args)
	local forcedEncounterData = generateForcedEncounterData(currentRun, room, args)

	if forcedEncounterData ~= nil then
		local encounter = game.SetupEncounter(forcedEncounterData, room)
		return encounter
	else
		return base(currentRun, room, args)
	end
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
	MyStartRoom(...)

	return base(...)
end)

-- Force loading map binaries based on their original name
modutil.mod.Path.Wrap("LoadMap", function(base, argTable)
	local baseRoomName = _getRoomBaseName(argTable.Name)
	if baseRoomName then
		argTable.Name = baseRoomName
	end

	return base(argTable)
end)

-- Populate the rooms
modutil.mod.Path.Wrap("RunStateInit", function(base)
	base()

	MyRunStateInit()
end)

-- Devotion rewards handling. (This game function is only used for spawning Devotion reward)
modutil.mod.Path.Wrap("GetInteractedGodThisRun", function(base, ignoredGod)
	local forcedDevotionGod = getForcedDevotionGod(ignoredGod)

	if forcedDevotionGod then
		return forcedDevotionGod
	end

	return base(ignoredGod)
end)

-- Fields multiple rewards door 
modutil.mod.Path.Wrap("SelectFieldsDoorCageCount", function(base, run, room)
	local forcedFieldsRewardCount = getForcedFieldsRewardCount(room)

	if forcedFieldsRewardCount then
		return forcedFieldsRewardCount
	end

	return base(run, room)
end)

--
modutil.mod.Path.Wrap("HandleEnemySpawns", function(base, encounter)
	MyHandleEnemySpawns(encounter)

	return base(encounter)
end)

-- Cage rewards (Fields) spawn location
modutil.mod.Path.Wrap("SpawnRewardCages", function(base, room, args)
	MySpawnRewardCages(room, args)
end)


--------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------

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

-- Force Random Boon sack
modutil.mod.Path.Wrap("UnwrapRandomLoot", function(base, source)
	return MyUnwrapRandomLoot(source)
end)

-- Force Siren spotlight
modutil.mod.Path.Wrap("ApplyScyllaFightSpotlight", function(base, scylla, args)
	return MyApplyScyllaFightSpotlight(scylla, args)
end)