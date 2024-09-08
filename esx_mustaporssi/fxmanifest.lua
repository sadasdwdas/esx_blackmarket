shared_script '@cgac/shared/entity-ai.lua'
shared_script '@cgac/shared/safe-events.lua'
fx_version 'cerulean'
game 'gta5'

lua54 'yes'

author 'Laiffi'
description 'Mustaporssi scripti by: Laiffi StalkerRP'
version '1.0.0'

shared_script 'config.lua'
shared_script '@ox_lib/init.lua'

client_script 'client.lua'
server_script 'server.lua'

dependencies {
    'ox_target',
    'es_extended'
}
