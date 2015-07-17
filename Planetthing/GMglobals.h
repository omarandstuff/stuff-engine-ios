// -------------------------------------------- //
// ------------- VERBOSE SECTIONS ------------- //
// -------------------------------------------- //

#define IH_VERBOSE false // iOS Helper verbose
#define GM_VERBOSE true // Game Main verbose

// Game Engine verbose
#define RB_VERBOSE true // Render Box verbose

// -------------------------------------------- //
// ----------------- CLEAN LOG ---------------- //
// -------------------------------------------- //

#define CleanLog(CONTEXT, FORMAT, ...) if(CONTEXT)printf("%s\n", [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);


// -------------------------------------------- //
// ---------- Game Center Info (Game) --------- //
// -------------------------------------------- //

#define GameCenterLeaderBoards @[ @[@"planetthing_test_leaderboard_1", @0, @"greater"], @[@"planetthing_test_leaderboard_2", @0, @"least"], @[@"planetthing_test_leaderboard_3", @0, @"greater"] ]
#define GameCenterAchievements @[ @[@"planettin_achievement_test1", @0, @0], @[@"planettin_achievement_test2", @0, @10], @[@"planettin_achievement_test3", @0, @100] ]