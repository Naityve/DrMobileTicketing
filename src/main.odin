package main

import "core:strings"
import "core:unicode/utf8"
import "core:encoding/json"

import rl "vendor:raylib"

DEFAULT_WINDOW_WIDTH 	:: 1920
DEFAULT_WINDOW_HEIGHT :: 1080
DEFAULT_WINDOW_NAME		:: "DrMobilePhone Ticketing"

DEFAULT_DATA_PATH	:: "data"

App :: struct
{
	windowWidth 	: i32,
	windowHeight 	: i32,
	renderWidth 	: i32,
	renderHeight 	: i32,
	
	target : rl.RenderTexture,

	state : AppState,

	dataPath : cstring,

	runeBuffer : [dynamic]rune,

}
_app : App

AppState :: enum
{
	ERROR,
	MAIN_MENU,
}

LoadDefaultAppData :: proc(app : ^App)
{
	app^ = {
		windowWidth 	= 0,
		windowHeight 	= 0,
		renderWidth 	= 0,
		renderHeight 	= 0,
		
		target = rl.LoadRenderTexture(1920,1080),

		state = AppState.ERROR,

		dataPath = "data"
	}
}

LoadAppData :: proc(path : cstring, app : ^App)
{

}

Hotbar :: struct
{
	position 	: rl.Vector2,
	width 		: i32,
	height 		: i32,
}

main :: proc()
{
	rl.InitWindow(DEFAULT_WINDOW_WIDTH,DEFAULT_WINDOW_HEIGHT,DEFAULT_WINDOW_NAME)

	for !rl.WindowShouldClose()
	{

		MainUpdate()

		rl.BeginDrawing()
		rl.ClearBackground({180,180,210,255})
		rl.EndDrawing()
	}

	rl.CloseWindow()
}

MainUpdate :: proc()
{
	if rl.FileExists("data/config.json") {
		LoadAppData("data/config.json", &_app)
	} else {
		LoadDefaultAppData(&_app)
	}	
}