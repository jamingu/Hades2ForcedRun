---@meta _
-- globals we define are private to our plugin!
---@diagnostic disable: lowercase-global
-- this file will be reloaded if it changes during gameplay, so only assign to values or define things here.

------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------

-- @finish foolish run:
-- handle Fields then the rest
-- Handle Tartarus
-- when redoing a compelte run, check that the ending postboss room actually stop the timer


-- @later:
-- Put Artemis/Athena traits in a more global scope since they can happen in multiple biome/room
-- Improve fields reward/encounter pairing, as currently they are not directly linked to each other
-- only load once the runparameters in RoomData
-- unrandomise gathering spots and location
-- unrandomise location pot of gold
-- unrandomise enemies gold on death
-- unrandomise cocoons content except the reward (ennemy, explode, money)
-- Nyx apperance in chaos (via Empty_Chaos GameRequirements)
-- Forced Devotion Gods
-- In oceanus, unrandomise hidden doors reward after clearing a wave
-- Handle every Chaos curse/bless
-- unrandomise the purging altar in inter-biome
-- unrandomise random pom affected boon
-- handle that taking a Chaos in the fields does not advance the run position
-- Handle surface runs
-- Selene spells order/moon phase

-- "Global" variables to handle the position in the run
local GlobalIsPopulatedRooms
local GlobalCurrentBiomeName
local GlobalRoomDepth
local GlobalRoomNumber
local GlobalRoomEncounterDepth

--Force the generation of the Opening room
function generateForcedOpeningRoom(currentRun, args)
	--@todo handle not F starting Biome
	local startingBiomeName = 'I'
	local startingRoomData = game.RoomData[startingBiomeName .. '_1_1']

	local startingRoom = game.CreateRoom(startingRoomData, args)
	return startingRoom
end

function generateForcedNextRoomData(currentRun, args, otherDoors)
	if currentRun and currentRun.CurrentRoom then
		local currentRoomName = currentRun.CurrentRoom.Name
		local keys = _getParametersKeysFromName(currentRoomName)

		-- If the current room is the Biome ending room, go to the next biome
		if currentRun.CurrentRoom.IsEndBiome then
			local nextBiomeRoom = game.RoomData[_getRoomName(_getNextBiomeName(keys.BiomeName),'1','1')]
			if nextBiomeRoom then
				return nextBiomeRoom
			end
		end
						
		-- Specific case for Chaos room generation
		if args and args.ForceNextRoomSet and args.ForceNextRoomSet == 'Chaos' then
			local cpt = 1
			while game.RoomData[_getRoomName('Chaos', 1, cpt)] do
				local roomName = _getRoomName('Chaos', 1, cpt)

				local room = game.RoomData[roomName]
				if not room.IsGenerated then
					room.IsGenerated = true
					return room
				end

				cpt = cpt+1
			end
		else
			-- Specific case if in a Chaos room when trying to generate the next room
			local biomeName
			local nextRoomDepth
			if keys.BiomeName == 'Chaos' then
				biomeName = GlobalCurrentBiomeName
				nextRoomDepth = currentRun.BiomeDepthCache + 1
			else
				biomeName = keys.BiomeName
				-- Retrieve the next non-generated room at one depth below
				nextRoomDepth = keys.RoomDepth+1
			end

			local cpt = 1
			while game.RoomData[_getRoomName(biomeName, nextRoomDepth, cpt)] do
				local roomName = _getRoomName(biomeName, nextRoomDepth, cpt)

				local room = game.RoomData[roomName]
				if not room.IsGenerated then
					room.IsGenerated = true
					return room
				end

				cpt = cpt+1
			end
		end

		rom.log.warning('WARNING => generateForcedNextRoomData Return nil for roomName : ' .. currentRoomName)

		-- Return nil to let the game generate a room
		return nil
	end
end

function generateForcedShopOptions(args)
	local shopOptions = nil

	if game.CurrentRun and game.CurrentRun.CurrentRoom then
		local currentRoom = game.CurrentRun.CurrentRoom

		if currentRoom then
			if currentRoom.ShopContent then
				shopOptions = {}
				for k, shopContent in pairs(currentRoom.ShopContent) do
					-- For information, order of shop appearance seems weird (2,3,1)
					local shopOption

					if shopContent.BoonGod == 'Hermes' then
						local money = 150
						if shopContent.Reward == 'BoostedBoon' then
							money = 500
						end

						shopOption = {
							Name = 'ShopHermesUpgrade',
							Type = 'Consumable',
							ResourceCosts = { Money = money }
						}
					elseif shopContent.Reward == 'Boon' or shopContent.Reward == 'BoostedBoon' then
						local money
						local name

						if shopContent.Reward == 'BoostedBoon' then
							name = 'BoostedRandomLoot'
							money = 450
						else
							name = 'RandomLoot'
							money = 150
						end

						local tmpArgs = {
							ForceLootName = shopContent.BoonGod .. 'Upgrade',
							BoughtFromShop = true,
							DoesNotBlockExit = true,
							ResourceCosts = { Money = money }
						}

						shopOption = {
							Name = name,
							Type = 'Boon',
							Args = tmpArgs,
						}
					elseif shopContent.Reward == 'Hammer' then
						shopOption = {
							Name = 'WeaponUpgradeDrop',
							Type = 'Consumable',
						}
					elseif shopContent.Reward == 'RandomPom' then
						shopOption = {
							Name = 'StoreRewardRandomStack',
							Type = 'Consumable',
							CostOverride = 50
						}
					elseif shopContent.Reward == 'HealDropMajor' then
						shopOption = {
							Name = 'HealDropMajor',
							Type = 'Consumable',
							CostOverride = 50
						}
					elseif shopContent.Reward == 'RandomBoon' then
						shopOption = {
							Name = 'BlindBoxLoot',
							Type = 'Consumable',
							ForceLootName = shopContent.BoonGod .. 'Upgrade',
						}
						
					elseif shopContent.Reward == 'WeaponPointsRareDrop' then
						shopOption = {
							Name = 'WeaponPointsRareDrop',
							Type = 'Consumable',
							CostOverride = 1300
						}
					else
						shopOption = {
							Name = shopContent.Reward,
							Type = 'Consumable'
						}
					end

					table.insert(shopOptions, shopOption)
				end
			elseif currentRoom.WellContent and currentRoom.WellContent[1] then
				wellContentOptions = table.remove(currentRoom.WellContent, 1)
				shopOptions = {}
				for k, wellContentOption in pairs(wellContentOptions) do
					local shopOption = {
						Name = wellContentOption.Name,
						Type = wellContentOption.Type
					}
					table.insert(shopOptions, shopOption)
				end
			end
		end
	end

	return shopOptions
end

