
module rl;


distinct ConfigFlag = uint;

const ConfigFlag FLAG_VSYNC_HINT               = 0x00000040;   // Set to try enabling V-Sync on GPU
const ConfigFlag FLAG_FULLSCREEN_MODE          = 0x00000002;   // Set to run program in fullscreen
const ConfigFlag FLAG_WINDOW_RESIZABLE         = 0x00000004;   // Set to allow resizable window
const ConfigFlag FLAG_WINDOW_UNDECORATED       = 0x00000008;   // Set to disable window decoration (frame and buttons)
const ConfigFlag FLAG_WINDOW_HIDDEN            = 0x00000080;   // Set to hide window
const ConfigFlag FLAG_WINDOW_MINIMIZED         = 0x00000200;   // Set to minimize window (iconify)
const ConfigFlag FLAG_WINDOW_MAXIMIZED         = 0x00000400;   // Set to maximize window (expanded to monitor)
const ConfigFlag FLAG_WINDOW_UNFOCUSED         = 0x00000800;   // Set to window non focused
const ConfigFlag FLAG_WINDOW_TOPMOST           = 0x00001000;   // Set to window always on top
const ConfigFlag FLAG_WINDOW_ALWAYS_RUN        = 0x00000100;   // Set to allow windows running while minimized
const ConfigFlag FLAG_WINDOW_TRANSPARENT       = 0x00000010;   // Set to allow transparent framebuffer
const ConfigFlag FLAG_WINDOW_HIGHDPI           = 0x00002000;   // Set to support HighDPI
const ConfigFlag FLAG_WINDOW_MOUSE_PASSTHROUGH = 0x00004000;   // Set to support mouse passthrough, only supported when FLAG_WINDOW_UNDECORATED
const ConfigFlag FLAG_BORDERLESS_WINDOWED_MODE = 0x00008000;   // Set to run program in borderless windowed mode
const ConfigFlag FLAG_MSAA_4X_HINT             = 0x00000020;   // Set to try enabling MSAA 4X
const ConfigFlag FLAG_INTERLACED_HINT          = 0x00010000;


struct Color
{
    char r; // Red
    char g; // Green
    char b; // Blue
    char a; // Alpha
}

struct Rectangle
{
    float x;
    float y;
    float width;
    float height;
}

struct Image
{
    void* data;
    int width;
    int height;
    int mipmaps;
    int format;
}

struct Texture
{
    uint id;
    int width;
    int height;
    int mipmaps;
    int format;
}

struct RenderTexture
{
    uint id;                // OpenGL framebuffer object id
    Texture texture;        // Color buffer attachment texture
    Texture depth;          // Depth buffer attachment texture
}


// Window-related functions


extern fn void init_window(CInt width, CInt height, char* title) @extern("InitWindow");
extern fn void close_window() @extern("CloseWindow");
extern fn bool window_should_close() @extern("WindowShouldClose");
extern fn bool is_window_ready() @extern("IsWindowReady");
extern fn bool is_window_fullscreen() @extern("IsWindowFullscreen");
extern fn bool is_window_hidden() @extern("IsWindowHidden");
extern fn bool is_window_minimized() @extern("IsWindowMinimized");
extern fn bool is_window_maximized() @extern("IsWindowMaximized");
extern fn bool is_window_focused() @extern("IsWindowFocused");
extern fn bool is_window_resized() @extern("IsWindowResized");
extern fn bool is_window_state(CUInt flag) @extern("IsWindowState");
extern fn void set_window_state(CUInt flags) @extern("SetWindowState");
extern fn void clear_window_state(CUInt flags) @extern("ClearWindowState");
extern fn void toggle_fullscreen() @extern("ToggleFullscreen");
extern fn void toggle_borderless_windowed() @extern("ToggleBorderlessWindowed");
extern fn void maximize_window() @extern("MaximizeWindow");
extern fn void minimize_window() @extern("MinimizeWindow");
extern fn int get_render_width() @extern("GetRenderWidth");
extern fn int get_render_height() @extern("GetRenderHeight");
extern fn void set_config_flags(CUInt flags) @extern("SetConfigFlags");


extern fn void set_window_title(char* title) @extern("SetWindowTitle");
extern fn void set_window_position(CInt x, CInt y) @extern("SetWindowPosition");

extern fn void show_cursor() @extern("ShowCursor");
extern fn void hide_cursor() @extern("HideCursor");

extern fn void begin_drawing() @extern("BeginDrawing");
extern fn void end_drawing() @extern("EndDrawing");
extern fn void clear_background(Color color) @extern("ClearBackground");

extern fn void set_target_fps(CInt fps) @extern("SetTargetFPS");
extern fn float get_frame_time() @extern("GetFrameTime");

extern fn void poll_input_events() @extern("PollInputEvents");

extern fn void set_random_seed(CUInt seed) @extern("SetRandomSeed");
extern fn int get_random_value(CInt min, CInt max) @extern("GetRandomValue");


// Compression/Encoding functionality

<* Compress data (DEFLATE algorithm), memory must be MemFree() *>
extern fn char* compress_data(char* data, CInt data_size, CInt *comp_data_size) @extern("CompressData");

<* Decompress data (DEFLATE algorithm), memory must be MemFree() *>
extern fn char* decompress_data(char* comp_data, CInt comp_data_size, CInt *data_size) @extern("DecompressData");


// Shapes functions


extern fn void draw_text(char* text, CInt pos_x, CInt pos_y, CInt font_size, Color color) @extern("DrawText");
extern fn void draw_rectangle(CInt posX, CInt posY, CInt width, CInt height, Color color) @extern("DrawRectangle"); // Draw a color-filled rectangle
extern fn void draw_rectangle_rounded(Rectangle rec, float roundness, CInt segments, Color color) @extern("DrawRectangleRounded");
