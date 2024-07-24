fx_version "cerulean"
lua54 "yes"
game "gta5"

author "DevJacob"
description "Simple and efficient implementation of a callback manager"
version "1.0.1"

dependencies {
	"DevJacob_CommonLib"
}

client_scripts {
	"@DevJacob_CommonLib/lib/client.lua",
	"client/main.lua"
}

server_scripts {
	"@DevJacob_CommonLib/lib/server.lua",
	"server/main.lua"
}

--[[
	Example Import:
	CallbackManager = exports["DevJacob_CallbackManager"]:getCallbackManagerObject()
]]