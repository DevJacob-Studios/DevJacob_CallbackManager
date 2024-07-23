fx_version "cerulean"
lua54 "yes"
game "gta5"

author "DevJacob"
description "Simple and efficient implementation of a callback manager"
version "1.0.0"

dependencies {
	"DevJacob_CommonLib"
}

client_scripts {
	"imports.lua",
	"client/main.lua"
}

server_scripts {
	"imports.lua",
	"server/main.lua"
}

--[[
	Example Import:
	CallbackManager = exports["DevJacob_CallbackManager"]:getCallbackManagerObject()
]]