function generateForcedEncounterData(currentRun, room, args)
	local encounterName
	if room.ForcedEncounterName then
		encounterName = room.ForcedEncounterName
	elseif room.Encounter and room.Encounter.Name then
		encounterName = room.Encounter.Name
	end

	-- Auto generate default encounters based on the room
	if room.IsCombat and not room.ForcedEncounterName then
		-- Specific case for Fields. The room itself does not contain any room.Encounter (only the cage rewards)
		-- so we affect the encounter based on the room (as they are the same)
		-- @todo improve this as this quite clunky
		if room.RoomSetName == 'H' then
			if room.Encounter and string.find(room.Encounter.Name, 'GeneratedH_Passive') then
				encounterName = 'Generated' .. room.RoomSetName
			elseif room.LegalEncounters[1] then
				encounterName = room.LegalEncounters[1] -- GeneratedH_Passive(Small)
			end
		else
			encounterName = 'Generated' .. room.RoomSetName
		end
	end

	-- If there is forced encounters, generate the encounter with specific spawns and waves
	if room.ForcedEncounters then
		local createdEncounterData

		for k,encounter in pairs(room.ForcedEncounters) do
			if not encounter.IsGenerated  then
				encounter.IsGenerated = true

				if encounter.SpawnWaves ~= nil  then
					local createdSpawnWaves = {}
					local waveCount = 0
					for spawnWaveKey, spawnWaveValues in pairs(encounter.SpawnWaves) do
						-- init
						createdSpawnWaves[spawnWaveKey] = {
							Spawns = {},
							SpawnOrder = spawnWaveValues.SpawnOrder
						}

						waveCount = waveCount + 1

						for spawnValueKey, spawnValue in pairs(spawnWaveValues.Spawns) do
							createdSpawnWaves[spawnWaveKey].Spawns[spawnValueKey] = {
								Name = spawnValue.Name,
								CountMin = spawnValue.Count,
								CountMax = spawnValue.Count,
								SpawnOnIdKeys = spawnValue.SpawnOnIdKeys,
							}
						end
					end

					createdEncounterData = game.DeepCopyTable(game.EncounterData[encounterName])
					createdEncounterData.SpawnWaves = createdSpawnWaves
					createdEncounterData.MinWaves = waveCount
					createdEncounterData.MaxWaves = waveCount

					local averageSpawnInterval = (createdEncounterData.SpawnIntervalMax + createdEncounterData.SpawnIntervalMin)/2
					createdEncounterData.SpawnIntervalMin = averageSpawnInterval
					createdEncounterData.SpawnIntervalMax = averageSpawnInterval
				end
				
				break
			end
		end

		return createdEncounterData
	elseif encounterName then
		-- A specific encounter name is set, but no ForcedEncounter, return a copy of the room enconter
		local createdEncounterData
		createdEncounterData = game.DeepCopyTable(game.EncounterData[encounterName])
		return createdEncounterData
	end

	if room.IsShop then
		-- Handle Nemesis spawn in shop. Must be set in the global variable as it is the one accessed in StartRoom and not the encounterData itself
		for k, event in pairs(game.EncounterData['Shop'].StartRoomUnthreadedEvents) do
			if event.FunctionName == 'CheckNemesisShoppingEvent' then
				if room.IsNemesisForced then
					game.EncounterData['Shop'].StartRoomUnthreadedEvents[k].GameStateRequirements.ChanceToPlay = 1
				else
					game.EncounterData['Shop'].StartRoomUnthreadedEvents[k].GameStateRequirements.ChanceToPlay = 0
				end

				break
			end
		end
	end
end

function generateForcedRewardTraits(lootData, args)
	local upgradeOptions = nil

	if lootData.GodLoot or (lootData.SpeakerName and lootData.SpeakerName == 'Hermes') or (lootData.SpeakerName and lootData.SpeakerName == 'Athena') then
		upgradeOptions = generateForcedBoonRewardTraits(lootData)
	elseif lootData.Name == 'WeaponUpgrade' then
		upgradeOptions = generateForcedHammerRewardTraits()
	elseif lootData.SpeakerName == 'Artemis' then
		upgradeOptions = generateForcedBoonRewardTraits(lootData)
	elseif lootData.Name == 'TrialUpgrade' then
		upgradeOptions = generateForcedChaosTraits()
	elseif lootData.Name == 'StackUpgrade' then
		upgradeOptions = generateForcedStackUpgradeRewardTraits(lootData)
	end

	if upgradeOptions then
		lootData.UpgradeOptions = upgradeOptions
		return true
	else
		return false
	end
end

function generateForcedBoonRewardTraits(lootData)
	local currentRoomParameters = _getParametersRoomFromName(game.CurrentRun.CurrentRoom.Name)

	-- Retrieve the name of the speaking God to concatenate with the boon name
	local speakerName = lootData.SpeakerName
	local forcedTraits = nil

	-- If a BoonTraits parameter exists (room or shop), force it
	if currentRoomParameters then
		if speakerName == 'Artemis' and currentRoomParameters.ArtemisTraits and currentRoomParameters.ArtemisTraits[1] then
			-- Artemis
			forcedTraits = table.remove(currentRoomParameters.ArtemisTraits, 1)
		elseif speakerName == 'Athena' and currentRoomParameters.AthenaTraits and currentRoomParameters.AthenaTraits[1] then
			-- Athena
			forcedTraits = table.remove(currentRoomParameters.AthenaTraits, 1)
		elseif currentRoomParameters.Rewards then
			-- Room Boon reward
			for k,reward in pairs(currentRoomParameters.Rewards) do
				-- Return the traits of the first matching god in the list (or the first if "Any" is specified in the parameters to handle first room keepsakes AND Echo)
				-- @todo: better handle god keepsakes to be used any Biome in the run
				if reward.Traits and (reward.BoonGod == speakerName or reward.BoonGod == 'Any') then
					forcedTraits = table.remove(currentRoomParameters.Rewards[k].Traits, 1)
					break
				end
			end
		elseif currentRoomParameters.ShopContent then
			-- Shop option
			for k, shopElement in pairs(currentRoomParameters.ShopContent) do
				-- Regular Boon
				if (shopElement.Reward == 'Boon' or shopElement.Reward == 'BoostedBoon') and shopElement.BoonGod == speakerName then
					if currentRoomParameters.ShopContent[k].Traits and currentRoomParameters.ShopContent[k].Traits[1] then
						forcedTraits = table.remove(currentRoomParameters.ShopContent[k].Traits, 1)
						break
					end
				end

				-- Random Boon
				if shopElement.Reward == 'RandomBoon' and shopElement.BoonGod == speakerName then
					if currentRoomParameters.ShopContent[k].Traits and currentRoomParameters.ShopContent[k].Traits[1] then
						forcedTraits = table.remove(currentRoomParameters.ShopContent[k].Traits, 1)
						break
					end
				end
			end
		end
	end

	if forcedTraits ~= nil then
		local upgradeOptions = {}
		for k, trait in pairs(forcedTraits) do
			local itemName = trait.Name
			-- AttackBoon is named WeaponBoon in the game files
			if itemName == 'Attack' then
				itemName = 'Weapon'
			end

			if not string.find(itemName, "Boon")  then
				itemName = itemName .. 'Boon'
			end

			-- Concatenate the god name for "WeapongUpgrades": attack/special/cast/sprint/mana
			if game.LootSetData[speakerName] and game.LootSetData[speakerName][speakerName .. 'Upgrade'] and game.LootSetData[speakerName][speakerName .. 'Upgrade'].WeaponUpgrades then
				for _, weapongUpgrade in pairs(game.LootSetData[speakerName][speakerName .. 'Upgrade'].WeaponUpgrades) do
					if weapongUpgrade == speakerName .. itemName then
						itemName = speakerName .. itemName
						break
					end
				end
			end

			table.insert(upgradeOptions, {
				Type = 'Trait',
				ItemName = itemName,
				Rarity = trait.Rarity
			})
		end

		return upgradeOptions
	end
end

function generateForcedHammerRewardTraits()
	local currentRoom = _getParametersRoomFromName(game.CurrentRun.CurrentRoom.Name)

	local forcedTraits = nil
	-- If a BoonTraits parameter exists (room or shop), force it
	if currentRoom and currentRoom.Traits then
		-- Standard Room reward
		forcedTraits = currentRoom.Traits
	elseif currentRoom and currentRoom.ShopContent then
		-- Shop option
		for k, shopElement in pairs(currentRoom.ShopContent) do
			if shopElement.Reward == 'Hammer' then
				if currentRoom.ShopContent[k].Traits then
					forcedTraits = currentRoom.ShopContent[k].Traits
					break
				end
			end
		end
	end

	if forcedTraits ~= nil then
		local upgradeOptions = {}
		for k, trait in pairs(forcedTraits) do
			table.insert(upgradeOptions, {
				Type = 'WeaponUpgrade',
				ItemName = trait,
			})
		end

		return upgradeOptions
	end
end

