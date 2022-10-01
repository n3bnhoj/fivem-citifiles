fx_version 'adamant'

game 'gta5'
lua54        'yes'
description 'ESX Mechanic Job'

version '1.7.5'


shared_scripts {
	'@ox_lib/init.lua',
	'@es_extended/imports.lua',
}
client_scripts {
	'@es_extended/locale.lua',
	'locales/*.lua',
	'config.lua',
	'client/main.lua'
}

server_scripts {
	'@es_extended/locale.lua',
	'locales/*.lua',
	'config.lua',
	'server/main.lua'
}

dependencies {
	'es_extended',
	'esx_society',
	'esx_billing'
}
