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
						Name = 'F_Opening01',
						Encounter = 'OpeningGeneratedF',
						Rewards = {
							{
								Name = 'Boon',
								BoonGod = 'Poseidon',
								Traits = {
									{
										{ Name = 'Cast', Rarity = 'Epic' },
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
											{ Name = 'Brawler', Count = 1, SpawnOnIdKeys = {1} },
											{ Name = 'Screamer', Count = 2, SpawnOnIdKeys = {2,3} },
										}
									}
								}
							}
						}
					}
				},
				{
					{
						Name = 'F_Combat04',
						Rewards = {
							{ Name = 'GiftDrop' }
						},
						Encounters = {
							{
								SpawnWaves = {
									{
										Spawns = {
											{ Name = 'Brawler', Count = 3, SpawnOnIdKeys = {5,6,7} },
											{ Name = 'Screamer', Count = 2, SpawnOnIdKeys = {8,9} },
										},
										SpawnOrder = {'Brawler', 'Brawler', 'Brawler', 'Screamer','Screamer'}
									}
								}
							}
						}
					},
				},
				{
					{
						Name = 'F_Combat09',
						GoldPots = {Count = 1},
						Rewards = {
							{
								Name = 'Hammer',
								Traits = {'AxeSecondStageTrait', 'AxeSpinSpeedTrait', 'AxeMassiveThirdStrikeTrait'}
							}
						},
						Encounters = {
							{
								SpawnWaves = {
									{
										Spawns = {
											{ Name = 'SiegeVine', Count = 1, SpawnOnIdKeys = {6} },
											{ Name = 'Brawler', Count = 4, SpawnOnIdKeys = {4,5,7} },
										},
										SpawnOrder = {'SiegeVine', 'Brawler', 'Brawler', 'Brawler', 'Brawler'}
									}
								}
							}
						},
						IsForcedChaos = true,
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
					-- Chaos skipped
					{
						Name = 'F_Combat04',
						Rewards = {
							{ Name = 'MetaCurrencyDrop' }
						},
					},
					{
						Name = 'F_Combat04',
						Rewards = {
							{ Name = 'MetaCardPointsCommonDrop' }
						},
					}
				},
				{
					{
						Name = 'F_Combat09',
						Rewards = {
							{ Name = 'MetaCurrencyDrop' }
						},
					},
					{
						Name = 'F_Combat05',
						StartPoint = 50065,
						Encounter = 'ArachneCombatF',
						Rewards = {
							{ Name = 'GiftDrop' }
						},
						Cocoons = {
							{Name = 'Small', SpawnOnIdKey = 2},
							{Name = 'Small', SpawnOnIdKey = 7},
							{Name = 'Small', SpawnOnIdKey = 9},
							{Name = 'Small', SpawnOnIdKey = 1},
							{Name = 'Small', SpawnOnIdKey = 3},
							{Name = 'Medium', SpawnOnIdKey = 4},
							{Name = 'Medium', SpawnOnIdKey = 5},
						}
					},
				},
				{
					{
						Name = 'F_Story01',
						Traits = { 'CastDamageCostume', 'ManaCostume', 'AgilityCostume'},
					},
					{
						Name = 'F_MiniBoss01',
						Rewards = {
							{ Name = 'Boon', BoonGod = 'Demeter' }
						},
					},
				},
				{
					{
						Name = 'F_Shop01',
						GoldPots = {Count = 2},
						IsNemesisForced = false,
						IsZagreusForced = false,
						ShopContent = {
							{
								Reward = 'Boon',
								BoonGod = 'Apollo',
								Traits = {
									{
										{ Name = 'Special', Rarity = 'Epic' },
										{ Name = 'Attack', Rarity = 'Common' },
										{ Name = 'Sprint', Rarity = 'Common' },
									},
								},
							},
							{
								Reward = 'RandomBoon',
								BoonGod = 'Demeter',
								Traits = {
									{
										{ Name = 'CastNova', Rarity = 'Epic' },
										{ Name = 'Attack', Rarity = 'Common' },
										{ Name = 'Special', Rarity = 'Common' },
									},
								},
							},
							{
								Reward = 'RandomPom',
							}
						}
					},
					{
						Name = 'F_MiniBoss02',
						Rewards = {
							{ Name = 'Boon', BoonGod = 'Demeter' }
						},
					},
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
										{ Name = 'Attack', Rarity = 'Common' },
										{ Name = 'SpawnCastDamage', Rarity = 'Epic' },
										{ Name = 'OmegaHeraProjectile', Rarity = 'Common' },
									},
								},
							}
						},
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
						Name = 'F_Combat07',
						Encounter = 'ArtemisCombatF',
						Rewards = {
							{ Name = 'RoomMoneyDrop' }
						},
						GoldPots = {Count = 2},
						IsForcedWell = true,
						WellSpawnOnIdKey = 1,
						WellContent = {
							{
								{Name = 'ArmorBoostStore', Type = 'Consumable'},
								{Name = 'TemporaryImprovedExTrait', Type = 'Trait'},
								{Name = 'TemporaryForcedSecretDoorTrait', Type = 'Trait'},
							}
						},
						ArtemisTraits = {
							{
								{ Name = 'HighHealthCrit', Rarity = 'Epic' },
								{ Name = 'FocusCrit', Rarity = 'Common' },
								{ Name = 'CritBonus', Rarity = 'Common' },
							}
						},
					},
				},
				{
					{
						Name = 'F_Combat14',
						Rewards = {
							{ Name = 'MaxHealthDrop' }
						},
					},
					{
						Name = 'F_Reprieve01',
						Rewards = {
							{ Name = 'RoomMoneyDrop' }
						},
					},
				},
				{
					-- Chaos skip
					{
						Name = 'F_Combat14',
						Rewards = {
							{ Name = 'MetaCurrencyDrop' }
						},
					},
					{
						Name = 'F_Combat14',
						Rewards = {
							{ Name = 'MetaCardPointsCommonDrop' }
						},
					},
				},
				{
					{
						Name = 'F_PreBoss01',
						ShopContent = {
							{
								Reward = 'Boon',
								BoonGod = 'Apollo',
								Traits = {
									{
										{ Name = 'Sprint', Rarity = 'Epic' },
										{ Name = 'Mana', Rarity = 'Common' },
										{ Name = 'Attack', Rarity = 'Common' },
									}
								},
							},
							{ Reward = 'HealDropMajor' },
							{ Reward = 'MaxManaDrop' }
						}
					},
					{
						Name = 'F_PreBoss01',
						Rewards = {
							{ Name = 'Boon', BoonGod = 'Demeter' }
						},
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
								{Name = 'TemporaryForcedSecretDoorTrait', Type = 'Trait'},
								{Name = 'LimitedManaRegenDrop', Type = 'Consumable'},
							}
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
						GoldPots = {Count = 1},
					}
				},
				{
					-- Chaos skipped
					{
						Name = 'G_Combat01',
						Rewards = {
							{ Name = 'MetaCardPointsCommonDrop' }
						},
					}
				},
				{
					{
						Name = 'G_Combat08',
						StartPoint = 50065,
						Rewards = {
							{ Name = 'GiftDrop' }
						},
						Encounter = 'ArachneCombatG',
						Cocoons = {
							{Name = 'Small', SpawnOnIdKey = 10},
							{Name = 'Small', SpawnOnIdKey = 3},
							{Name = 'Small', SpawnOnIdKey = 8},
							{Name = 'Small', SpawnOnIdKey = 9},
							{Name = 'Small', SpawnOnIdKey = 13},
							{Name = 'Medium', SpawnOnIdKey = 14},
							{Name = 'Large', SpawnOnIdKey = 15},
						},
					},
					{
						Name = 'G_Combat01',
						Rewards = {
							{ Name = 'MetaCurrencyDrop' }
						},
					}
				},
				{
					{
						Name = 'G_MiniBoss01',
						Rewards = {
							{ Name = 'Boon', BoonGod = 'Hestia' }
						}
					},
					{
						Name = 'G_Shop01',
						IsZagreusForced = true,
						IsNemesisForced = false,
						IsFlipped = true,
						ShopContent = {
							{
								Reward = 'RandomBoon',
								BoonGod = 'Apollo',
								Traits = {
									{
										{ Name = 'CastNova', Rarity = 'Epic' },
										{ Name = 'Attack', Rarity = 'Common' },
										{ Name = 'Special', Rarity = 'Common' },
									},
								},
							},
							{ Reward = 'MetaCurrencyDrop' },
							{ Reward = 'MaxManaDrop' },
						}
					},
				},
				{
					{
						Name = 'G_Story01',
						-- Don't bothered with narcissus forced reward
					},
					{
						Name = 'G_MiniBoss02',
						Rewards = {
							{ Name = 'Boon', BoonGod = 'Demeter' }
						}
					},
				},
				{
					{
						Name = 'G_MiniBoss03',
						Rewards = {
							{
								Name = 'Boon',
								BoonGod = 'Apollo',
								Traits = {
									{
										{ Name = 'DoubleExManaBoon', Rarity = 'Legendary' },
										{ Name = 'Mana', Rarity = 'Common' },
										{ Name = 'Attack', Rarity = 'Common' },
									},
								},
							}
						},
					},
				},
				{
					{
						Name = 'G_Reprieve01',
						Rewards = {
							{ Name = 'MetaCurrencyDrop' }
						}
					},
					{
						Name = 'G_Reprieve01',
						Rewards = {
							{ Name = 'MetaCardPointsCommonDrop' }
						}
					},
				},
				{
					{
						Name = 'G_Combat10',
						ForceFigSkipEncounterNumber = 1,
						Rewards = {
							{
								Name = 'Boon',
								BoonGod = 'Hermes',
								Traits = {
									{
										{ Name = 'HermesSpecial', Rarity = 'Epic' },
										{ Name = 'SorcerySpeed', Rarity = 'Common' },
										{ Name = 'SlowProjectile', Rarity = 'Common' },
									}
								},
							}
						}
					},
					{
						Name = 'G_Combat10',
						ForceFigSkipEncounterNumber = 1,
						Rewards = {
							{ Name = 'Boon', BoonGod = 'Demeter' }
						}
					},
				},
				{
					{
						Name = 'G_PreBoss01',
						ShopContent = {
							{
								Reward = 'Boon',
								BoonGod = 'Poseidon',
								Traits = {
									{
										{ Name = 'Attack', Rarity = 'Common' },
										{ Name = 'PoseidonExCast', Rarity = 'Epic' },
										{ Name = 'DoubleRewardBoon', Rarity = 'Common' },
									},
								},
							},
							{ Reward = 'HealDropMajor' },
							{ Reward = 'MaxManaDrop' }
						}
					},
					{
						Name = 'G_PreBoss01',
						Rewards = {
							{ Name = 'Boon', BoonGod = 'Demeter' }
						},
					},
					{
						Name = 'G_PreBoss01',
						Rewards = {
							{ Name = 'Boon', BoonGod = 'Hermes' }
						},
					},
				},
				{
					{
						Name = 'G_Boss01',
						BossName = 'Scylla',
						BossParameter = 'Drummer',
					}
				},
				{
					{
						Name = 'G_PostBoss01',
                    	WellContent = {
							{
								{Name = 'ArmorBoostStore', Type = 'Consumable'},
								{Name = 'TemporaryImprovedExTrait', Type = 'Trait'},
								{Name = 'MetaCardPointsCommonRange', Type = 'Consumable'},
							},
						},
					}
				}
			}
		},
		H = {
			Rooms = {
				--[[{
					{
						Name = 'H_Intro',
						Encounter = 'Empty',
						StartPoint = '621442'
					}
				},
				{
					{
						Name = 'H_Combat15',
						Rewards = {
							{},
							{
								Name = 'Boon',
								BoonGod = 'Hermes',
								LocationKeyId = 1,
								Traits = {
									{
										{ Name = 'LuckyBoon', Rarity = 'Epic' },
										{ Name = 'RestockBoon', Rarity = 'Common' },
										{ Name = 'TimedKillBuff', Rarity = 'Common' },
									},
									{
										{ Name = 'LuckyBoon', Rarity = 'Epic' },
										{ Name = 'RestockBoon', Rarity = 'Common' },
										{ Name = 'TimedKillBuff', Rarity = 'Common' },
									},
								},
							},
							{
								Name = 'Pom',
								LocationKeyId = 2,
							},
						},
						FieldsBonusRewards = {
							{ Name = 'MaxManaDropSmall', LocationKeyId = 1, },
						},
						FieldsRewardsCount = 2,
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
								SpawnWaves = {
									{
										Spawns = {
											{ Name = 'Mourner', Count = 3, SpawnOnIdKeys = {6,7,8} },
											{ Name = 'BrokenHearted', Count = 1, SpawnOnIdKeys = {9} },
										},
										SpawnOrder = {'Mourner', 'Mourner', 'Mourner', 'BrokenHearted' }
									}
								}
							},
							{
								SpawnWaves = {
									{
										Spawns = {
											{ Name = 'Mourner', Count = 2, SpawnOnIdKeys = {25,26} },
											{ Name = 'Lamia', Count = 3, SpawnOnIdKeys = {27,28,29} },
										},
										SpawnOrder = {'Mourner', 'Mourner', 'Lamia', 'Lamia', 'Lamia'}
									}
								}
							},
						},
					}
				},--]]
				{
					{
						Name = 'H_MiniBoss02',
						Rewards = {
							{
								Name = 'Boon',
								BoonGod = 'Poseidon',
								Traits = {
									{
										{ Name = 'Attack', Rarity = 'Common' },
										{ Name = 'FocusDamageShave', Rarity = 'Common' },
										{ Name = 'Mana', Rarity = 'Epic' },
									},
								},
							},
						},
					},
					{
						Name = 'H_MiniBoss01',
						Rewards = {
							{
								Name = 'Boon',
								BoonGod = 'Demeter',
							}
						}
					}
				},
				{
					{
						Name = 'H_Bridge01',
						Encounter = 'Story_Echo_01',
						Traits = { 'EchoRepeatKeepsakeBoon', 'EchoDoubleLevelBoon', 'EchoLastReward'},
					},
				},
				{
					{
						Name = 'H_Combat01',
						FieldsRewardsCount = 2,
						Rewards = {
							{},
							{ Name = 'RoomMoneyDrop' },
							{ Name = 'MaxHealthDrop' },
						}
					},
					{
						Name = 'H_Combat12',
						FieldsRewardsCount = 2,
						ForceFigSkipEncounterNumber = 3,
						Rewards = {
							{},
							{
								Name = 'Hammer',
								Traits = { 'AxeChargedSpecialTrait', 'AxeMassiveThirdStrikeTrait', 'AxeRangedWhirlwindTrait' },
								LocationKeyId = 1
							},
							{
								Name = 'Boon',
								BoonGod = 'Apollo',
								Traits = {
									{
										{ Name = 'CastArea', Rarity = 'Epic' },
										{ Name = 'Attack', Rarity = 'Common' },
										{ Name = 'FocusLightning', Rarity = 'Common' },
									},
								},
								LocationKeyId = 2
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
											{ Name = 'CorruptedShadeMedium_Elite', Count = 3 },
										},
									}
								}
							},
							{
								SpawnWaves = {
									{
										Spawns = {
											{ Name = 'Treant2', Count = 1, SpawnOnIdKeys = {165} },
											{ Name = 'FogEmitter2', Count = 1, SpawnOnIdKeys = {179} },
											
										},
										SpawnOrder = {'Treant2', 'FogEmitter2'}
									}
								}
							},
							{
								-- fig skipped
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
										{ Name = 'DamageSharePotency', Rarity = 'Epic' },
										{ Name = 'OmegaHeraProjectile', Rarity = 'Common' },
										{ Name = 'Attack' },
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
				},
				{
					{
						Name = 'H_Boss01',
						BossName = 'Cerberus',
						BossParameter = 'CerberusSpawns02',
					},
				},
				{
					{
						Name = 'H_PostBoss01',
                    	WellContent = {
							{
								{Name = 'TemporaryDoorHealTrait', Type = 'Trait'},
								{Name = 'ArmorBoostStore', Type = 'Consumable'},
								{Name = 'TemporaryImprovedExTrait', Type = 'Trait'},
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
						Name = 'I_Combat24',
						Encounter = 'GeneratedIChronosIntro',
						ForceFigSkipEncounterNumber = 1,
					}
				},
				{
					{
						Name = 'I_Combat21',
						Encounters = {
							{
								SpawnWaves = {
									{
										Spawns = {
											{ Name = 'GoldElemental_Elite', Count = 3 },
											{ Name = 'ClockworkHeavyMelee_Elite', Count = 1 },
										},
									}
								}
							}
						}
					},
				},
				{
					{
						Name = 'I_Story01',
					},
					{
						Name = 'I_Combat16',
						Encounters = {
							{
								SpawnWaves = {
									{
										Spawns = {
											{ Name = 'TimeElemental_Elite', Count = 1 },
											{ Name = 'ClockworkHeavyMelee_Elite', Count = 2 },
										},
									}
								}
							}
						}
					},
				},
				{
					{
						Name = 'I_Combat02',
						Encounters = {
							{
								SpawnWaves = {
									{
										Spawns = {
											{ Name = 'GoldElemental_Elite', Count = 1 },
											{ Name = 'ClockworkHeavyMelee_Elite', Count = 2 },
										},
									},
									{
										Spawns = {
											{ Name = 'SatyrLancer', Count = 1 },
											{ Name = 'ClockworkHeavyMelee_Elite', Count = 1 },
										},
									}
								}
							}
						}
					},
				},
				{
					{
						Name = 'I_Combat15',
						Encounter = 'NemesisCombatI',
					},
				},
				{
					{
						Name = 'I_PreBoss02',
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
			-- 1 is bad, 2 is fast losange-square in middle, 3 is medium double dash to reach, 4 fast-medium, 5 is super-fast, 6 is super-fast
			Rooms = {
				{
					{
						Name = 'Chaos_05',
						IsFlipped = true,
						Traits = {
							{
								{ BlessingName = 'ExSpeed', BlessingValue = '1', CurseName = 'Damage', CurseValue = '', Duration = '3', Rarity = 'Epic' },
								{ BlessingName = 'Mana', BlessingValue = '32', CurseName = 'DeathWeapon', CurseValue = '',  Duration = '5', Rarity = 'Common' },
								{ BlessingName = 'Cast', BlessingValue = '1.33', CurseName = 'HiddenRoomReward', CurseValue = '',  Duration = '5', Rarity = 'Common' },
							},
						},
					},
					{
						Name = 'Chaos_06',
						IsFlipped = true,
						Traits = {
							{
								{ BlessingName = 'Cast', BlessingValue = '1.5', CurseName = 'Time', CurseValue = '', Duration = '2', Rarity = 'Epic' },
								{ BlessingName = 'Mana', BlessingValue = '32', CurseName = 'DeathWeapon', CurseValue = '',  Duration = '5', Rarity = 'Common' },
								{ BlessingName = 'Attack', BlessingValue = '1.33', CurseName = 'HiddenRoomReward', CurseValue = '',  Duration = '5', Rarity = 'Common' }, 
								
							},
						},
					},
					{
						Name = 'Chaos_03',
						IsFlipped = true,
						Traits = {
							{
								{ BlessingName = 'Special', BlessingValue = '1.6', CurseName = 'PrimaryAttack', CurseValue = '', Duration = '3', Rarity = 'Epic' },
								{ BlessingName = 'Mana', BlessingValue = '32', CurseName = 'DeathWeapon', CurseValue = '',  Duration = '5', Rarity = 'Common' },
								{ BlessingName = 'Cast', BlessingValue = '1.33', CurseName = 'HiddenRoomReward', CurseValue = '',  Duration = '5', Rarity = 'Common' },
							},
						},
					}
				},
			}
		}
	},
};