function generateForcedChaosTraits()
	local currentRoom = _getParametersRoomFromName(game.CurrentRun.CurrentRoom.Name)

	local forcedTraits = nil
	if currentRoom and currentRoom.Traits then
		forcedTraits = table.remove(currentRoom.Traits, 1)
	end

	if forcedTraits ~= nil then
		local upgradeOptions = {}
		for k, trait in pairs(forcedTraits) do
			if trait.BlessingName == 'Attack' then
				trait.BlessingName = 'Weapon'
			end

			local blessingName = 'Chaos' .. trait.BlessingName .. 'Blessing'
			local curseName = 'Chaos' .. trait.CurseName .. 'Curse'
			table.insert(upgradeOptions, {
				Type = 'TransformingTrait',
				ItemName = blessingName,
				Rarity = trait.Rarity,
				SecondaryItemName = curseName
			})

			-- Also set the blessing/curse values and duration in the global variables
			-- @todo: handle every blessing/curse + handle reverting the modification after, because those values are set in stone for the whole run (eg: rerolling keeps the values )

			-- Blessings values
			if blessingName == 'ChaosWeaponBlessing' then
				game.TraitSetData.Chaos[blessingName].AddOutgoingDamageModifiers.ValidWeaponMultiplier.BaseMin = tonumber(trait.BlessingValue)
				game.TraitSetData.Chaos[blessingName].AddOutgoingDamageModifiers.ValidWeaponMultiplier.BaseMax =game. TraitSetData.Chaos[blessingName].AddOutgoingDamageModifiers.ValidWeaponMultiplier.BaseMin
			elseif blessingName == 'ChaosManaBlessing' then
				game.TraitSetData.Chaos[blessingName].PropertyChanges[1].BaseMin = tonumber(trait.BlessingValue)
				game.TraitSetData.Chaos[blessingName].PropertyChanges[1].BaseMax = game.TraitSetData.Chaos[blessingName].PropertyChanges[1].BaseMin
			elseif blessingName == 'ChaosCastBlessing' then
				game.TraitSetData.Chaos[blessingName].AddOutgoingDamageModifiers.ValidWeaponMultiplier.BaseMin = tonumber(trait.BlessingValue)
				game.TraitSetData.Chaos[blessingName].AddOutgoingDamageModifiers.ValidWeaponMultiplier.BaseMax = game.TraitSetData.Chaos[blessingName].AddOutgoingDamageModifiers.ValidWeaponMultiplier.BaseMin
			end

			-- Curses values and duration
			if curseName == 'ChaosSecondaryAttackCurse' then
				game.TraitSetData.Chaos[curseName].DamageOnFireWeapons.Damage.BaseMin = trait.CurseValue
				game.TraitSetData.Chaos[curseName].DamageOnFireWeapons.Damage.BaseMax = game.TraitSetData.Chaos[curseName].DamageOnFireWeapons.Damage.BaseMin
			end

			-- Duration
			game.TraitSetData.Chaos[curseName].RemainingUses.BaseMin = trait.Duration
			game.TraitSetData.Chaos[curseName].RemainingUses.BaseMax = game.TraitSetData.Chaos[curseName].RemainingUses.BaseMin
		end

		return upgradeOptions
	end
end

function generateForcedStackUpgradeRewardTraits(lootData)
	-- @todo: improve this: handle non existing boons like no attack, only propose boons the User has, etc.
	local currentRoomParameters = _getParametersRoomFromName(game.CurrentRun.CurrentRoom.Name)

	local forcedTraits = nil
	if currentRoomParameters and currentRoomParameters.Rewards then
		for k,reward in pairs(currentRoomParameters.Rewards) do
			if reward.Traits then
				forcedTraits = table.remove(currentRoomParameters.Rewards[k].Traits, 1)
				break
			end
		end
	end

	if forcedTraits ~= nil then
		local upgradeOptions = {}
		for _, trait in pairs(forcedTraits) do			
			table.insert(upgradeOptions, {
				Type = 'Trait',
				ItemName = trait.Name,
			})
		end

		return upgradeOptions
	end
end

function MyHandleEncounterPreSpawns(encounter)
	-- Unrandomise Dyonisus keepsake encounter skip
	local sourceTrait = game.HasHeroTraitValue("SkipEncounterChance")

	if sourceTrait then
		-- Set the skip chance to 0 by default, but if the fig is forced for the encounter number
		sourceTrait.SkipEncounterChance = 0

		if encounter.CanEncounterSkip then
			local roomParameters = _getParametersRoomFromName(game.CurrentRun.CurrentRoom.Name)
			if roomParameters then
				if roomParameters.ForceFigSkipEncounterNumber == GlobalRoomEncounterDepth then
					sourceTrait.SkipEncounterChance = 1
				end
			end
		end
	end
end

function MyHandleEnemySpawns(encounter)
	-- Unrandomise Dyonisus keepsake encounter skip. Dublon of MyHandleEncounterPreSpawns because preSpawn is not always called
	local sourceTrait = game.HasHeroTraitValue("SkipEncounterChance")
	
	if sourceTrait then
		-- Set the skip chance to 0 by default, but if the fig is forced for the encounter number
		sourceTrait.SkipEncounterChance = 0

		if encounter.CanEncounterSkip then
			local roomParameters = _getParametersRoomFromName(game.CurrentRun.CurrentRoom.Name)
			if roomParameters then
				if roomParameters.ForceFigSkipEncounterNumber == GlobalRoomEncounterDepth then
					sourceTrait.SkipEncounterChance = 1
				end
			end
		end
	end

	-- Increment the current encounter depth of the room
	GlobalRoomEncounterDepth = GlobalRoomEncounterDepth + 1
end

function MyStartRoom(currentRun, room)
	local currentRoom = room

	-- Set the "Global" variables of the current position in the run
	local keys = _getParametersKeysFromName(currentRoom.Name)
	if keys.BiomeName ~= 'Chaos' then
		-- Keep the current "real" biomeName
		GlobalCurrentBiomeName = keys.BiomeName
	end
	GlobalRoomDepth = keys.RoomDepth
	GlobalRoomNumber = keys.RoomNumber
	GlobalRoomEncounterDepth = 1

	-- Force well position
	if currentRoom and currentRoom.WellSpawnOnIdKey then
		local challengeBaseIds = game.GetIdsByType({ Name = "ChallengeSwitchBase" })
		if challengeBaseIds[currentRoom.WellSpawnOnIdKey] then
			game.RoomData[currentRoom.Name].WellShopChallengeBaseId = challengeBaseIds[currentRoom.WellSpawnOnIdKey]
		end
	end

	-- Force Boss patterns
	if currentRoom then
		if currentRoom.BossName == 'Hecate' and currentRoom.BossParameter then
			game.UnitSetData[currentRoom.BossName][currentRoom.BossName].AIStages[2].MidPhaseWeapons = { currentRoom.BossParameter }
		elseif currentRoom.BossName == 'Cerberus' and currentRoom.BossParameter then
			game.UnitSetData['InfestedCerberus']['InfestedCerberus'].AIStages[2].RandomSpawnEncounter = { currentRoom.BossParameter }
		end
		--Scylla fight logic is set in MyApplyScyllaFightSpotlight
	end

	-- Force gold pots
	local goldPotsCount = 0
	if currentRoom and currentRoom.GoldPots and currentRoom.GoldPots.Count then
		goldPotsCount = currentRoom.GoldPots.Count
	end
	if currentRoom then
		game.RoomData[currentRoom.Name].BreakableValueOptions = { MaxHighValueBreakables = goldPotsCount }
		game.RoomData[currentRoom.Name].BreakableHighValueChanceMultiplier = 100.0
	end
end

function getForcedRoomRewards(run, room, setRewardIsGenerated)
	-- For Fields "cage" rewards, the room parameter is empty
	local roomParameters
	if room and room.Name then
		roomParameters = _getParametersRoomFromName(room.Name)
	else
		roomParameters = _getParametersRoomFromName(run.CurrentRoom.Name)
	end

	-- Force the reward
	local forcedRewards = nil
	-- Specific case for Echo, allow specifying the "Reward,Reward" boon reward without changing the room itself
	if roomParameters and roomParameters.Rewards and roomParameters.Name ~= 'H_Bridge01' then
		-- Remove the room.ForcedReward key to allow rerolling doors
		room.ForcedReward = nil

		for _, reward in pairs(roomParameters.Rewards) do
			if not reward.IsGenerated then
				-- Ensure the reward is generated only once
				if setRewardIsGenerated then
					reward.IsGenerated = true
				end

				if reward.Name == 'Boon' then
					if reward.BoonGod == 'Selene' then
						forcedRewards = {
							{
								Name = 'SpellDrop',
							},
						}
					else
						forcedRewards = {
							{
								Name = reward.Name,
								LootName = reward.BoonGod .. 'Upgrade',
							}
						}
					end
				elseif reward.Name == 'Hammer' then
					forcedRewards = {
						{
							Name = 'WeaponUpgrade',
						},
					}
				elseif reward.Name == 'Devotion' then
					forcedRewards = {
						{
							Name = 'Devotion',
						},
					}
				elseif reward.Name == 'Pom' then
					forcedRewards = {
						{
							Name = 'StackUpgrade',
						},
					}
				elseif reward.Name then
					forcedRewards = {
						{
							Name = reward.Name,
						},
					}
				end

				break
			end
		end
	end

	return forcedRewards
