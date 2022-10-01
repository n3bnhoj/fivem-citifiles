fx_version 'bodacious'
game 'gta5'
description 'ESX Admin commands'

shared_scripts {
    '@es_extended/locale.lua',
    'locales/en.lua',
    'config.lua'
}

client_script {		

	'client.lua',

}
server_scripts {		
	'@mysql-async/lib/MySQL.lua',
	'server.lua',

}

dependency "es_extended"
