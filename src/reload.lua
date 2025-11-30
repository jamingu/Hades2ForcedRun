---@meta _
-- globals we define are private to our plugin!
---@diagnostic disable: lowercase-global
-- this file will be reloaded if it changes during gameplay, so only assign to values or define things here.

------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------

-- @improvements:
-- Redo whole run, check everything is similar
-- set position of ennemies/cocoons in all the Biome 1 (except arty) as a proof of concept
-- pusher le code sur le github de jamingu

-- @finish foolish run:
-- handle world shop between biome
-- handle oceanus then the rest


-- @later:
-- unrandomise gathering spots and location
-- unrandomise location pot of gold
-- unrandomise enemies gold death
-- unrandomise cocoons content except the reward (ennemy, explode, money)



-- Defined run parameters (room layouts, encounters,...)
local RunParameters = {
	Biomes = {
		F = {
			Rooms = {
				{
					{
						Name = 'F_Opening03',
						Encounter = 'OpeningGeneratedF',
						-- No forced God to allow other aspects to run with their preferred setup
						--Reward = 'Boon',
						--BoonGod = 'Zeus',
						Traits = {
							{
								{ Name = 'Special', Rarity = 'Epic' },
								{ Name = 'Sprint', Rarity = 'Common' },
								{ Name = 'Mana', Rarity = 'Rare' },
							}
						},
						SpawnWaves = {
							{
								Spawns = {
									{ Name = 'Mage', Count = 1, SpawnOnIdKeys = {1} },
									{ Name = 'Brawler', Count = 2, SpawnOnIdKeys = {2,3} },
								}
							}
						}
					}
				},
				{
					{
						Name = 'F_Combat03',
						Reward = 'MetaCardPointsCommonDrop',
						SpawnWaves = {
							{
								Spawns = {
									{ Name = 'Brawler',  Count = 2 },
									{ Name = 'Mage', Count = 3 },
								},
								SpawnOrder = {'Mage', 'Mage', 'Mage', 'Brawler', 'Brawler'}
							}
						}
					}
				},
				{
					{
						Name = 'F_Combat10',
						Reward = 'Boon',
						BoonGod = 'Hestia',
						Traits = {
							{
								{ Name = 'Sprint', Rarity = 'Common' },
								{ Name = 'CastProjectile', Rarity = 'Common' },
								{ Name = 'FireballManaSpecial', Rarity = 'Rare' },
							},
							{
								{ Name = 'Weapon', Rarity = 'Common' },
								{ Name = 'Cast', Rarity = 'Common' },
								{ Name = 'BurnExplode', Rarity = 'Common' },
							},
						},
						SpawnWaves = {
							{
								Spawns = {
									{ Name = 'Radiator', Count = 7 },
								},
							},
							{
								Spawns = {
									{ Name = 'Mage',     Count = 2 },
									{ Name = 'Radiator', Count = 3 },
								},
								SpawnOrder = {'Mage', 'Mage', 'Radiator', 'Radiator', 'Radiator' }
							}
						}
					},
					{
						Name = 'F_Combat10',
						Reward = 'StackUpgrade'
					},
				},
				{
					{
						Name = 'F_Combat21',
						Reward = 'RoomMoneyDrop',
						GoldPots = {Count = 2},
						SpawnWaves = {
							{
								Spawns = {
									{ Name = 'Mage', Count = 5 },
								}
							},
							{
								Spawns = {
									{ Name = 'Mage',     Count = 2 },
									{ Name = 'Radiator', Count = 3 },
								}
							}
						}
					}
				},
				{
					{
						Name = 'F_Combat10',
						Reward = 'MetaCardPointsCommonDrop'
					},
					{
						Name = 'F_Combat05',
						Encounter = 'ArachneCombatF',
						Reward = 'GiftDrop',
						Cocoons = {
							{Name = 'Small', SpawnOnIdKey = 1},
							{Name = 'Small', SpawnOnIdKey = 2},
							{Name = 'Small', SpawnOnIdKey = 3},
							{Name = 'Small', SpawnOnIdKey = 4},
							{Name = 'Medium', SpawnOnIdKey = 5},
							{Name = 'Medium', SpawnOnIdKey = 6},
							{Name = 'Large', SpawnOnIdKey = 7},
							{Name = 'Large', SpawnOnIdKey = 8}
						},
						IsForcedWell = true,
						WellContent = {
							{
								{Name = 'TemporaryHealExpirationTrait', Type = 'Trait'},
								{Name = 'TemporaryEmptySlotDamageTrait', Type = 'Trait'},
								{Name = 'TemporaryForcedSecretDoorTrait', Type = 'Trait'},
							}
						},
						WellSpawnOnIdKey = 2
					}
				},
				{
					{
						Name = 'F_MiniBoss03',
						IsFlipped = true,
						Reward = 'Boon', --Room right reward is Demeter
						BoonGod = 'Hera',
						GoldPots = {Count = 1},
						Traits = {
							{
								{ Name = 'Cast', Rarity = 'Epic' },
								{ Name = 'Sprint', Rarity = 'Rare' },
								{ Name = 'DamageShareRetaliate', Rarity = 'Rare' },
							},
							{
								{ Name = 'Attack', Rarity = 'Rare' },
								{ Name = 'Sprint', Rarity = 'Epic' },
								{ Name = 'OmegaHeraProjectile', Rarity = 'Rare' },
							},
						},
					},
					{
						Name = 'F_MiniBoss03',
						Reward = 'Boon',
						BoonGod = 'Demeter',
					},
				},
				{
					{
						Name = 'F_Combat16',
						Encounter = 'ArtemisCombatF',
						Reward = 'MaxManaDrop',
						GoldPots = {Count = 1},
						ArtemisTraits = {
							{
								{ Name = 'DashOmegaBuff', Rarity = 'Common' },
								{ Name = 'FocusCrit', Rarity = 'Common' },
								{ Name = 'CritBonus', Rarity = 'Common' },
							},
							{
								{ Name = 'CritBonus', Rarity = 'Common' },
								{ Name = 'HighHealthCrit', Rarity = 'Rare' },
								{ Name = 'TimedCritVulnerability', Rarity = 'Common' },
							},
						},
						SpawnWaves = {
							{
								Spawns = {
									{ Name = 'Brawler',  Count = 4 },
								},
								SpawnOrder = {'Brawler', 'Brawler', 'Brawler', 'Brawler'}
							},
							{
								Spawns = {
									{ Name = 'Brawler',  Count = 1 },
									{ Name = 'Mage_Elite',  Count = 1 },
								},
								SpawnOrder = {'Brawler', 'Mage_Elite'}
							},
							{
								Spawns = {
									{ Name = 'Brawler',  Count = 1 },
									{ Name = 'SiegeVine',  Count = 2 },
								},
								SpawnOrder = {'Brawler', 'SiegeVine', 'SiegeVine'}
							},
							{
								Spawns = {
									{ Name = 'Mage_Elite',  Count = 3 },
									{ Name = 'Brawler',  Count = 3 },
								},
								SpawnOrder = {'Brawler', 'Mage_Elite',  'Mage_Elite', 'Brawler', 'Mage_Elite', 'Brawler'}
							},
						}
					}
				},
				{
					{
						Name = 'F_Shop01',
						IsNemesisForced = false,
						IsZagreusForced = true,
						ShopContent = {
							{
								Reward = 'Boon',
								BoonGod = 'Hephaestus',
							},
							{
								Reward = 'Hammer',
								-- @todo switch back when not doing Medea
								--Traits = { 'LobPulseAmmoCollectTrait', 'LobOneSideTrait', 'LobGrowthTrait'}
								Traits = { 'TorchDiscountExAttackTrait', 'TorchExSpecialCountTrait', 'TorchSpecialSpeedTrait'},
							},
							{
								Reward = 'RandomPom',
							}
						}
					},
					{
						Name = 'F_Combat02',
						Reward = 'MetaCardPointsCommonDrop'
					},
				},
				{
					{
						Name = 'F_Reprieve01',
						Reward = 'StackUpgrade',
					},
					{
						Name = 'F_Reprieve01',
						Reward = 'MaxManaDrop',
					}
				},
				{
					{
						Name = 'F_Story01',
						Traits = { 'HighArmorCostume', 'EscalatingCostume', 'VitalityCostume'},
					},
					{
						Name = 'F_Combat02',
						Reward = 'Selene',
					},
				},
				{
					{
						Name = 'F_Combat14',
						Reward = 'MaxHealthDrop',
					},
					{
						Name = 'F_Combat14', -- room left reward is heart
						Reward = 'RoomMoneyDrop',
						SpawnWaves = {
							{
								Spawns = {
									{ Name = 'Mage_Elite', Count = 5 },
									{ Name = 'Radiator',   Count = 1 },
									{ Name = 'Screamer',   Count = 5 },
								}
							}
						},
						IsForcedWell = true,
						WellSpawnOnIdKey = 1, -- @todo: final room before shop, well at the middle left
					}
				},
				{
					{
						Name = 'F_PreBoss01',
						IsZagreusForced = false,
						IsNemesisForced = false,
						ShopContent = {
							{
								Reward = 'Boon',
								BoonGod = 'Hestia',
								Traits = {
									{
										{ Name = 'Sprint', Rarity = 'Common' },
										{ Name = 'AloneDamage', Rarity = 'Epic' },
										{ Name = 'FireballManaSpecial', Rarity = 'Common' },
									},
								},
							},
							{
								Reward = 'HealDropMajor',
							},
							{
								Reward = 'MaxManaDrop',
							}
						}
					},
					{
						Name = 'F_PreBoss01',
						Reward = 'Boon',
						BoonGod = 'Hermes',
					},
				},
				{
					{
						Name = 'F_Boss01',
						BossName = 'Hecate',
						BossAttack = 'HecateMeteorShower',
					}
				},
			}
		},
		--@todo: dont forget to put IsNemesisForced/IsZagreusForced= false in shop as it may be globally set true before
		H = {
		}
	},
};