end

local debugTraitsGiven = true
function MyRunStateInit()
	-- Load every Rooms from the RunParameters, only once
	if not GlobalIsPopulatedRooms then
		for biomeName, biome in pairs(RunParameters.Biomes) do
			for roomDepth, rooms in pairs(biome.Rooms) do
				for roomNumber, room in pairs(rooms) do
					_populateRoomData(biomeName, roomDepth, roomNumber)
				end
			end
		end
		GlobalIsPopulatedRooms = true

		-- Change the requirements for the Chronos appearance when leaving I_Preboss
		_print(game.ObstacleData.ChronosBossDoor.SetupEvents[3])
		game.ObstacleData.ChronosBossDoor.SetupEvents[3].GameStateRequirements[1].Path = { "CurrentRun", "CurrentRoom", "BaseRoomName" }
	end

	-- Force rooms Flip : also check the User not in the Hub (since the game stores CurrentRun as the last run)
	if not game.CurrentHubRoom and game.CurrentRun and game.CurrentRun.CurrentRoom and game.CurrentRun.CurrentRoom.Flipped then
		game.SetConfigOption({ Name = "FlipMapThings", Value = true })
	else
		game.SetConfigOption({ Name = "FlipMapThings", Value = false })
	end

	-- For debugging, add traits
	if not debugTraitsGiven and not game.CurrentHubRoom and game.CurrentRun and game.CurrentRun.CurrentRoom and game.SessionMapState then
		StartingTraits =
		{
			{ Name = "AresWeaponBoon",             Rarity = "Epic", },
			{ Name = "ZeusSpecialBoon",            Rarity = "Epic", },
			{ Name = "ZeusManaBoon",               Rarity = "Epic", },
			{ Name = "AresStatusDoubleDamageBoon", Rarity = "Epic", },
			{ Name = "AloneDamageBoon",            Rarity = "Epic", },
			{ Name = "RendBloodDropBoon",          Rarity = "Epic", },
			{ Name = "FocusLightningBoon",         Rarity = "Epic", },
			{ Name = "BoltRetaliateBoon",          Rarity = "Epic", },
			{ Name = "AloneDamageBoon",            Rarity = "Epic", },
			{ Name = "LuckyBoon",                  Rarity = "Heroic" },
			{ Name = "RoomRewardMaxHealthTrait", },
			{ Name = "RoomRewardMaxHealthTrait", },
			{ Name = "RoomRewardMaxHealthTrait", },
			{ Name = "RoomRewardMaxHealthTrait", },
			{ Name = "RoomRewardMaxHealthTrait", },
			{ Name = "RoomRewardMaxHealthTrait", },
			{ Name = "RoomRewardMaxHealthTrait", },
			{ Name = "RoomRewardMaxHealthTrait", },
			{ Name = "RoomRewardMaxHealthTrait", },
			{ Name = "RoomRewardMaxHealthTrait", },
			{ Name = "RoomRewardMaxHealthTrait", },
			{ Name = "RoomRewardMaxManaTrait", },
			{ Name = "RoomRewardMaxManaTrait", },
			{ Name = "RoomRewardMaxManaTrait", },
			{ Name = "RoomRewardMaxManaTrait", },
			{ Name = "RoomRewardMaxManaTrait", },
			{ Name = "RoomRewardMaxManaTrait", },
		}

		for i, traitData in ipairs(StartingTraits) do
			game.AddTrait(game.CurrentRun.Hero, traitData.Name, traitData.Rarity, { FromLoot = true })
		end
		debugTraitsGiven = true
	end
end

function getForcedDevotionGod(ignoredGod)
	local currentRoomName = game.CurrentRun.CurrentRoom.Name
	local keys = _getParametersKeysFromName(currentRoomName)

	-- Check for a Devotion Reward in each of the next depth Room
	local cpt = 1
	while game.RoomData[_getRoomName(keys.BiomeName, keys.RoomDepth+1, cpt)] do
		local roomName = _getRoomName(keys.BiomeName, keys.RoomDepth+1, cpt)

		local room = game.RoomData[roomName]
		if room.IsDevotion and room.DevotionGodA and room.DevotionGodB then
			-- If no ignored god is given, return the first god
			if not ignoredGod then
				return room.DevotionGodA .. 'Upgrade'
			else
				return room.DevotionGodB .. 'Upgrade'
			end
		end

		cpt = cpt+1
	end

	return nil
end

function getForcedFieldsRewardCount(currentRoom)
	local currentRoomName = currentRoom.Name
	local keys = _getParametersKeysFromName(currentRoomName)

	-- Look for the next reward count
	local cpt = 1
	while game.RoomData[_getRoomName(keys.BiomeName, keys.RoomDepth+1, cpt)] do
		local roomName = _getRoomName(keys.BiomeName, keys.RoomDepth+1, cpt)
		local room = game.RoomData[roomName]

		if room.FieldsRewardsCount then
			return room.FieldsRewardsCount
		end

		cpt = cpt+1
	end

	return nil
end

function _getBiomeName(room)
	return room.RoomSetName
end

function _getNextBiomeName(biomeName)
	if biomeName == 'F' then
		return 'G'
	elseif biomeName == 'G' then
		return 'H'
	elseif biomeName == 'H' then
		return 'I'
	end
end

-- Get the generated RunParameters room name
function _getRoomName(biome, roomDepth, roomNumber)
	return biome .. '_' .. roomDepth .. '_' .. roomNumber
end

-- Get the RunParameters room from it's name
function _getParametersRoomFromName(roomName)
	local keys = _getParametersKeysFromName(roomName)

	if keys.BiomeName and keys.RoomDepth and keys.RoomNumber then
		if RunParameters.Biomes[keys.BiomeName] and RunParameters.Biomes[keys.BiomeName].Rooms[keys.RoomDepth] and RunParameters.Biomes[keys.BiomeName].Rooms[keys.RoomDepth][keys.RoomNumber] then
			return RunParameters.Biomes[keys.BiomeName].Rooms[keys.RoomDepth][keys.RoomNumber]
		end
	end

	return nil
end

function _getParametersKeysFromName(roomName)
	local roomParametersKey = {}
	for token in string.gmatch(roomName, "[^_]+") do
		table.insert(roomParametersKey, token)
	end

	local biomeName = roomParametersKey[1]
	local roomDepth = tonumber(roomParametersKey[2])
	local roomNumber = tonumber(roomParametersKey[3])

	return {
		BiomeName = biomeName,
		RoomDepth = roomDepth,
		RoomNumber = roomNumber
	}
end

-- Return the base/original Name of the generated room
function _getRoomBaseName(roomName)
	local room = _getParametersRoomFromName(roomName)

	if room then
		return room.Name
	else
		rom.log.warning('LoadMap name incorrect, not normal, should maybe generate an error/exception: ' .. roomName)
		return nil
	end
end


