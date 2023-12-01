

fx_version 'cerulean'
game 'gta5' 


author 'RealVezqo'
description 'DiscordRPC'
version '1.2.5'

shared_script 'config.lua'
client_script {
	'client/main.lua'
}

server_script{
	'@oxmysql/lib/MySQL.lua',
	'server/main.lua'
}
