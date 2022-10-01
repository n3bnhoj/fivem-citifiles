fx_version 'cerulean'

game 'gta5'

ui_page 'html/index.html'

files {
	'html/index.html',
	'html/styles.css',
	'html/scripts.js',
	'html/img/*.png',
}

shared_script '@es_extended/imports.lua'

-- server_script 'server.lua'

client_script {
	'config.lua',
	'client.lua'	
}