-- Populate the room data, should only be called once at initialisation
function _populateRoomData(biomeName, roomDepth, roomNumber)
	local roomParameters = RunParameters.Biomes[biomeName].Rooms[roomDepth][roomNumber]

	-- Create a copy of the base room
	local createdRoomData = game.DeepCopyTable(game.RoomData[roomParameters.Name])

	-- Handle Chaos chance
	if roomParameters.IsForcedChaos then
		createdRoomData.SecretSpawnChance = 1
	else
		createdRoomData.SecretSpawnChance = 0
	end

	-- Handle Well chance
	if roomParameters.IsForcedWell then
		createdRoomData.ForceWellShop = 1
		createdRoomData.WellShopSpawnChance = 1
	else
		createdRoomData.WellShopSpawnChance = 0
	end

	if roomParameters.Rewards and roomParameters.Rewards[1] and  roomParameters.Rewards[1].Name == 'Devotion' then
		createdRoomData.IsDevotion = true
		createdRoomData.DevotionGodA = roomParameters.Rewards[1].GodA
		createdRoomData.DevotionGodB = roomParameters.Rewards[1].GodB
	end

	-- Specific case of Shop
	if string.find(roomParameters.Name, '_Shop') or string.find(roomParameters.Name, '_PreBoss') then
		createdRoomData.IsShop = true
		-- Handle Zagreus contract spawn in shop, set in the global StoreData variable
		if roomParameters.IsZagreusForced then
			game.StoreData.ZagreusContractRequirement.ChanceToPlay = 1
		else
			game.StoreData.ZagreusContractRequirement.ChanceToPlay = 0
		end
	elseif string.find(roomParameters.Name, '_Combat') then
		createdRoomData.IsCombat = true
	elseif string.find(roomParameters.Name, '_Opening') then
		createdRoomData.IsOpening = true
	elseif string.find(roomParameters.Name, '_PostBoss') then
		createdRoomData.IsEndBiome = true
	end

	--Encounters
	createdRoomData.ForcedEncounters = roomParameters.Encounters
	createdRoomData.ForcedEncounterName = roomParameters.Encounter
	if createdRoomData.IsOpening then
		createdRoomData.ForcedEncounterName = 'OpeningGeneratedF'
	end

	-- Set created room parameters
	createdRoomData.IsPopulated = true
	createdRoomData.IsGenerated = false
	createdRoomData.UniqueId = _getRoomName(biomeName, roomDepth, roomNumber)
	createdRoomData.Cocoons = roomParameters.Cocoons
	createdRoomData.GoldPots = roomParameters.GoldPots
	createdRoomData.ShopContent = roomParameters.ShopContent
	createdRoomData.WellContent = roomParameters.WellContent
	createdRoomData.WellSpawnOnIdKey = roomParameters.WellSpawnOnIdKey
	createdRoomData.Flipped = roomParameters.IsFlipped or false

	-- Boss Name/Parameter
	createdRoomData.BossName = roomParameters.BossName
	createdRoomData.BossParameter = roomParameters.BossParameter

	-- The RoomSetName must be set manually a it is not already generated in the base room
	createdRoomData.RoomSetName = biomeName
	createdRoomData.BaseRoomName = createdRoomData.Name

	-- Fields specific
	createdRoomData.FieldsRewardsCount = roomParameters.FieldsRewardsCount

	-- Force the Fields starting point, from the starting points: 621442, 723141, 723145
	-- @todo: improve this to be handled with a key and not the value directly
	if roomParameters.StartPoint then
		createdRoomData.DebugHeroStartPoint = roomParameters.StartPoint 
	end

	-- Set a Unique RoomData name, and add it to the global variables list of rooms
	createdRoomData.Name = createdRoomData.UniqueId
	--rom.log.warning('Room added to RoomData[] ' .. createdRoomData.UniqueId)
	game.RoomData[createdRoomData.UniqueId] = createdRoomData

	return game.RoomData[createdRoomData.UniqueId]
end

function _print(element, recursive)
	rom.log.warning('--- START ---')

	if element then
		for k,v in pairs(element) do
			rom.log.warning('element['..k..']')
			
			if recursive then 
				if type(v) == 'table' then
					for k2,v2 in pairs(v) do
						rom.log.warning('>>> element['..k..']['..k2..']')
						rom.log.warning(v2)
					end
				else
					rom.log.warning(v)
				end
			else
				rom.log.warning(v)
			end
		end
	else
		rom.log.warning('NIL')
	end
	rom.log.warning('--- END ---')
end

function _getSortedCopy(t)
	local new = {}
    for i = 1, #t do
        new[i] = t[i]
    end

    table.sort(new)
    return new
end
--------------------------------------------------------------
--------------------------------------------------------------
--- Core functions modified, check @modified for the modified part
--------------------------------------------------------------
--------------------------------------------------------------
function MyGetNextSpawn(encounter)
	local forcedSpawn = nil
	local remainingSpawnInfo = {}
	local remainingPrioritySpawnInfo = {}
	local remainingPriorityGroupSpawnInfo = {}
	for k, spawnInfo in orderedPairs(encounter.Spawns) do
		if spawnInfo.InfiniteSpawns or spawnInfo.RemainingSpawns > 0 then
			local enemyData = EnemyData[spawnInfo.Name]
			if enemyData ~= nil and enemyData.LargeUnitCap ~= nil and enemyData.LargeUnitCap > 0 then
				local largeUnitCount = 0
				for enemyId, enemy in pairs(ShallowCopyTable(ActiveEnemies)) do
					if enemy.LargeUnitCap ~= nil and enemyData.LargeUnitCap > 0 then
						largeUnitCount = largeUnitCount + 1
					end
				end
				if largeUnitCount < enemyData.LargeUnitCap then
					table.insert(remainingSpawnInfo, spawnInfo)
					if spawnInfo.PrioritySpawn then
						table.insert(remainingPrioritySpawnInfo, spawnInfo)
					end
				else
					DebugPrint({ Text = "Avoiding LargeUnitCap: " .. enemyData.Name })
				end
			else
				table.insert(remainingSpawnInfo, spawnInfo)
				if spawnInfo.PrioritySpawn then
					table.insert(remainingPrioritySpawnInfo, spawnInfo)
				elseif encounter.PrioritizeGroup ~= nil and enemyData ~= nil and Contains(enemyData.Groups, encounter.PrioritizeGroup) then
					table.insert(remainingPriorityGroupSpawnInfo, spawnInfo)
				end
			end

			if spawnInfo.ForceFirst then
				forcedSpawn = spawnInfo
			end
		end
	end

	if forcedSpawn ~= nil then
		return forcedSpawn
	end

	-- @modified Handle forced SpawnOrder
	local randomSpawnInfo = nil
	if encounter.SpawnWaves[encounter.CurrentWaveNum]['SpawnOrder'] and encounter.SpawnWaves[encounter.CurrentWaveNum]['SpawnOrder'][1] then
		-- Pop the array to remove this Spawn from the list
		local spawnName = table.remove(encounter.SpawnWaves[encounter.CurrentWaveNum]['SpawnOrder'], 1)

		local remaining
		if remainingPrioritySpawnInfo[1] then
			remaining = remainingPrioritySpawnInfo
		elseif remainingPriorityGroupSpawnInfo[1] then
			remaining = remainingPriorityGroupSpawnInfo
		else
			remaining = remainingSpawnInfo
		end

		for k, remainingSpawn in pairs(remaining) do
			if remainingSpawn.Name == spawnName then
				randomSpawnInfo = remaining[k]
				break
			end
		end

		if randomSpawnInfo == nil then
			randomSpawnInfo = remainingPrioritySpawnInfo[1] or remainingPriorityGroupSpawnInfo[1] or
			remainingSpawnInfo[1]
		end
	else
		--  @modified Remove randomness
		--local randomSpawnInfo = GetRandomValue( remainingPrioritySpawnInfo ) or GetRandomValue( remainingPriorityGroupSpawnInfo ) or GetRandomValue( remainingSpawnInfo )
		randomSpawnInfo = remainingPrioritySpawnInfo[1] or remainingPriorityGroupSpawnInfo[1] or remainingSpawnInfo[1]
	end

	if encounter.PrioritizeGroup ~= nil then
		local wave = encounter.SpawnWaves[encounter.CurrentWaveNum]
		local remainingPriorityGroupSpawns = 0
		for k, spawnInfo in pairs(remainingPriorityGroupSpawnInfo) do
			remainingPriorityGroupSpawns = remainingPriorityGroupSpawns + spawnInfo.RemainingSpawns
		end
		if remainingPriorityGroupSpawns == 1 then
			wave.SpawnedLastOfPriorityGroup = true
		end
	end

	return randomSpawnInfo
end

