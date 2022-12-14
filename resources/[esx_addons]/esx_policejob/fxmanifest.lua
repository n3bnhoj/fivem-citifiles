fx_version 'adamant'

game 'gta5'
lua54        'yes'
description 'ESX Police Job'

version '1.7.5'
shared_scripts {
	'@ox_lib/init.lua',
	'@es_extended/imports.lua',
}


server_scripts {
	'@oxmysql/lib/MySQL.lua',
	'@es_extended/locale.lua',
	'locales/*.lua',
	'config.lua',
	'server/main.lua'
}

client_scripts {
	'@es_extended/locale.lua',
	'locales/*.lua',
	'config.lua',
	'client/main.lua',
	'client/vehicle.lua'
}

dependencies {
	'es_extended',
	'esx_billing',
	'esx_vehicleshop'
}
