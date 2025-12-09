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
						Encounters = {
							{
								SpawnWaves = {
									{
										Spawns = {
											{ Name = 'Mage', Count = 1, SpawnOnIdKeys = {1} },
											{ Name = 'Brawler', Count = 2, SpawnOnIdKeys = {8,4} },
										},
										SpawnOrder = {'Mage', 'Brawler', 'Brawler'}
									}
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
						Encounters = {
							{
								SpawnWaves = {
									{
										Spawns = {
											{ Name = 'Mage', Count = 3, SpawnOnIdKeys = {1,5,7} },
											{ Name = 'Brawler', Count = 2, SpawnOnIdKeys = {17, 15} },
											
										},
										SpawnOrder = {'Mage', 'Mage', 'Mage', 'Brawler', 'Brawler'}
									}
								}
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
						Encounters = {
							{
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
							}
						}
					},
					{
						Name = 'F_Combat10',
						Rewards = {
							{
								Name = 'Pom'
							}
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
						Encounters = {
							{
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
						GoldPots = {Count = 1},
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
						Encounters = {
							{
								SpawnWaves = {
									{
										Spawns = {
											{ Name = 'Brawler',  Count = 4, SpawnOnIdKeys = {10,11,12,13,14} },
										},
										SpawnOrder = {'Brawler', 'Brawler', 'Brawler', 'Brawler'}
									},
									{
										Spawns = {
											{ Name = 'Brawler',  Count = 1, SpawnOnIdKeys = {11} },
											{ Name = 'Mage_Elite',  Count = 1, SpawnOnIdKeys = {12,13} },
										},
										SpawnOrder = {'Brawler', 'Mage_Elite'}
									},
									{
										Spawns = {
											{ Name = 'Brawler',  Count = 1, SpawnOnIdKeys = {12} },
											{ Name = 'SiegeVine',  Count = 2, SpawnOnIdKeys = {10,11} },
										},
										SpawnOrder = {'Brawler', 'SiegeVine', 'SiegeVine'}
									},
									{
										Spawns = {
											{ Name = 'Mage_Elite',  Count = 3, SpawnOnIdKeys = {10,11,12 } },
											{ Name = 'Brawler',  Count = 3, SpawnOnIdKeys = {13,14,15} },
										},
										SpawnOrder = {'Brawler', 'Mage_Elite',  'Mage_Elite', 'Brawler', 'Mage_Elite', 'Brawler'}
									}
								}
							}
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
							{ Name = 'MaxManaDrop' }
						},
					},
					{
						Name = 'F_Reprieve01',
						Rewards = {
							{ Name = 'Pom' }
						},
					},
				},
				{
					{
						Name = 'F_Combat02',
						Rewards = {
							{
								Name = 'Boon',
								BoonGod = 'Selene',
							}
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
						IsForcedWell = true,
						WellSpawnOnIdKey = 1,
						Encounters = {
							{
								SpawnWaves = {
									{
										Spawns = {
											{ Name = 'Mage_Elite', Count = 5 },
											{ Name = 'Radiator',   Count = 1 },
											{ Name = 'Screamer',   Count = 5 },
										},
										SpawnOrder = {'Mage_Elite', 'Mage_Elite',  'Mage_Elite', 'Mage_Elite', 'Mage_Elite', 'Radiator', 'Screamer','Screamer','Screamer','Screamer','Screamer'}
									}
								},
							}
						}
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
						}
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
						Encounters = {
							{
								SpawnWaves = {
									{
										Spawns = {
											{ Name = 'FishmanMelee', Count = 6, SpawnOnIdKeys = {1,2,3,4,5,6} },
										}
									}
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
						IsZagreusForced = true,
						IsNemesisForced = false,
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
							{ Name = 'Boon', BoonGod = 'Hestia' }
						}
					},
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
							{Name = 'Small', SpawnOnIdKey = 24},-- 24 small ok
							{Name = 'Small', SpawnOnIdKey = 30}, -- 30 ok
							{Name = 'Small', SpawnOnIdKey = 50}, -- this one contains
							{Name = 'Small', SpawnOnIdKey = 39}, -- 39 ok
							{Name = 'Medium', SpawnOnIdKey = 38}, -- 38 ok
							{Name = 'Large', SpawnOnIdKey = 10},
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
						Encounters = {
							{
								SpawnWaves = {
									{
										Spawns = {
											{ Name = 'FishSwarmerSquad_Elite', Count = 6, SpawnOnIdKeys = {13,14,15,16,17,18} }, 
											{ Name = 'Turtle_Elite', Count = 3, SpawnOnIdKeys = {5,6,7} },
										}
									}
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
								-- empty reward for the global room
							},
							{
								Name = 'Pom',
								LocationKeyId = 1,
								Traits = {
									{
										{ Name = 'HeraWeaponBoon' },
										{ Name = 'HeraSpecialBoon' },
										{ Name = 'AloneDamageBoon' },
									},
								}
							},
							{
								Name = 'Boon',
								BoonGod = 'Hermes',
								LocationKeyId = 2,
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
							{ Name = 'MaxManaDropSmall', LocationKeyId = 1, },
							{ Name = 'RoomMoneyTinyDrop', LocationKeyId = 2, },
						},
						FieldsRewardsCount = 2,
						ForceFigSkipEncounterNumber = 2,
						AthenaTraits = {
							{
								{ Name = 'ManaSpear', Rarity = 'Epic' },
								{ Name = 'InvulnerabilityCast', Rarity = 'Epic' },
								{ Name = 'DeathDefianceRefill', Rarity = 'Epic' },
							},
						},
						Encounters = {
							{
								SpawnWaves = {
									{
										Spawns = {
											{ Name = 'CorruptedShadeSmall', Count = 1 },
											{ Name = 'CorruptedShadeMedium', Count = 3 },
										},
									}
								}
							},
							{
								-- fig skipped
							},
							{
								SpawnWaves = {
									{
										Spawns = {
											{ Name = 'Lovesick', Count = 3, SpawnOnIdKeys = {42,2,37} },
											{ Name = 'BrokenHearted', Count = 7, SpawnOnIdKeys = {35,23,24,36,38,35,32} },
										},
										SpawnOrder = {'Lovesick', 'BrokenHearted', 'Lovesick', 'Lovesick', 'BrokenHearted', 'BrokenHearted', 'BrokenHearted', 'BrokenHearted', 'BrokenHearted', 'BrokenHearted'}
									}
								}
							},
						},
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
									{
										{ Name = 'Sprint', Rarity = 'Rare' },
										{ Name = 'FocusDamageShave', Rarity = 'Epic' },
										{ Name = 'MoneyDamage', Rarity = 'Duo' },
									},
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
					}
				},
				{
					{
						Name = 'H_Bridge01',
						Encounter = 'Story_Echo_01',
						Traits = { 'DiminishingHealthAndManaBoon', 'EchoDoubleLevelBoon', 'EchoLastReward'},
						Rewards = {
							{
								Name = 'Boon',
								BoonGod = 'Any', -- Needs to be Any to match any god Echo will spawn
								Traits = {
									-- Need to double the rewards for Echo (generated twice)
									{
										{ Name = 'Sprint', Rarity = 'Epic' },
										{ Name = 'OmegaPoseidonProjectile', Rarity = 'Common' },
										{ Name = 'FocusDamageShave', Rarity = 'Epic' },
									},
									{
										{ Name = 'Sprint', Rarity = 'Epic' },
										{ Name = 'OmegaPoseidonProjectile', Rarity = 'Common' },
										{ Name = 'FocusDamageShave', Rarity = 'Epic' },
									},
								},
							},
						},
					},
					-- There's need to be a room here or the game bugs, even though it should not be generated ...
					{
						Name = 'H_Combat14',
						FieldsRewardsCount = 2,
					}
				},
				{
					{
						Name = 'H_Combat11',
						FieldsRewardsCount = 3,
						Rewards = {
							{
								-- empty reward for the global room
							},
							{ Name = 'Pom' },
							{ Name = 'RoomMoneyDrop' },
							{ Name = 'MaxHealthDrop' },
						}
					},
					{
						Name = 'H_Combat11',
						IsFlipped = true,
						FieldsRewardsCount = 3,
						StartPoint = "755854", -- Right side of this room
						Rewards = {
							{
								-- empty reward for the global room
							},
							{ Name = 'MaxManaDrop', LocationKeyId = 3 },
							{
								Name = 'Boon',
								BoonGod = 'Zeus',
								Traits = {
									{
										{ Name = 'Sprint', Rarity = 'Common' },
										{ Name = 'CastAnywhere', Rarity = 'Common' },
										{ Name = 'FocusLightning', Rarity = 'Common' },
									},
								},
								LocationKeyId = 4
							},
							{
								Name = 'Boon',
								BoonGod = 'Selene',
								Traits = { 'Polymorph', 'Leap', 'Transform' },
								LocationKeyId = 1
							 },
						},
						FieldsBonusRewards = {
							{ Name = 'GiftDrop', LocationKeyId = 1 },
							{ Name = 'RoomMoneyTinyDrop', LocationKeyId = 2 },
						},
						Encounters = {
							{
								SpawnWaves = {
									{
										Spawns = {
											{ Name = 'CorruptedShadeSmall_Elite', Count = 3 },
											{ Name = 'CorruptedShadeMedium_Elite', Count = 2 },
											{ Name = 'CorruptedShadeLarge_Elite', Count = 1 },
										},
									}
								}
							},
							{
								SpawnWaves = {
									{
										Spawns = {
											{ Name = 'Screamer2', Count = 1 },
											{ Name = 'Lycanthrope', Count = 2 },
											
										},
										SpawnOrder = {'Screamer2', 'Lycanthrope', 'Lycanthrope'}
									}
								}
							},
							{
								SpawnWaves = {
									{
										Spawns = {
											{ Name = 'Lamia_Elite', Count = 1 },
											{ Name = 'Lycanthrope', Count = 2 },
											{ Name = 'Mourner', Count = 3 },
											
										},
										SpawnOrder = {'Lamia_Elite', 'Lycanthrope', 'Lycanthrope', 'Mourner', 'Mourner', 'Mourner'}
									}
								}
							},
							{
								SpawnWaves = {
									{
										Spawns = {
											{ Name = 'BrokenHearted', Count = 10 },
											{ Name = 'Lycanthrope', Count = 2 },
											{ Name = 'FogEmitter2', Count = 1 },
											
										},
										SpawnOrder = {'Lycanthrope', 'BrokenHearted', 'Lycanthrope', 'FogEmitter2', 'BrokenHearted', 'BrokenHearted', 'BrokenHearted', 'BrokenHearted', 'BrokenHearted', 'BrokenHearted', 'BrokenHearted', 'BrokenHearted', 'BrokenHearted'}
									}
								}
							}
						},
					}
				},
				{
					{
						Name = 'H_PreBoss01',
						IsZagreusForced = false,
						IsNemesisForced = false,
						ShopContent = {
							{
								Reward = 'Boon',
								BoonGod = 'Hera',
								Traits = {
									{
										{ Name = 'OmegaHeraProjectile', Rarity = 'Common' },
										{ Name = 'ElementalRarityUpgrade' },
										{ Name = 'DamageSharePotency', Rarity = 'Common' },
									},
								},
							},
							{
								Reward = 'MaxHealthDrop',
							},
							{
								Reward = 'TalentDrop',
							},
						}
					},
					{
						Name = 'H_PreBoss01',
						Rewards = {
							{ Name = 'MaxManaDrop' }
						},
					},
					-- There's need to be a room here or the game bugs, even though it should not be generated ...
					{
						Name = 'H_Combat14',
						FieldsRewardsCount = 2,
					}
				},
				{
					{
						Name = 'H_Boss01',
						BossName = 'Cerberus',
						BossParameter = 'CerberusSpawns05',
					},
					-- There's need to be a room here or the game bugs, even though it should not be generated ...
					{
						Name = 'H_Combat14',
						FieldsRewardsCount = 2,
					}
				},
				{
					{
						Name = 'H_PostBoss01',
                    	WellContent = {
							{
								{Name = 'TemporaryDoorHealTrait', Type = 'Trait'},
								{Name = 'LimitedSwapBonusTrait', Type = 'Trait'},
								{Name = 'TemporaryDiscountTrait', Type = 'Trait'},
							},
						},
						PurgingAltarContent = {
							{
								{Name = 'BurnExplodeBoon', Value = 45},
								{Name = 'ZeusSprintBoon', Value = 35},
								{Name = 'OmegaHeraProjectileBoon', Value = 45},
							},
						}
					}
				}
			}
		},
		I = {
			Rooms = {
				{
					{
						Name = 'I_Intro',
						Encounter = 'Empty',
					}
				},
				{
					{
						Name = 'I_Combat19',
						Encounter = 'GeneratedIChronosIntro',
						IsFlipped = true,
						GoldPots = {Count = 1},
						Encounters = {
							{
								SpawnWaves = {
									{
										Spawns = {
											{ Name = 'TimeElemental', Count = 3 },
											{ Name = 'GoldElemental', Count = 10 },
										},
										SpawnOrder = {'TimeElemental', 'GoldElemental', 'TimeElemental', 'TimeElemental'}
									}
								}
							}
						}
					}
				},
				{
					{
						Name = 'I_Combat06',
						IsFlipped = true,
						Encounters = {
							{
								SpawnWaves = {
									{
										Spawns = {
											{ Name = 'TimeElemental_Elite', Count = 3 },
											{ Name = 'SatyrRatCatcher', Count = 1 },
										},
									},
									{
										Spawns = {
											{ Name = 'SatyrRatCatcher', Count = 2 },
										},
									},
								}
							}
						}
					}
				},
				{
					{
						Name = 'I_Combat22',
						IsForcedWell = true,
						IsFlipped = true,
						Encounters = {
							{
								SpawnWaves = {
									{
										Spawns = {
											{ Name = 'SatyrLancer_Elite', Count = 2 },
										},
									},
									{
										Spawns = {
											{ Name = 'SatyrLancer_Elite', Count = 1 },
											{ Name = 'SatyrRatCatcher_Elite', Count = 1 },
										},
									}
								}
							}
						}
					}
				},
				{
					{
						Name = 'I_Combat01',
						GoldPots = {Count = 1},
						IsFlipped = true,
						Encounters = {
							{
								SpawnWaves = {
									{
										Spawns = {
											{ Name = 'SwarmerClockwork_Elite', Count = 4 },
										},
									},
									{
										Spawns = {
											{ Name = 'SatyrLancer', Count = 1 },
											{ Name = 'SwarmerClockwork_Elite', Count = 2 },
										},
									},
									{
										Spawns = {
											{ Name = 'SwarmerClockwork_Elite', Count = 4 },
											{ Name = 'TimeElemental_Elite', Count = 2 },
											{ Name = 'GoldElemental', Count = 1 },
										},
									},
									
								}
							}
						}
					},
					{
						Name = 'I_Story01',
					},
				},
				{
					{
						Name = 'I_Combat04',
						IsFlipped = true,
						ForceFigSkipEncounterNumber = 1,
						Encounters = {
							{
								-- Fig skipped
							}
						}
					},
					{
						Name = 'I_MiniBoss01',
						Rewards = {
							{
								Name = 'Boon',
								BoonGod = 'Zeus',
							}
						},
					},
				},
				{
					{
						Name = 'I_PreBoss02',
						ShopContent = {
							-- from top to bottom: double health / random reward / Hera forte / Hermes (fort? 350po) / Nightmare
							{
								Reward = 'BoostedBoon',
								BoonGod = 'Hera',
								Traits = {
									{
										{ Name = 'Sprint', Rarity = 'Epic' },
										{ Name = 'LinkedDeathDamage', Rarity = 'Rare' },
										{ Name = 'ManaRestoreDamage', Rarity = 'Duo' },
									}
								},
							},
							{
								Reward = 'RandomBoon',
								BoonGod = 'Zeus',
								Traits = {
									{
										{ Name = 'Sprint', Rarity = 'Epic' },
										{ Name = 'ZeusManaBoltBoon', Rarity = 'Epic' },
										{ Name = 'ElementalDamageFloor' },
									},
									{
										{ Name = 'Sprint', Rarity = 'Common' },
										{ Name = 'FocusLightning', Rarity = 'Common' },
										{ Name = 'SuperSacrificeBoonZeus', Rarity = 'Duo' },
									},
								},
							},
							{ Reward = 'HealBigDrop'},
							{
								Reward = 'BoostedBoon',
								BoonGod = 'Hermes',
							},
							{
								Reward = 'WeaponPointsRareDrop',
							},
						}
					},
					{
						Name = 'I_MiniBoss01',
						Rewards = {
							{
								Name = 'Boon',
								BoonGod = 'Hera',
							}
						},
					},
				},
				{
					{
						Name = 'I_Boss01',
						BossName = 'Chronos',
						--BossParameter = '',
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