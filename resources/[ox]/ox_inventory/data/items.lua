return {
	['testburger'] = {
		label = 'Test Burger',
		weight = 220,
		degrade = 60,
		client = {
			status = { hunger = 200000 },
			anim = 'eating',
			prop = 'burger',
			usetime = 2500,
			export = 'ox_inventory_examples.testburger'
		},
		server = {
			export = 'ox_inventory_examples.testburger',
			test = 'what an amazingly delicious burger, amirite?'
		},
		buttons = {
			{
				label = 'Lick it',
				action = function(slot)
					print('You licked the burger')
				end
			},
			{
				label = 'Squeeze it',
				action = function(slot)
					print('You squeezed the burger :(')
				end
			}
		}
	},

	['bandage'] = {
		label = 'Bandage',
		weight = 115,
		client = {
			anim = { dict = 'missheistdockssetup1clipboard@idle_a', clip = 'idle_a', flag = 49 },
			prop = { model = `prop_rolled_sock_02`, pos = vec3(-0.14, -0.14, -0.08), rot = vec3(-50.0, -50.0, 0.0) },
			disable = { move = true, car = true, combat = true },
			usetime = 2500,
		}
	},

	['black_money'] = {
		label = 'Dirty Money',
	},

	['burger'] = {
		label = 'Burger',
		weight = 220,
		client = {
			status = { hunger = 200000 },
			anim = 'eating',
			prop = 'burger',
			usetime = 12500,
			notification = 'You ate a delicious burger'
		},
	},

	['cola'] = {
		label = 'eCola',
		weight = 350,
		client = {
			status = { thirst = 200000 },
			anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
			prop = { model = `prop_ecola_can`, pos = vec3(0.01, 0.01, 0.06), rot = vec3(5.0, 5.0, -180.5) },
			usetime = 2500,
			notification = 'You quenched your thirst with cola'
		}
	},

	['parachute'] = {
		label = 'Parachute',
		weight = 8000,
		stack = false,
		client = {
			anim = { dict = 'clothingshirt', clip = 'try_shirt_positive_d' },
			usetime = 1500
		}
	},

	['garbage'] = {
		label = 'Garbage',
	},

	['paperbag'] = {
		label = 'Paper Bag',
		weight = 1,
		stack = false,
		close = false,
		consume = 0
	},

	['identification'] = {
		label = 'Identification',
	},

	['panties'] = {
		label = 'Knickers',
		weight = 10,
		consume = 0,
		client = {
			status = { thirst = -100000, stress = -25000 },
			anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
			prop = { model = `prop_cs_panties_02`, pos = vec3(0.03, 0.0, 0.02), rot = vec3(0.0, -13.5, -1.5) },
			usetime = 2500,
		}
	},

	['lockpick'] = {
		label = 'Lockpick',
		weight = 160,
		consume = 0,
	
	},


	['phone'] = {
		label = 'Phone',
		weight = 190,
		stack = false,
		consume = 0,
        client = {
            usetime = 500,

        },

    },
	['money'] = {
		label = 'Money',
	},

	['mustard'] = {
		label = 'Mustard',
		weight = 500,
		client = {
			status = { hunger = 25000, thirst = 25000 },
			anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
			prop = { model = `prop_food_mustard`, pos = vec3(0.01, 0.0, -0.07), rot = vec3(1.0, 1.0, -1.5) },
			usetime = 2500,
			notification = 'You.. drank mustard'
		}
	},

	['water'] = {
		label = 'Water',
		weight = 500,
		client = {
			status = { thirst = 200000 },
			anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
			prop = { model = `prop_ld_flow_bottle`, pos = vec3(0.03, 0.03, 0.02), rot = vec3(0.0, 0.0, -1.5) },
			usetime = 12500,
			cancel = true,
			notification = 'You drank some refreshing water'
		}
	},

	['radio'] = {
		label = 'Radio',
		weight = 1000,
		stack = false,
		consume = 0,
		allowArmed = true
	},

	['armour'] = {
		label = 'Bulletproof Vest',
		weight = 3000,
		stack = false,
		client = {
			anim = { dict = 'clothingshirt', clip = 'try_shirt_positive_d' },
            usetime = 3500
		}
	},

	['bread'] = {
		label = 'bread',
		weight = 1,
		stack = true,
		close = true,
		description = nil
	},

	['medikit'] = {
		label = 'medikit',
		weight = 2,
		stack = true,
		close = true,
		description = nil
	},

	['blowpipe'] = {
		label = 'blowtorch',
		weight = 2,
		stack = true,
		close = true,
		description = nil
	},

	['carokit'] = {
		label = 'body kit',
		weight = 3,
		stack = true,
		close = true,
		description = nil
	},

	['carotool'] = {
		label = 'tools',
		weight = 2,
		stack = true,
		close = true,
		description = nil
	},

	['fixkit'] = {
		label = 'repair kit',
		weight = 3,
		stack = true,
		close = true,
		description = nil
	},

	['fixtool'] = {
		label = 'repair tools',
		weight = 2,
		stack = true,
		close = true,
		description = nil
	},

	['gazbottle'] = {
		label = 'gas bottle',
		weight = 2,
		stack = true,
		close = true,
		description = nil
	},

	['bombdefuser'] = {
		label = 'bomb pliers',
		weight = 1,
		stack = true,
		close = true,
		description = nil
	},

	['bombvest'] = {
		label = 'bomb vest',
		weight = 1,
		stack = true,
		close = true,
		description = nil
	},

	['cocacola'] = {
		label = 'cocacola',
		weight = 1,
		stack = true,
		close = true,
		description = nil
	},

	['mining_copperbar'] = {
		label = 'copper bar',
		weight = 1,
		stack = true,
		close = true,
		description = nil
	},

	['mining_copperfragment'] = {
		label = 'copper fragment',
		weight = 1,
		stack = true,
		close = true,
		description = nil
	},

	['mining_goldbar'] = {
		label = 'gold bar',
		weight = 1,
		stack = true,
		close = true,
		description = nil
	},

	['mining_goldnugget'] = {
		label = 'gold nugget',
		weight = 1,
		stack = true,
		close = true,
		description = nil
	},

	['mining_ironbar'] = {
		label = 'iron bar',
		weight = 1,
		stack = true,
		close = true,
		description = nil
	},

	['mining_ironfragment'] = {
		label = 'iron nugget',
		weight = 1,
		stack = true,
		close = true,
		description = nil
	},

	['mining_pan'] = {
		label = 'pan',
		weight = 1,
		stack = true,
		close = true,
		description = nil
	},

	['mining_pickaxe'] = {
		label = 'pickaxe',
		weight = 1,
		stack = true,
		close = true,
		description = nil
	},

	['mining_stone'] = {
		label = 'dirty stone ',
		weight = 1,
		stack = true,
		close = true,
		description = nil
	},

	['mining_washedstone'] = {
		label = 'washed stone',
		weight = 1,
		stack = true,
		close = true,
		description = nil
	},

	['snicker'] = {
		label = 'snicker',
		weight = 1,
		stack = true,
		close = true,
		description = nil
	},

	['sprite'] = {
		label = 'sprite',
		weight = 1,
		stack = true,
		close = true,
		description = nil
	},

	['tree_bark'] = {
		label = 'tree_bark',
		weight = 1,
		stack = true,
		close = true,
		description = nil
	},

	['tree_lumber'] = {
		label = 'tree_lumber',
		weight = 1,
		stack = true,
		close = true,
		description = nil
	},

	['wood_plank '] = {
		label = 'wood_plank ',
		weight = 1,
		stack = true,
		close = true,
		description = nil
	},
}