function MySelectSpawnPoint(currentRoom, enemy, encounter, args, depth)
	args = args or {}
	enemy = enemy or {}
	encounter = encounter or {}
	depth = (depth or 0) + 1

	if encounter.SpawnOnProximitySpawnTrigger then
		return encounter.ProximitySpawnTriggerId
	end

	-- @modified Handle forced spawn position
	local spawnOnIdKeys = nil
	if encounter.Spawns and encounter.Spawns[enemy.Name] and encounter.Spawns[enemy.Name]['SpawnOnIdKeys'] and encounter.Spawns[enemy.Name]['SpawnOnIdKeys'][1] then
		-- Pop the first value
		spawnOnIdKeys = { table.remove(encounter.Spawns[enemy.Name]['SpawnOnIdKeys'],1) }
	elseif enemy.SpawnOnIdKey then
		-- ArachneCombat forced position
		spawnOnIdKeys = { enemy.SpawnOnIdKey }
	end

	if spawnOnIdKeys then
		local newSpawnPointIds = {}
		local baseMapSpawnPoints = _getSortedCopy(game.MapState.SpawnPoints)

		-- Force the spawn point
		if baseMapSpawnPoints then
			-- Force the enemy placement
			--enemy.PreferredSpawnPoint = nil
			for _, spawnOnIdKey in pairs(spawnOnIdKeys) do
				if spawnOnIdKey and baseMapSpawnPoints[spawnOnIdKey] then
					rom.log.warning((enemy.Name or 'nil enemy') .. ' final => ' .. baseMapSpawnPoints[spawnOnIdKey])
					return baseMapSpawnPoints[spawnOnIdKey]
				end
			end

			shuffledSpawnPointIds = newSpawnPointIds
		end
	end

	local shuffledSpawnPointIds = {}
	local requiredSpawnPointType = args.RequiredSpawnPoint or enemy.RequiredSpawnPoint or encounter.RequiredSpawnPoint
	if requiredSpawnPointType ~= nil then
		if currentRoom.SpawnPoints[requiredSpawnPointType] == nil then
			local ids = GetIdsByType({ Name = requiredSpawnPointType })
			table.sort(ids)
			currentRoom.SpawnPoints[requiredSpawnPointType] = ShallowCopyTable(ids)
		end
		shuffledSpawnPointIds = FYShuffle(currentRoom.SpawnPoints[requiredSpawnPointType] or MapState.SpawnPoints)
	elseif args.CycleSpawnPoints then
		if IsEmpty(MapState.CyclingSpawnPoints) then
			MapState.CyclingSpawnPoints = FYShuffle(MapState.SpawnPoints)
		end
		shuffledSpawnPointIds = MapState.CyclingSpawnPoints
	elseif args.PreferredSpawnPointGroup then
		shuffledSpawnPointIds = FYShuffle(GetIds({ Name = args.PreferredSpawnPointGroup }))
	elseif args.PreferredSpawnPoint then
		local ids = GetIdsByType({ Name = args.PreferredSpawnPoint })
		table.sort(ids)
		shuffledSpawnPointIds = FYShuffle(ids)
	elseif enemy.PreferredSpawnPoint ~= nil then
		if currentRoom.SpawnPoints[enemy.PreferredSpawnPoint] == nil then
			currentRoom.SpawnPoints[enemy.PreferredSpawnPoint] = ShallowCopyTable( GetIdsByType({ Name = enemy.PreferredSpawnPoint }) )
		end
		shuffledSpawnPointIds = FYShuffle( currentRoom.SpawnPoints[enemy.PreferredSpawnPoint] or MapState.SpawnPoints )
	else
		shuffledSpawnPointIds = FYShuffle( encounter.NearbySpawnPoints or MapState.SpawnPoints )
	end

	args.SpawnAwayFromTypes = args.SpawnAwayFromTypes or enemy.SpawnAwayFromTypes
	args.SpawnAwayFromTypesDistance = args.SpawnAwayFromTypesDistance or enemy.SpawnAwayFromTypesDistance
	args.SpawnCloseToGroup = args.SpawnCloseToGroup or enemy.SpawnCloseToGroup

	for k, id in ipairs(shuffledSpawnPointIds) do
		if IsSpawnPointEligible(id, encounter, currentRoom, args) then
			if args.CycleSpawnPoints then
				RemoveValueAndCollapse(MapState.CyclingSpawnPoints, id)
			end

			return id
		end
	end

	-- Nothing eligible
	if args.SpawnCloseToGroup ~= nil then
		args.SpawnCloseToGroup = nil
		enemy.SpawnCloseToGroup = nil
		wait(args.RecursiveWait)
		local id = SelectSpawnPoint(currentRoom, enemy, encounter, args, depth)
		return id
	end
	if args.PreferredSpawnPointGroup ~= nil then
		args.PreferredSpawnPointGroup = nil
		wait(args.RecursiveWait)
		local id = SelectSpawnPoint(currentRoom, enemy, encounter, args, depth)
		return id
	end
	if args.PreferredSpawnPoint ~= nil then
		args.PreferredSpawnPoint = nil
		wait(args.RecursiveWait)
		local id = SelectSpawnPoint(currentRoom, enemy, encounter, args, depth)
		return id
	end
	if enemy.PreferredSpawnPoint ~= nil then
		enemy.PreferredSpawnPoint = nil
		wait(args.RecursiveWait)
		local id = SelectSpawnPoint(currentRoom, enemy, encounter, args, depth)
		return id
	end

	if args.RequireMinEndPointDistance ~= nil and args.RequireMinEndPointDistance > 100 then
		args.RequireMinEndPointDistance = args.RequireMinEndPointDistance * 0.5
		wait(args.RecursiveWait)
		local id = SelectSpawnPoint(currentRoom, enemy, encounter, args, depth)
		return id
	end

	if encounter.RequireNearPlayerDistance ~= nil and encounter.RequireNearPlayerDistance < 50000 then
		encounter.RequireNearPlayerDistance = encounter.RequireNearPlayerDistance * 1.5
		wait(args.RecursiveWait)
		local id = SelectSpawnPoint(currentRoom, enemy, encounter, args, depth)
		return id
	end

	if encounter.RequireMinPlayerDistance ~= nil and encounter.RequireMinPlayerDistance > 100 then
		encounter.RequireMinPlayerDistance = encounter.RequireMinPlayerDistance * 0.5
		wait(args.RecursiveWait)
		local id = SelectSpawnPoint(currentRoom, enemy, encounter, args, depth)
		return id
	end

	if encounter.MinPlayerArc ~= nil then
		encounter.MinPlayerArc = nil
		wait(args.RecursiveWait)
		local id = SelectSpawnPoint(currentRoom, enemy, encounter, args, depth)
		return id
	end

	if args.AllowNoSpawnPoint then
		return
	end

	if encounter.Name ~= nil then
		SessionMapState.SpawnPointsUsed = {}
	end
end

function MySetupArachneCombatEncounter(eventSource, args)
	game.SpawnArachneCocoons(eventSource, args)

	-- @modified Force the reward Cocoon
	local roomRewardCocoon = game.MapState.ActiveObstacles[game.CurrentRun.CurrentRoom.CoocoonIds[1]]

	roomRewardCocoon.OnDeathFunctionName = "SpawnRoomReward"
	roomRewardCocoon.OnDeathFunctionArgs = { NofifyWaitersName = "ArachneRewardFound" }
	roomRewardCocoon.OnDeathThreadedFunctionName = "ArachneCombatRewardSpawnPresentation"
	roomRewardCocoon.SpawnUnitOnDeath = nil
	roomRewardCocoon.OnKillVoiceLines = GlobalVoiceLines.PositiveReactionVoiceLines
	game.CurrentRun.CurrentRoom.SpawnRewardOnId = roomRewardCocoon.ObjectId
end

function MySpawnArachneCocoons(eventSource, args)
	-- @modified
	local forcedCocoons
	if game.CurrentRun.CurrentRoom then
		forcedCocoons = game.CurrentRun.CurrentRoom.Cocoons
	end

	local cocoonIds = {}
	if forcedCocoons then
		-- No more randomness
		for k, forcedCocoon in pairs(forcedCocoons) do
			local spawnPointId = game.SelectSpawnPoint(game.CurrentRun.CurrentRoom,
				{ PreferredSpawnPoint = "EnemyPoint", RequiredSpawnPoint = nil, SpawnOnIdKey = forcedCocoon.SpawnOnIdKey })
			if spawnPointId == nil then
				return
			end

			local cocoonName = 'ArachneCocoon'
			-- Small cocoons have no suffix
			if forcedCocoon.Name ~= 'Small' then
				cocoonName = cocoonName .. forcedCocoon.Name
			end
			-- Oceanus cocoons are named differently
			if _getBiomeName(game.CurrentRun.CurrentRoom) == 'G' then
				cocoonName = cocoonName .. '_G'
			end

			local cocoonId = game.SpawnObstacle({ DestinationId = spawnPointId, Name = cocoonName, Group = "Standing", TriggerOnSpawn = false })
			local cocoon = game.DeepCopyTable(game.ObstacleData[cocoonName])
			cocoon.ObjectId = cocoonId
			cocoon.OccupyingSpawnPointId = spawnPointId
			table.insert(cocoonIds, cocoonId)
			game.SetupObstacle(cocoon)
			game.AddAutoLockTarget({ Id = cocoonId })
			game.CurrentRun.CurrentRoom.CoocoonIds = cocoonIds
		end
		return true
	else
		return false
	end
