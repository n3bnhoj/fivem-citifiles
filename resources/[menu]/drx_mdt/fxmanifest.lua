fx_version 'adamant'

game 'gta5'

ui_page 'client/html/index.html'

shared_scripts {
	'@es_extended/imports.lua',
	'Config.lua'
}

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'server/server.lua'
}

client_scripts {
	'client/functions.lua',
	'client/client.lua'
}

files {
	'client/html/images/*',
	'client/html/index.html',
	'client/html/style.css',
	'client/html/javascript.js',
}