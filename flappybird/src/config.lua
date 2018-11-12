
-- 0 - disable debug info, 1 - less debug info, 2 - verbose debug info
DEBUG = 1

-- display FPS stats on screen
DEBUG_FPS = false

-- dump memory info every 10 seconds
DEBUG_MEM = false

-- load deprecated API
LOAD_DEPRECATED_API = false

-- load shortcodes API
LOAD_SHORTCODES_API = true

-- screen orientation
CONFIG_SCREEN_ORIENTATION = "portrait"

-- design resolution
CONFIG_SCREEN_WIDTH  = 640
CONFIG_SCREEN_HEIGHT = 960

-- auto scale mode
CONFIG_SCREEN_AUTOSCALE = "FIXED_WIDTH"


bird_hero1 = "bird/bird_hero1.png";
bird_hero2 = "bird/bird_hero2.png";
bird_hero3 = "bird/bird_hero3.png";
bird_logo = "bird/bird_logo.png";
bird_bg = "bird/bird_bg.png";
bird_obstacle_up = "bird/obstacle_up.png";
bird_obstacle_down = "bird/obstacle_down.png";
bird_start_btn = "bird/bird_start_btn.png";
bird_start_btn_pressed = "bird/brid_start_btn_pressed.png";
bird_gameover = "bird/bird_gameover.png";

TAG_LOGO = 1000;
TAG_START_BTN= 1001;
TAG_HERO = 1002; 
TAG_OVER = 1003;
TAG_SCORE = 1004;
TAG_OBSTACLE = 1005;
TAG_ACTION_ADDSCORE = 1006;
TAG_ADTION_ADDOBSTACLE = 1007;

GAME_STATUS_START = 10;
GAME_STATUS_PLAYING = 20;
GAME_STATUS_GAME_OVER = 30;
GAME_STATUS_RESTART = 40;

GAME_TEXTURE_DATA_FILENAME  = "bird/bird_hero.plist"
GAME_TEXTURE_IMAGE_FILENAME = "bird/bird_hero.png"

CategoryBitmask_player = 0x0111
ContactTestBitmask_player = 0x1111
CollisionBitmask_player = 0x1001

CategoryBitmask_obstacle = 0x0111
ContactTestBitmask_obstacle = 0x1111
CollisionBitmask_obstacle = 0x0000

music_bg="audio/bg.ogg"
music_jump="audio/jump.ogg"
music_over="audio/over.ogg"