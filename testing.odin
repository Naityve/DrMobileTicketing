package testing

import "core:strings"

import rl "vendor:raylib"

main :: proc() {
    rl.InitWindow(800, 600, "Text Input")
    
    buffer: [dynamic]u8
    defer delete(buffer)
    
    for !rl.WindowShouldClose() {
        char := rl.GetCharPressed()
        for char != 0 {
            append(&buffer, u8(char))
            char = rl.GetCharPressed()
        }
        
        if rl.IsKeyPressed(.BACKSPACE) && len(buffer) > 0 {
            pop(&buffer)
        }
        
        rl.BeginDrawing()
        rl.ClearBackground(rl.RAYWHITE)
        
        // Convert to string then cstring for raylib
        text := strings.clone_to_cstring(string(buffer[:]))
        defer delete_cstring(text)
        rl.DrawText(text, 10, 10, 20, rl.BLACK)
        
        rl.EndDrawing()
    }
    
    rl.CloseWindow()
}