end

function MyArachneCostumeChoice(source, args, screen)
	RemoveInputBlock({ Name = "PlayTextLines" })

	RandomSynchronize(9)

	source.UpgradeOptions = {}
	source.BlockReroll = true

	--@modified, no more randomness
	local currentRoom = _getParametersRoomFromName(game.CurrentRun.CurrentRoom.Name)

	local isForcedTrait = false
	if currentRoom and currentRoom.Traits then
		isForcedTrait = true
		source.UpgradeOptions = {}
		for k, traitName in pairs(currentRoom.Traits) do
			table.insert(source.UpgradeOptions, {
				ItemName = traitName,
				Type = 'Trait',
				Rarity = 'Common'
			})
		end
	end

	if isForcedTrait then
		MedeaCursePreChoicePresentation(source, args)
		OpenUpgradeChoiceMenu(source, args)

		screen.OnCloseFinishedFunctionName = "ArachneArmorApply"

		AddInputBlock({ Name = "PlayTextLines" })

		return true
	else
		return false
	end
end

function MyHandleBreakableSwap(currentRoom, args)
	local roomBreakableData = RoomData[currentRoom.Name].BreakableValueOptions
	if roomBreakableData == nil then
		return
	end
	args = args or {}
	local legalBreakables = FindAllSwappableBreakables()
	local highValueLimit = roomBreakableData.MaxHighValueBreakables or 1
	if highValueLimit == 0 or IsEmpty(legalBreakables) then
		return
	end
	if TableLength(legalBreakables) < highValueLimit then
		highValueLimit = TableLength(legalBreakables)
	end

	local chanceMultiplier = 1.0
	if RoomData[currentRoom.Name].BreakableHighValueChanceMultiplier ~= nil then
		chanceMultiplier = chanceMultiplier * RoomData[currentRoom.Name].BreakableHighValueChanceMultiplier
	end

	CurrentRun.CurrentRoom.HighValueBreakableIds = {}
	--@modified = loop start a 1 to generate N pot of gold instead of N+1
	for index = 1, highValueLimit, 1 do
		local breakable = RemoveRandomValue(legalBreakables)
		if breakable == nil then
			return
		end
		local valueOptions = breakable.BreakableValueOptions
		for k, swapOption in ipairs(valueOptions) do
			if swapOption.GameStateRequirements == nil or IsGameStateEligible(swapOption, swapOption.GameStateRequirements) then
				if RandomChance(swapOption.Chance * chanceMultiplier) then
					if swapOption.Animation ~= nil then
						SetAnimation({ DestinationId = breakable.ObjectId, Name = swapOption.Animation, OffsetY =
						swapOption.OffsetY or 0 })
					end
					table.insert(CurrentRun.CurrentRoom.HighValueBreakableIds, breakable.ObjectId)
					RecordObjectState(currentRoom, breakable.ObjectId, "Animation", swapOption.Animation)
					breakable.MoneyDropOnDeath = ShallowCopyTable(swapOption.MoneyDropOnDeath)
					RecordObjectState(currentRoom, breakable.ObjectId, "MoneyDropOnDeath", breakable.MoneyDropOnDeath)
					DebugPrint({ Text = "HandleBreakableSwap: an up-valued breakable spawned at Id " ..
					breakable.ObjectId })
					OverwriteTableKeys(breakable, swapOption.DataOverrides)
					for k, v in pairs(swapOption.DataOverrides) do
						RecordObjectState(CurrentRun.CurrentRoom, breakable.ObjectId, k, v)
					end
					if breakable.BreakableValueOptions.SetupEvents ~= nil then
						RunEventsGeneric(breakable.BreakableValueOptions.SetupEvents, breakable)
					end
					break
				end
			end
		end
	end
end

function MyUnwrapRandomLoot(source)
	local spawnId = source.ObjectId
	AddInputBlock({ Name = "RandomLoot" })
	RandomSynchronize()
	InvalidateCheckpoint()
	local obstacleId = SpawnObstacle({ Name = "InvisibleTarget", DestinationId = spawnId })

	-- @modified, force the god
	local tmpArgs = { SpawnPoint = obstacleId }
	local currentRoom = _getParametersRoomFromName(game.CurrentRun.CurrentRoom.Name)
	if currentRoom and currentRoom.ShopContent then
		for k, shopOption in pairs(currentRoom.ShopContent) do
			if shopOption.Reward == 'RandomBoon' then
				tmpArgs = { SpawnPoint = obstacleId, ForceLootName = shopOption.BoonGod .. 'Upgrade' }
				break
			end
		end
	end
	local reward = GiveLoot(tmpArgs)

	SetObstacleProperty({ Property = "MagnetismWhileBlocked", Value = 0, DestinationId = reward.ObjectId })

	reward.BoughtFromShop = true
	if source.BlockBoughtTextLines then
		reward.BoughtTextLines = nil
	end
	reward.WasRandomLoot = true
	reward.MakeUpTextLines = nil
	UseableOff({ Id = reward.ObjectId })
	UnwrapLootPresentation(reward)
	Destroy({ Id = obstacleId })
	wait(0.5)
	UseableOn({ Id = reward.ObjectId })
	SetInteractProperty({ DestinationId = reward.ObjectId, Property = "AutoActivate", Value = true })
	SetInteractProperty({ DestinationId = reward.ObjectId, Property = "Distance", Value = 1000 })

	RunWeaponMethod({ Id = CurrentRun.Hero.ObjectId, Weapon = "All", Method = "cancelCharge" })
	RunWeaponMethod({ Id = CurrentRun.Hero.ObjectId, Weapon = "All", Method = "ForceControlRelease" })

	RemoveInputBlock({ Name = "RandomLoot" })
	HideUseButton(reward.ObjectId, reward, 0)
end

function MyApplyScyllaFightSpotlight(scylla, args)
	local encounter = CurrentRun.CurrentRoom.Encounter
	if CurrentRun.CurrentRoom.Name ~= "G_Boss02" then
		args.Flags.Charybdis = nil
	end
	local flagData = GetRandomValue(args.Flags)

	if GameState.EncountersOccurredCache.BossScylla01 == 1 then
		flagData = args.Flags.Keytarist
	end
	if CurrentRun.CurrentRoom.Name == "G_Boss02" and GameState.EncountersOccurredCache.BossScylla02 == 1 then
		flagData = args.Flags.Charybdis
	end

	--@modified Force the Spotlight Siren
	local currentRoom = _getParametersRoomFromName(game.CurrentRun.CurrentRoom.Name)
	if currentRoom and currentRoom.BossParameter then
		flagData = args.Flags[currentRoom.BossParameter]
	end

	flagData.Id = GetFirstValue(GetIdsByType({ Name = flagData.Name }))

	encounter.ScyllaId = scylla.ObjectId

	CreateAnimation({ Name = "StageSpotlight", DestinationId = flagData.Id, Group = "FX_Add_Top" })
	CreateAnimation({ Name = "ScyllaBoostedFxSpawner", DestinationId = flagData.Id })
	PlaySound({ Name = "/Leftovers/SFX/LightOn", flagData.Id })

	if flagData.ApplyEffect ~= nil then
		flagData.ApplyEffect.Id = scylla.ObjectId
		flagData.ApplyEffect.DestinationId = flagData.Id
		if flagData.ApplyEffect.DataProperties and not flagData.ApplyEffect.DataProperties.TimeModifierFraction then
			flagData.ApplyEffect.DataProperties.TimeModifierFraction = 1
		end
		ApplyEffect(flagData.ApplyEffect)
	end

	if ActiveEnemies[flagData.Id] ~= nil then
		ActiveEnemies[flagData.Id].SpotlightFlag = flagData

		if args.UnequipWeapons then
			RemoveAllValues(ActiveEnemies[flagData.Id].WeaponOptions, args.UnequipWeapons)
			DebugPrintTable(ActiveEnemies[flagData.Id].WeaponOptions)
		end
	end
	MapState.SpotlightUnitId = flagData.Id

	thread(SetMapFlag, flagData)

	thread(ScyllaSpotlightPresentation, flagData, scylla)
end