function generateForcedStartingRoom( currentRun, args )
	--Force the generation of the Opening/Intro room
	local startingRoomData = _createRoomData(_getRunParametersStartingRoom())

	local startingRoom = CreateRoom( startingRoomData, args )
	return startingRoom
end

function generateForcedRoomReward(currentRun, args, otherDoors)
	if currentRun and currentRun.CurrentRoom then
		local currentBiomeName = _getBiomeName(currentRun.CurrentRoom)
		local currentRoomName = currentRun.CurrentRoom.Name

		-- Find the next room
		local nextRoom = _getRunParametersNextRoom(currentBiomeName, currentRoomName)
		if nextRoom then
			return _createRoomData(nextRoom)
		end

		-- No index exists, return a default generated room
		return nil
	end
end

function generateForcedShopOptions(args)
	local shopOptions = nil

	if CurrentRun and CurrentRun.CurrentRoom then
		local currentRoom = _getRunParametersForRoom(CurrentRun.CurrentRoom)
		if currentRoom then
			if currentRoom.ShopContent then
				shopOptions = {}
				for k,shopContent in pairs(currentRoom.ShopContent) do
					-- For information, order of shop appearance seems weird (2,3,1) if want to force it
					local shopOption
					if shopContent.Reward == 'Boon' then
						-- ResourceCosts = {Money = 150}
						local tmpArgs =  {
							ForceLootName = shopContent.BoonGod..'Upgrade',
							BoughtFromShop = true,
							DoesNotBlockExit = true,
							ResourceCosts = {Money = 150}
						}
						shopOption = {
							Name = 'RandomLoot',
							Type = 'Boon',
							Args = tmpArgs
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
					else
						shopOption = {
							Name = shopContent.Reward,
							Type = 'Consumable',
						}
					end

					table.insert(shopOptions, shopOption)
				end
			elseif currentRoom.WellContent and currentRoom.WellContent[1] then
				wellContentOptions = table.remove(currentRoom.WellContent, 1)
				shopOptions = {}
				for k,wellContentOption in pairs(wellContentOptions) do
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
	local currentBiomeName
	if currentRun and currentRun.CurrentRoom then
		currentBiomeName = _getBiomeName(currentRun.CurrentRoom)
	else
		currentBiomeName = 'F' -- No current run, pick the starting Biome
	end

	local currentRoom = _getRunParametersForRoom(room)

	if currentRoom then
		if string.find(currentRoom.Name, '_Combat') or string.find(currentRoom.Name, '_Opening') then
			local encounterName
			if currentRoom.Encounter then
				encounterName = currentRoom.Encounter
			else
				encounterName = 'Generated'..currentBiomeName
			end

			local createdEncounterData = DeepCopyTable(EncounterData[encounterName])

			-- Create custom spawn waves
			if (currentRoom.SpawnWaves ~= nil) then
				-- Create the spawn waves
				local createdSpawnWaves = {}
				local waveCount = 0
				for spawnWaveKey, spawnWaveValues in pairs(currentRoom.SpawnWaves) do
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

				createdEncounterData.SpawnWaves = createdSpawnWaves
				createdEncounterData.MinWaves = waveCount
				createdEncounterData.MaxWaves = waveCount
				createdEncounterData.SpawnIntervalMax = createdEncounterData.SpawnIntervalMin
			end

			return createdEncounterData
		elseif string.find(currentRoom.Name, '_Shop') then
			-- Handle Nemesis spawn in shop. Must be set in the global variable as it is the one accessed in StartRoom and not the encounterData itself
			for k,event in pairs(EncounterData['Shop'].StartRoomUnthreadedEvents) do
				if event.FunctionName == 'CheckNemesisShoppingEvent' then
					if currentRoom.IsNemesisForced then
						EncounterData['Shop'].StartRoomUnthreadedEvents[k].GameStateRequirements.ChanceToPlay = 1
					else
						EncounterData['Shop'].StartRoomUnthreadedEvents[k].GameStateRequirements.ChanceToPlay = 0
					end

					break
				end
			end

			return createdEncounterData
		end
	end
end

function generateForcedRewardTraits( lootData, args )
	local upgradeOptions = nil

	if lootData.GodLoot then
		upgradeOptions = generateForcedBoonRewardTraits(lootData)
	elseif lootData.Name == 'WeaponUpgrade' then
		upgradeOptions = generateForcedHammerRewardTraits()
	elseif lootData.SpeakerName == 'Artemis' then
		upgradeOptions = generateForcedBoonRewardTraits(lootData)
	end

	if upgradeOptions then
		lootData.UpgradeOptions = upgradeOptions
		return true
	else
		return false
	end
end

function generateForcedBoonRewardTraits(lootData)
	local currentRoom = _getRunParametersForRoom(CurrentRun.CurrentRoom)

	-- Retrieve the name of the speaking God to concatenate with the boon name 
	local speakerName = lootData.SpeakerName
	local forcedTraits = nil


	-- If a BoonTraits parameter exists (room or shop), force it
	if currentRoom and currentRoom.Traits and currentRoom.Traits[1] then
		-- Standard Room reward
		forcedTraits = table.remove(currentRoom.Traits, 1) -- Pop the first offered traits list
	elseif currentRoom and currentRoom.ShopContent then
		-- Shop option
		for k, shopElement in pairs(currentRoom.ShopContent) do
			if shopElement.Reward == 'Boon' and shopElement.BoonGod == speakerName then
				if currentRoom.ShopContent[k].Traits and currentRoom.ShopContent[k].Traits[1] then
					forcedTraits = table.remove(currentRoom.ShopContent[k].Traits, 1)
					break
				end
			end
		end
	elseif currentRoom and currentRoom.ArtemisTraits and currentRoom.ArtemisTraits[1] then
		-- Artemis
		forcedTraits = table.remove(currentRoom.ArtemisTraits, 1)
	end

	if forcedTraits ~= nil then
		local upgradeOptions = {}
		for k,trait in pairs(forcedTraits) do
			local itemName =  trait.Name
			-- AttackBoon is named WeaponBoon in the game files
			if itemName == 'Attack' then
				itemName =  'Weapon'
			end

			itemName = itemName..'Boon'

			-- Concatenate the god name for "WeapongUpgrades": attack/special/cast/sprint/mana
			if LootSetData[speakerName] and LootSetData[speakerName][speakerName..'Upgrade'] and LootSetData[speakerName][speakerName..'Upgrade'].WeaponUpgrades then
				for k, weapongUpgrade in pairs(LootSetData[speakerName][speakerName..'Upgrade'].WeaponUpgrades) do
					if weapongUpgrade == speakerName..itemName then
						itemName = speakerName..itemName
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
	local currentRoom = _getRunParametersForRoom(CurrentRun.CurrentRoom)

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
		for k,trait in pairs(forcedTraits) do
			table.insert(upgradeOptions, {
				Type = 'WeaponUpgrade',
				ItemName = trait,
			})
		end

		return upgradeOptions
	end
end

function forcedStartRoom(currentRun, currentRoom)
	local currentRoom = _getRunParametersForRoom(currentRoom)

	-- Force well position
	if currentRoom and currentRoom.WellSpawnOnIdKey then
		local challengeBaseIds = GetIdsByType({ Name = "ChallengeSwitchBase" })
		if challengeBaseIds[currentRoom.WellSpawnOnIdKey] then
			RoomData[currentRoom.Name].WellShopChallengeBaseId = challengeBaseIds[currentRoom.WellSpawnOnIdKey]
		end
	end

	-- Force Boss attack
	if currentRoom and currentRoom.BossName == 'Hecate' and currentRoom.BossAttack then
		UnitSetData[currentRoom.BossName][currentRoom.BossName].AIStages[2].MidPhaseWeapons = {currentRoom.BossAttack}
	end

	-- Force gold pots
	local goldPotsCount = 0
	if currentRoom.GoldPots and currentRoom.GoldPots.Count then
		goldPotsCount = currentRoom.GoldPots.Count
	end
	RoomData[currentRoom.Name].BreakableValueOptions = { MaxHighValueBreakables = goldPotsCount }
	RoomData[currentRoom.Name].BreakableHighValueChanceMultiplier = 100.0
end

function getForcedRoomRewards(run, room)
	return room.ForcedRewards
end

function _createRoomData(roomParameters)
	if roomParameters then
		-- Ensure the room is generated only once
		roomParameters.Generated = true

		-- Retrieve the default RoomData
		local createdRoomData = RoomData[roomParameters.Name]

		-- Remove Chaos chance
		-- @todo: handle Chaos chance
		createdRoomData.SecretSpawnChance = 0

		-- Handle Well chance
		if roomParameters.IsForcedWell then
			createdRoomData.ForceWellShop = 1
			createdRoomData.WellShopSpawnChance = 1
		else
			createdRoomData.WellShopSpawnChance = 0
		end

		-- Prevent room random flipping
		if roomParameters.IsFlipped then
			createdRoomData.Flipped = roomParameters.IsFlipped
		else
			createdRoomData.Flipped = false
		end
		
		-- Force the reward
		if roomParameters.Reward == 'Boon' then
			createdRoomData.ForcedRewards = {
				{
					Name = roomParameters.Reward,
					LootName = roomParameters.BoonGod .. 'Upgrade',
				},
			}
		elseif roomParameters.Reward == 'Selene' then
			createdRoomData.ForcedRewards = {
				{
					Name = 'SpellDrop',
				},
			}
		elseif roomParameters.Reward == 'Hammer' then
			createdRoomData.ForcedRewards = {
				{
					Name = 'WeaponUpgrade',
				},
			}
		elseif roomParameters.Reward then
			createdRoomData.ForcedRewards = {
				{
					Name = roomParameters.Reward,
				},
			}
		end

		if string.find(roomParameters.Name, '_Shop') then
			-- Handle Zagreus contract spawn in shop, set in the global StoreData variable
			if roomParameters.IsZagreusForced then
				StoreData.ZagreusContractRequirement.ChanceToPlay = 1
			else
				StoreData.ZagreusContractRequirement.ChanceToPlay = 0
			end
		end

		return createdRoomData
	else
		return nil
	end
end

function _getRunParametersForRoom(room)
	local roomName = room.Name
	local biomeName = room.RoomSetName

	for k, rooms in pairs(RunParameters.Biomes[biomeName].Rooms) do
		for k2, roomParameters in pairs(rooms) do
			if roomParameters and roomParameters.Name == roomName then
				-- Biome+RoomName+RoomReward exists and match, return the room
				if room.ForcedReward and room.ForcedReward.Name == roomParameters.Reward then
					return roomParameters
				elseif #rooms == 1 then
					-- Biome+RoomName match and this is the only room, return the room
					return roomParameters
				end
			end
		end
	end

	return nil
end

function _getRunParametersStartingRoom()
	--@todo handle not F starting Biome
	RunParameters.Biomes['F'].Rooms[1][1].IsGenerated = true
	return RunParameters.Biomes['F'].Rooms[1][1]
end

function _getRunParametersNextRoom(biomeName, roomName)
	for k, rooms in pairs(RunParameters.Biomes[biomeName].Rooms) do
		for k2, room in pairs(rooms) do
			if room and room.Name == roomName then
				for k3, nextRoom in pairs(RunParameters.Biomes[biomeName].Rooms[k+1]) do
					-- Add a property to indicate this room has been generated
					if not nextRoom.IsGenerated then
						RunParameters.Biomes[biomeName].Rooms[k+1][k3].IsGenerated = true
						return nextRoom
					end
				end
			end
		end
	end

	return nil
end

function _getBiomeName(currentRoom)
	return string.sub(currentRoom.Name, 0, 1)
end

--------------------------------------------------------------
--------------------------------------------------------------
--- Core functions modified, check @modified for the modified part
--------------------------------------------------------------
--------------------------------------------------------------
function MyGetNextSpawn( encounter )
	local forcedSpawn = nil
	local remainingSpawnInfo = {}
	local remainingPrioritySpawnInfo = {}
	local remainingPriorityGroupSpawnInfo = {}
	for k, spawnInfo in orderedPairs( encounter.Spawns ) do
		if spawnInfo.InfiniteSpawns or spawnInfo.RemainingSpawns > 0 then
			local enemyData = EnemyData[spawnInfo.Name]
			if enemyData ~= nil and enemyData.LargeUnitCap ~= nil and enemyData.LargeUnitCap > 0 then
				local largeUnitCount = 0
				for enemyId, enemy in pairs( ShallowCopyTable( ActiveEnemies ) ) do
					if enemy.LargeUnitCap ~= nil and enemyData.LargeUnitCap > 0 then
						largeUnitCount = largeUnitCount + 1
					end
				end
				if largeUnitCount < enemyData.LargeUnitCap then
					table.insert( remainingSpawnInfo, spawnInfo )
					if spawnInfo.PrioritySpawn then
						table.insert( remainingPrioritySpawnInfo, spawnInfo )
					end
				else
					DebugPrint({ Text = "Avoiding LargeUnitCap: "..enemyData.Name })
				end
			else
				table.insert( remainingSpawnInfo, spawnInfo )
				if spawnInfo.PrioritySpawn then
					table.insert( remainingPrioritySpawnInfo, spawnInfo )
				elseif encounter.PrioritizeGroup ~= nil and enemyData ~= nil and Contains(enemyData.Groups, encounter.PrioritizeGroup) then
					table.insert( remainingPriorityGroupSpawnInfo, spawnInfo )
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

		for k,remainingSpawn in pairs(remaining) do
			if remainingSpawn.Name == spawnName then
				randomSpawnInfo = remaining[k]
				break
			end
		end
		
		if randomSpawnInfo == nil then
			rom.log.warning('randomSpawnInfo == nil') -- should not happen, debug
			randomSpawnInfo = remainingPrioritySpawnInfo[1] or remainingPriorityGroupSpawnInfo[1] or remainingSpawnInfo[1]
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
			currentRoom.SpawnPoints[enemy.PreferredSpawnPoint] = ShallowCopyTable(GetIdsByType({ Name = enemy
			.PreferredSpawnPoint }))
		end
		-- @modified Remove shuffle randomness
		shuffledSpawnPointIds = currentRoom.SpawnPoints[enemy.PreferredSpawnPoint] or MapState.SpawnPoints
		table.sort(shuffledSpawnPointIds)
	else
		-- @modified Remove shuffle randomness
		shuffledSpawnPointIds = encounter.NearbySpawnPoints or MapState.SpawnPoints
		table.sort(shuffledSpawnPointIds)
	end

	-- Handle forced spawn position
	local spawnOnIdKeys = nil
	if  encounter.Spawns and encounter.Spawns[enemy.Name] and encounter.Spawns[enemy.Name]['SpawnOnIdKeys'] then
		-- Combat forced position
		spawnOnIdKeys = encounter.Spawns[enemy.Name]['SpawnOnIdKeys']
	elseif enemy.SpawnOnIdKey then
		-- ArachneCombat forced position
		spawnOnIdKeys = { enemy.SpawnOnIdKey }
	end

	if spawnOnIdKeys then
		local newSpawnPointIds = {}
		-- Force the manual spawned point first
		for k, spawnOnIdKey in pairs(spawnOnIdKeys) do
			if spawnOnIdKey and shuffledSpawnPointIds[spawnOnIdKey] then
				table.insert(newSpawnPointIds, shuffledSpawnPointIds[spawnOnIdKey])
			end
		end

		-- Fill the rest of the values with the non manual spawn points
		--@todo remove if useless 
		--[[
		for k, spawnPointId in pairs(shuffledSpawnPointIds) do
			local found = false
			for k2, newSpawnPointId in pairs(newSpawnPointIds) do
				if spawnPointId == newSpawnPointId then
					found = true
					break
				end
			end
				if not found then
				table.insert(newSpawnPointIds, spawnPointId)
			end
		end
		]]

		shuffledSpawnPointIds = newSpawnPointIds
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

function MySetupArachneCombatEncounter( eventSource, args )
	SpawnArachneCocoons( eventSource, args )

	-- @modified Force the reward Cocoon
	-- local roomRewardCocoon = MapState.ActiveObstacles[GetRandomValue(CurrentRun.CurrentRoom.CoocoonIds)]
	local roomRewardCocoon = MapState.ActiveObstacles[CurrentRun.CurrentRoom.CoocoonIds[1]]

	roomRewardCocoon.OnDeathFunctionName = "SpawnRoomReward"
	roomRewardCocoon.OnDeathFunctionArgs = { NofifyWaitersName = "ArachneRewardFound" }
	roomRewardCocoon.OnDeathThreadedFunctionName = "ArachneCombatRewardSpawnPresentation"
	roomRewardCocoon.SpawnUnitOnDeath = nil
	roomRewardCocoon.OnKillVoiceLines = GlobalVoiceLines.PositiveReactionVoiceLines
	CurrentRun.CurrentRoom.SpawnRewardOnId = roomRewardCocoon.ObjectId
end

function MySpawnArachneCocoons( eventSource, args )
	-- @modified
	local currentBiomeName = _getBiomeName(CurrentRun.CurrentRoom)
	local currentRoom = _getRunParametersForRoom(CurrentRun.CurrentRoom)

	local forcedCocoons
	if currentRoom then 
		forcedCocoons = currentRoom.Cocoons
	end

	local cocoonIds = {}
	if forcedCocoons then
		-- No more randomness
		for k,forcedCocoon in pairs(forcedCocoons) do
			local spawnPointId = SelectSpawnPoint(CurrentRun.CurrentRoom, { PreferredSpawnPoint = "EnemyPoint", RequiredSpawnPoint = nil, SpawnOnIdKey = forcedCocoon.SpawnOnIdKey } )
			if spawnPointId == nil then
				return
			end

			local cocoonName = 'ArachneCocoon'
			-- Small cocoons have no suffix
			if forcedCocoon.Name ~= 'Small' then
				cocoonName = cocoonName..forcedCocoon.Name
			end
			-- Oceanus cocoons are named differently
			if currentBiomeName == 'G' then
				cocoonName = cocoonName..'_G'
			end

			local cocoonId = SpawnObstacle({ DestinationId = spawnPointId, Name = cocoonName, Group = "Standing", TriggerOnSpawn = false })
			local cocoon = DeepCopyTable( ObstacleData[cocoonName] )
			cocoon.ObjectId = cocoonId
			cocoon.OccupyingSpawnPointId = spawnPointId
			table.insert(cocoonIds, cocoonId)
			SetupObstacle( cocoon )
			AddAutoLockTarget({ Id = cocoonId })
			CurrentRun.CurrentRoom.CoocoonIds = cocoonIds
		end
		return true
	else
		return false
	end
end

function MyArachneCostumeChoice( source, args, screen )

	RemoveInputBlock({ Name = "PlayTextLines" })

	RandomSynchronize( 9 )

	source.UpgradeOptions = {}
	source.BlockReroll = true

	--@modified, no more randomness
	local currentRoom = _getRunParametersForRoom(CurrentRun.CurrentRoom)

	local isForcedTrait = false
	if currentRoom and currentRoom.Traits then
		isForcedTrait = true
		source.UpgradeOptions = {}
		for k,traitName in pairs(currentRoom.Traits) do
			table.insert(source.UpgradeOptions, {
				ItemName = traitName,
				Type = 'Trait',
				Rarity = 'Common'
			})
		end
	end

	if isForcedTrait then
		MedeaCursePreChoicePresentation( source, args )
		OpenUpgradeChoiceMenu( source, args )

		screen.OnCloseFinishedFunctionName = "ArachneArmorApply"

		AddInputBlock({ Name = "PlayTextLines" })

		return true
	else
		return false
	end
end

function MyHandleBreakableSwap( currentRoom, args )
	local roomBreakableData = RoomData[currentRoom.Name].BreakableValueOptions
	if roomBreakableData == nil then
		return
	end
	args = args or {}
	local legalBreakables = FindAllSwappableBreakables()
	local highValueLimit = roomBreakableData.MaxHighValueBreakables or 1
	if highValueLimit == 0 or IsEmpty( legalBreakables ) then
		return
	end
	if TableLength( legalBreakables ) < highValueLimit then
		highValueLimit = TableLength( legalBreakables )
	end

	local chanceMultiplier = 1.0
	if RoomData[currentRoom.Name].BreakableHighValueChanceMultiplier ~= nil then
		chanceMultiplier = chanceMultiplier * RoomData[currentRoom.Name].BreakableHighValueChanceMultiplier
	end
	
	CurrentRun.CurrentRoom.HighValueBreakableIds = {}
	--@modified = loop start a 1 to generate N pot of gold instead of N+1
	for index = 1, highValueLimit, 1 do
		rom.log.warning('highValueLimit '..highValueLimit)
		rom.log.warning('breakable '..index)
		local breakable = RemoveRandomValue( legalBreakables )
		if breakable == nil then
			return
		end
		local valueOptions = breakable.BreakableValueOptions
		for k, swapOption in ipairs( valueOptions ) do
			rom.log.warning('-2-breakable '..k)
			rom.log.warning(swapOption)
			if swapOption.GameStateRequirements == nil or IsGameStateEligible( swapOption, swapOption.GameStateRequirements ) then
				if RandomChance( swapOption.Chance * chanceMultiplier ) then
					if swapOption.Animation ~= nil then
						SetAnimation({ DestinationId = breakable.ObjectId, Name = swapOption.Animation, OffsetY = swapOption.OffsetY or 0 })
					end
					table.insert( CurrentRun.CurrentRoom.HighValueBreakableIds, breakable.ObjectId )
					RecordObjectState( currentRoom, breakable.ObjectId, "Animation", swapOption.Animation )
					breakable.MoneyDropOnDeath = ShallowCopyTable( swapOption.MoneyDropOnDeath )
					RecordObjectState( currentRoom, breakable.ObjectId, "MoneyDropOnDeath", breakable.MoneyDropOnDeath )
					DebugPrint({ Text = "HandleBreakableSwap: an up-valued breakable spawned at Id "..breakable.ObjectId })
					OverwriteTableKeys(breakable, swapOption.DataOverrides)
					for k, v in pairs(swapOption.DataOverrides) do
						RecordObjectState( CurrentRun.CurrentRoom, breakable.ObjectId, k, v )
					end
					if breakable.BreakableValueOptions.SetupEvents ~= nil then
						RunEventsGeneric( breakable.BreakableValueOptions.SetupEvents, breakable )
					end
					break
				end
			end
		end
	end
end