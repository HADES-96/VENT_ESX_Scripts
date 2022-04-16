fx_version 'adamant'

game 'gta5'

description 'ESX Vehicle Theft'

Author 'Human Tree92 | Velociti Entertainment'

version 'legacy'

shared_script '@es_extended/imports.lua'

server_scripts {
    '@es_extended/locale.lua',
	'locales/*.lua',
	'config.lua',
	'server/main.lua'
}

client_scripts {
	'@es_extended/locale.lua',
	'locales/*.lua',
	'config.lua',
	'client/main.lua'
}

dependencies {
	'es_extended'
}