function MySpawnRewardCages(room, args)
	--@modified
	local currentRoomParameters = _getParametersRoomFromName(game.CurrentRun.CurrentRoom.Name)

	local rewardSpawnPoints = game.GetIdsByType({ Name = "LootPoint" })
	table.sort( rewardSpawnPoints )
	for index, cageReward in ipairs( room.CageRewards ) do

		local spawnPointId
		if currentRoomParameters then
			for _,rewardParameters in pairs(currentRoomParameters.Rewards) do
				if rewardParameters.Name then
					local rewardFound = false
					-- Match on the Reward. @todo improve this to be cleaner and handle every case
					if cageReward.RewardType == 'Boon' and rewardParameters.Name == 'Boon' then
						rewardFound = true
					elseif cageReward.RewardType == 'SpellDrop' and rewardParameters.Name == 'Boon' and rewardParameters.BoonGod == 'Selene' then
						rewardFound = true
					elseif cageReward.RewardType == rewardParameters.Name then
						rewardFound = true
					end

					if rewardFound and rewardParameters.LocationKeyId then
						spawnPointId = rewardSpawnPoints[rewardParameters.LocationKeyId]
						break
					end
				end
			end
		end


		-- No location found, fallback to the game code for safety
		if not spawnPointId then
			rom.log.warning('no cage spawn point found ' )
			spawnPointId = game.RemoveRandomValue( rewardSpawnPoints )
		end

		local obstacleName = "FieldsRewardCage"
		local rewardCage = DeepCopyTable( ObstacleData[obstacleName] )
		rewardCage.ObjectId = SpawnObstacle({ Name = obstacleName, DestinationId = spawnPointId, Group = "Standing", TriggerOnSpawn = false })
		rewardCage.SpawnPointId = spawnPointId			
		SetupObstacle( rewardCage )
		
		rewardCage.Encounter = cageReward.Encounter
		local rewardOverride = cageReward.RewardType --or ChooseRoomReward( CurrentRun, {}, room.RewardStoreName )
		local reward = SpawnRoomReward( room, { RewardOverride = rewardOverride, LootName = cageReward.ForceLootName, SpawnRewardOnId = spawnPointId, AutoLoadPackages = true } )
		rewardCage.RewardId = reward.ObjectId

		for k, spawnPointId in ipairs( MapState.SpawnPoints ) do
			SessionMapState.DistanceCache[spawnPointId] = SessionMapState.DistanceCache[spawnPointId] or {}
			local distance = SessionMapState.DistanceCache[spawnPointId][rewardCage.ObjectId] or GetDistance({ Id = spawnPointId, DestinationId = rewardCage.ObjectId })
			SessionMapState.DistanceCache[spawnPointId][rewardCage.ObjectId] = distance
		end

		UseableOff({ Id = rewardCage.RewardId })
	end

	-- bonus rewards
	local bonusRewardSpawnPoints = GetIds({ Name = "BonusRewardSpawnPoints" })
	table.sort( bonusRewardSpawnPoints )

	-- Remove randomness for optionalRewards
	if currentRoomParameters and currentRoomParameters.FieldsBonusRewards then
		for _,FieldsBonusReward in pairs (currentRoomParameters.FieldsBonusRewards) do
			local bonusRewardSpawnId = bonusRewardSpawnPoints[FieldsBonusReward.LocationKeyId] or game.RemoveRandomValue( bonusRewardSpawnPoints )
			if bonusRewardSpawnId ~= nil then
				local rewardOverride = FieldsBonusReward.Name

				local rewardSpawnData = { RewardOverride = rewardOverride, SpawnRewardOnId = bonusRewardSpawnId, NotRequiredPickup = true }
				local bonusReward = game.SpawnRoomReward( room, rewardSpawnData )
				game.MapState.OptionalRewards[bonusReward.ObjectId] = bonusReward
				if bonusReward ~= nil then
					room.Encounter.RewardsToRestore = room.Encounter.RewardsToRestore or {}
					room.Encounter.RewardsToRestore[bonusReward.ObjectId] = rewardSpawnData
				end
			end
		end
	end

	-- cull some spawn points from unoccupued reward points
	if RoomData[room.Name].UnoccupiedRewardCullCount ~= nil then
		local passiveSpawnPoints = GetIdsByType({ Name = "EnemyPointSupport" })
		for k, rewardPointId in pairs( bonusRewardSpawnPoints ) do
			local nearbyEnemyPoints = GetClosestIds({ Id = rewardPointId, DestinationIds = passiveSpawnPoints, Distance = 500 })
			for i = 1, RoomData[room.Name].UnoccupiedRewardCullCount do
				if not IsEmpty( nearbyEnemyPoints ) then
					SessionMapState.SpawnPointsUsed[RemoveRandomValue(nearbyEnemyPoints)] = 1
				end
			end
		end
	end
end

function MyEchoChoice(source, args, screen)
	RemoveInputBlock({ Name = "PlayTextLines" })

	-- @modified Forced traits
	local currentRoomParameters = _getParametersRoomFromName(game.CurrentRun.CurrentRoom.Name)
	if currentRoomParameters and currentRoomParameters.Traits then
		source.UpgradeOptions = {}
		for _,trait in pairs(currentRoomParameters.Traits) do
			table.insert(source.UpgradeOptions, {
				ItemName = trait,
				Type = 'Trait',
				Rarity = 'Common'
			})
		end
	else
		RandomSynchronize( 9 )

		source.UpgradeOptions = {}
		source.BlockReroll = true
		local options = ShallowCopyTable( args.UpgradeOptions )
		local eligibleOptions = {}
		for i, option in pairs(options) do
			if TraitData[option.ItemName] and IsTraitEligible( TraitData[option.ItemName] ) then
				table.insert(eligibleOptions, option)
			end
		end
		if not CurrentRun.LastReward then
			CurrentRun.LastReward = { Type = "Consumable", Name = "MaxHealthDrop", DisplayName = "MaxHealthDrop" }
		end

		for i = 1, 3 do
			if not IsEmpty(eligibleOptions) then
				local option = RemoveRandomValue( eligibleOptions )
				table.insert( source.UpgradeOptions, option )
			end
		end
	end

	if args.PortraitShift ~= nil then
		args.PortraitShift.Id = screen.PortraitId
		Move( args.PortraitShift )
	end
	MedeaCursePreChoicePresentation( source, args )
	OpenUpgradeChoiceMenu( source, args )
	screen.OnCloseFinishedFunctionName = "EchoPostChoicePresentation"

	AddInputBlock({ Name = "PlayTextLines" })
end

function MyPregenerateSpells(screen)
	SessionMapState.SelectedSpells = {}

	local eligibleSpells = GetEligibleSpells( screen )

	-- Remove randomness
	table.sort(eligibleSpells)

	local items = 0
	while items < 3 and not IsEmpty( eligibleSpells ) do
		local spellName = table.remove( eligibleSpells,1 )
		table.insert(SessionMapState.SelectedSpells, spellName )
		items = items + 1
	end

	local duoEligible = false
	for _, spellName in pairs( SessionMapState.SelectedSpells ) do
		local spellData = SpellData[spellName]
		for _, talentName in pairs(spellData.Talents.Legendary) do
			local talentData = TraitData[talentName]
			if talentData.IsDuoBoon and IsGameStateEligible({}, talentData.GameStateRequirements ) then
				SessionMapState.DuoTalentEligible = true
				SessionMapState.DuoTalentEligibleSpell[spellName] = true
				SessionMapState.DuoTalentEligibleGender[ LootData[talentData.LinkedGod ].Gender ] = true
			end
		end
	end
end

function MyGetEligibleSpells(screen)
	if not IsEmpty(SessionMapState.SelectedSpells) then
		return SessionMapState.SelectedSpells
	end

	local currentRoomParameters = _getParametersRoomFromName(game.CurrentRun.CurrentRoom.Name)

	local eligibleSpells = {}
	if currentRoomParameters and currentRoomParameters.Rewards then
		for _, reward in pairs(currentRoomParameters.Rewards) do
			if reward.BoonGod == 'Selene' then
				for _, trait in pairs(reward.Traits) do
					table.insert( eligibleSpells, trait )
				end
			end
		end
	end

	-- Defalt to in game code
	if not eligibleSpells[1] then
		args = args or {}
		for spellName, spellData in pairs( SpellData ) do
			if screen.StripRequirements or spellData.GameStateRequirements == nil or IsGameStateEligible( spellData, spellData.GameStateRequirements ) then
				table.insert( eligibleSpells, spellData.Name )
			end
		end
	end

	return eligibleSpells
end