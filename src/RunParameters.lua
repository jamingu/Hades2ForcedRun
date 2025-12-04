-- Defined run parameters (room layouts, encounters,...)
RunParameters = {
	Biomes = {
        ---------------------
        --- Biome F (Erebus)
        ---------------------
		F = {
			Rooms = {
				{
					{
						Name = 'F_Opening03',
						Encounter = 'OpeningGeneratedF',
						Rewards = {
							{
								-- No forced God to allow other aspects to run with their preferred setup
								--Name = 'Boon',
								BoonGod = 'Any',
								Traits = {
									{
										{ Name = 'Special', Rarity = 'Epic' },
										{ Name = 'Sprint', Rarity = 'Common' },
										{ Name = 'Mana', Rarity = 'Rare' },
									}
								},
							}
						},
						SpawnWaves = {
							{
								Spawns = {
									{ Name = 'Mage', Count = 1, SpawnOnIdKeys = {1} },
									{ Name = 'Brawler', Count = 2, SpawnOnIdKeys = {2,9} },
								}
							}
						}
					}
				},
				{
					{
						Name = 'F_Combat03',
						Rewards = {
							{ Name = 'MetaCardPointsCommonDrop' }
						},
						SpawnWaves = {
							{
								Spawns = {
									{ Name = 'Brawler',  Count = 2, SpawnOnIdKeys = {11,5} },
									{ Name = 'Mage', Count = 3, SpawnOnIdKeys = {1,4,7} },
								},
								SpawnOrder = {'Mage', 'Mage', 'Mage', 'Brawler', 'Brawler'}
							}
						}
					}
				},
				{
					{
						Name = 'F_Combat10',
						Rewards = {
							{
								Name = 'Boon',
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
							}
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
						Rewards = {
							{ Name = 'Pom' }
						},
					},
				},
				{
					{
						Name = 'F_Combat21',
						Rewards = {
							{ Name = 'RoomMoneyDrop' }
						},
						GoldPots = {Count = 2},
						SpawnWaves = {
							{
								Spawns = {
									{ Name = 'Mage', Count = 5 },
								}
							},
							{
								Spawns = {
									{ Name = 'Mage',     Count = 2, SpawnOnIdKeys = {1,2} },
									{ Name = 'Radiator', Count = 3, SpawnOnIdKeys = {3,4,5} },
								}
							}
						}
					}
				},
				{
					{
						Name = 'F_Combat10',
						Rewards = {
							{ Name = 'MetaCardPointsCommonDrop' }
						},
					},
					{
						Name = 'F_Combat05',
						Encounter = 'ArachneCombatF',
						Rewards = {
							{ Name = 'GiftDrop' }
						},
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
						Rewards = {
							{
								Name = 'Boon',
								BoonGod = 'Hera',
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
							}
						},
						GoldPots = {Count = 1}
					},
					{
						Name = 'F_MiniBoss03',
						Rewards = {
							{ Name = 'Boon', BoonGod = 'Demeter' }
						},
					},
				},
				{
					{
						Name = 'F_Combat16',
						Encounter = 'ArtemisCombatF',
						Rewards = {
							{ Name = 'MaxManaDrop' }
						},
						GoldPots = {Count = 1},
						IsFlipped = true,
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
								--Traits = { 'LobPulseAmmoCollectTrait', 'LobOneSideTrait', 'LobGrowthTrait'}
								Traits = { 'TorchDiscountExAttackTrait', 'TorchExSpecialCountTrait', 'TorchSpecialSpeedTrait'}
							},
							{
								Reward = 'RandomPom',
							}
						}
					},
					{
						Name = 'F_Combat02',
						Rewards = {
							{ Name = 'MetaCardPointsCommonDrop' }
						},
					},
				},
				{
					{
						Name = 'F_Reprieve01',
						Rewards = {
							{ Name = 'Pom' }
						},
					},
					{
						Name = 'F_Reprieve01',
						Rewards = {
							{ Name = 'MaxManaDrop' }
						},
					}
				},
				{
					{
						Name = 'F_Combat02',
						Rewards = {
							{ Name = 'Selene' }
						},
					},
					{
						Name = 'F_Story01',
						Traits = { 'HighArmorCostume', 'EscalatingCostume', 'VitalityCostume'},
					},
				},
				{
					{
						Name = 'F_Combat14',
						Rewards = {
							{ Name = 'RoomMoneyDrop' }
						},
						IsFlipped = true,
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
						WellSpawnOnIdKey = 1,
					},
					{
						Name = 'F_Combat14',
						Rewards = {
							{ Name = 'MaxHealthDrop' }
						},
					},
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
							{ Reward = 'HealDropMajor' },
							{ Reward = 'MaxManaDrop' }
						}
					},
					{
						Name = 'F_PreBoss01',
						Rewards = {
							{ Name = 'Boon', BoonGod = 'Hermes' }
						},
					},
				},
				{
					{
						Name = 'F_Boss01',
						BossName = 'Hecate',
						BossParameter = 'HecateMeteorShower',
					}
				},
                {
					{
						Name = 'F_PostBoss01',
						IsForcedWell = true,
                        WellContent = {
							{
								{Name = 'ArmorBoostStore', Type = 'Consumable'},
								{Name = 'LimitedManaRegenDrop', Type = 'Consumable'},
								{Name = 'TemporaryMoveSpeedTrait', Type = 'Trait'},
							},
							{
								{Name = 'FirstHitHealTrait', Type = 'Trait'},
								{Name = 'ExtendedShopTrait', Type = 'Trait'},
								{Name = 'LimitedSwapTraitDrop', Type = 'Consumable'},
							},
							{
								{Name = 'TemporaryMoveSpeedTrait', Type = 'Trait'},
								{Name = 'LimitedManaRegenDrop', Type = 'Consumable'},
								{Name = 'TemporaryImprovedExTrait', Type = 'Trait'},
							},
						},
					}
				},
			}
		},
        ---------------------
        --- Biome G (Oceanus)
        ---------------------
		G = {
            Rooms = {
                {
					{
						Name = 'G_Intro',
						Encounter = 'Empty',
						IsForcedChaos = true,
					}
				},
				{
					{
						Name = 'G_Combat01',
						Rewards = {
							{ Name = 'MetaCardPointsCommonDrop' }
						},
					}
				},
				{
					{
						Name = 'G_Combat07',
						Rewards = {
							{ Name = 'MetaCurrencyDrop' }
						},
						SpawnWaves = {
							{
								Spawns = {
									{ Name = 'FishmanMelee', Count = 6, SpawnOnIdKeys = {1,2,3,4,5,6} },
								}
							}
						}
					}
				},
				{
					{
						Name = 'G_Combat01',
						Rewards = {
							{ Name = 'MetaCurrencyDrop' }
						},
					},
					{
						Name = 'G_Shop01',
						IsNemesisForced = false,
						IsZagreusForced = true,
						IsFlipped = true,
						ShopContent = {
							{ Reward = 'Boon', BoonGod = 'Aphrodite' },
							{ Reward = 'MetaCurrencyDrop' },
							{ Reward = 'MaxManaDrop' },
						}
					},
				},
				{
					{
						Name = 'G_MiniBoss03',
						Rewards = {
							{
								Name = 'Boon',
								BoonGod = 'Poseidon'
							},
							{
								Name = 'Boon',
								BoonGod = 'Hera',
								Traits = {
									{
										{ Name = 'Sprint', Rarity = 'Common' },
										{ Name = 'ElementalRarityUpgrade' },
										{ Name = 'DamageShareRetaliate', Rarity = 'Rare' },
									},
									{
										{ Name = 'Cast', Rarity = 'Rare' },
										{ Name = 'Mana', Rarity = 'Rare' },
										{ Name = 'ElementalRarityUpgrade'},
									},
								},
							}
						}
					},
					{
						Name = 'G_MiniBoss03',
						Rewards = {
							{ Name = 'Boon', BoonGod = 'Hestia' }
						}
					},
				},
				{
					{
						Name = 'G_Combat20',
						Encounter = 'NemesisCombatG',
						Rewards = {
							{ Name = 'MetaCardPointsCommonBigDrop' }
						}
					},
					{
						Name = 'G_Combat20',
						Encounter = 'NemesisCombatG',
						Rewards = {
							{ Name = 'MetaCurrencyBigDrop' }
						}
					},
				},
				{
					{
						Name = 'G_Combat16',
						Rewards = {
							{ Name = 'MaxHealthDrop' }
						},
					},
					{
						Name = 'G_Combat16',
						Rewards = {
							{ Name = 'Boon', BoonGod = 'Poseidon' }
						},
					},
					{
						Name = 'G_Combat16',
						Rewards = {
							{ Name = 'MaxManaDrop' }
						},
						Encounter = 'ArachneCombatG',
						Cocoons = {
							{Name = 'Small', SpawnOnIdKey = 1},
							{Name = 'Small', SpawnOnIdKey = 2},
							{Name = 'Small', SpawnOnIdKey = 3},
							{Name = 'Small', SpawnOnIdKey = 4},
							{Name = 'Small', SpawnOnIdKey = 5},
							{Name = 'Medium', SpawnOnIdKey = 6},
						},
						IsForcedWell = true,
						WellSpawnOnIdKey = 1
					},
				},
				{
					{
						Name = 'G_Combat02',
						Encounter = 'DevotionTestG',
						Rewards = {
							{
								Name = 'Devotion',
								GodA = 'Zeus',
								GodB = 'Hestia'
							}
						},
					},
					{
						Name = 'G_Combat02',
						Rewards = {
							{ Name = 'RoomMoneyDrop' }
						},
						IsFlipped = true,
						SpawnWaves = {
							{
								Spawns = {
									{ Name = 'FishSwarmerSquad_Elite', Count = 6, SpawnOnIdKeys = {1,2,3} },
									{ Name = 'Turtle_Elite', Count = 3, SpawnOnIdKeys = {5,6,7} },
								}
							}
						}
					},
				},
				{
					{
						Name = 'G_PreBoss01',
						IsZagreusForced = false,
						IsNemesisForced = false,
						IsFlipped = true,
						ShopContent = {
							{
								Reward = 'RandomBoon',
								BoonGod = 'Poseidon',
								Traits = {
									{
										{ Name = 'Cast', Rarity = 'Epic' },
										{ Name = 'RoomRewardBonus', Rarity = 'Common' },
										{ Name = 'OmegaPoseidonProjectile', Rarity = 'Epic' },
									},
								},
							},
							{
								Reward = 'HealDropMajor',
							},
							{
								Reward = 'RandomPom',
							},
						}
					},
					{
						Name = 'G_PreBoss01',
						Rewards = {
							{ Name = 'Boon', BoonGod = 'Hermes' }
						},
					},
					{
						Name = 'G_PreBoss01',
						Rewards = {
							{ Name = 'Boon', BoonGod = 'Hestia' }
						},
					},
				},
				{
					{
						Name = 'G_Boss01',
						BossName = 'Scylla',
						BossParameter = 'Scylla',
					}
				},
				{
					{
						Name = 'G_PostBoss01',
						IsForcedWell = true,
                    	WellContent = {
							{
								{Name = 'FirstHitHealTrait', Type = 'Trait'},
								{Name = 'MetaCardPointsCommonRange', Type = 'Consumable'},
								{Name = 'TemporaryForcedSecretDoorTrait', Type = 'Trait'},
							},
						},
					}
				}
            },
		},
		H = {
			Rooms = {
				{
					{
						Name = 'H_Intro',
						Encounter = 'Empty',
						StartPoint = '723141'
					}
				},
				{
					{
						Name = 'H_Combat13',
						Rewards = {
							{ 
								Name = 'Pom',
								LocationId = '621502',
							},
							{
								Name = 'Boon',
								BoonGod = 'Hermes',
								LocationId = '715356',
								Traits = {
									--The first traits are in dublon because they are rolled twice because the pom is taken first
									--and rewards are rerolled in the fields if they are not taken first (via CreateBoonLootButtons, one of the check is false and call SetTraitsOnLoot)
									{
										{ Name = 'HermesSpecial', Rarity = 'Common' },
										{ Name = 'SorcerySpeed', Rarity = 'Epic' },
										{ Name = 'SlowProjectile', Rarity = 'Common' },
									},
									{
										{ Name = 'HermesSpecial', Rarity = 'Common' },
										{ Name = 'SorcerySpeed', Rarity = 'Epic' },
										{ Name = 'SlowProjectile', Rarity = 'Common' },
									},
									{
										{ Name = 'HermesWeapon', Rarity = 'Common' },
										{ Name = 'MoneyMultiplier', Rarity = 'Epic' },
										{ Name = 'TimedKillBuff', Rarity = 'Common' },
									},
								},
							}
						},
						FieldsBonusRewards = {
							{ Name = 'MaxManaDropSmall', LocationId = '572849', },
							{ Name = 'RoomMoneyTinyDrop', LocationId = '736822', },
						},
						FieldsRewardsCount = 2,
						Encounters = {
							{
								
							},
							{
								ForceFigSkipEncounterNumber = 1,
								SpawnWaves = {
									{
										Spawns = {
											{ Name = 'Mage_Elite', Count = 5 },
											{ Name = 'Radiator',   Count = 1 },
											{ Name = 'Screamer',   Count = 5 },
										}
									}
								}
							},
							{
								
							}
						},
						--[[SpawnWaves = {
							{
								Spawns = {
									{ Name = 'Mage_Elite', Count = 5 },
									{ Name = 'Radiator',   Count = 1 },
									{ Name = 'Screamer',   Count = 5 },
								}
							}
						},]]

					}
				},
				{
					{
						Name = 'H_MiniBoss02',
						Rewards = {
							{
								Name = 'Boon',
								BoonGod = 'Poseidon',
								Traits = {
									--@todo
								},
							},
						},
					},
					{
						Name = 'H_Combat14',
						Rewards = {
							{ Name = 'RoomMoneyDrop' },
							{ Name = 'MaxHealthDrop' },
						},
						FieldsRewardsCount = 2,
					},
				},
			}
		},
		Chaos = {
			-- Chaos Rooms also have a RoomDepth index that is useless but make the code more generic
			Rooms = {
				{
					{
						Name = 'Chaos_03',
						GoldPots = {Count = 1},
						IsFlipped = true,
						Traits = {
							{
								{ BlessingName = 'Attack', BlessingValue = '1.205', CurseName = 'SecondaryAttack', CurseValue = '5', Duration = '4', Rarity = 'Rare' },
								{ BlessingName = 'Mana', BlessingValue = '32', CurseName = 'DeathWeapon', CurseValue = '',  Duration = '5', Rarity = 'Common' },
								{ BlessingName = 'Cast', BlessingValue = '1.33', CurseName = 'HiddenRoomReward', CurseValue = '',  Duration = '5', Rarity = 'Epic' },
							},
						},
					}
				},
			}
		}
	},
};