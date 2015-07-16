#import <GameKit/GameKit.h>
#import "Reachability.h"
#import "NSDataAES256.h"
#import "IHglobals.h"

#define LIBRARY_FOLDER [NSHomeDirectory() stringByAppendingPathComponent:@"Library"]
#define GameCenterDataFile @"game_center.plist"
#define GameCenterDataPath [LIBRARY_FOLDER stringByAppendingPathComponent:GameCenterDataFile]

@class IHGameCenter;
@protocol IHGameCenterViewDelegate;
@protocol IHGameCenterControlDelegate;

@interface IHGameCenter : NSObject<GKGameCenterControllerDelegate>

// -------------------------------------------- //
// ---------------- Properties ---------------- //
// -------------------------------------------- //
@property (readonly)bool Available;
@property (readonly)bool Authenticated;
@property (readonly)GKLocalPlayer* LocalPlayer;
@property (readonly)NSMutableDictionary* LocalPlayerFriends;
@property (readonly)NSMutableDictionary* LocalPlayerData;
@property id<IHGameCenterViewDelegate> ViewDelegate;
@property id<IHGameCenterControlDelegate> ControlDelegate;


// -------------------------------------------- //
// ------------- Singleton / SetUp ------------ //
// -------------------------------------------- //
+ (instancetype)sharedIntance;

// -------------------------------------------- //
// ------------- Public Functions ------------- //
// -------------------------------------------- //
- (void)authenticateLocalPlayer;
- (void)setScore:(NSNumber*)scoreValue andContext:(NSNumber*)context forIdentifier:(NSString*)identifier;
- (void)setAchievementProgress:(NSNumber*)progess forIdentifier:(NSString*)identifier;
- (NSMutableDictionary*)getScoreForIdentifier:(NSString*)identifier;
- (NSMutableDictionary*)getAchievementForIdentifier:(NSString*)identifier;
- (void)saveLocalPlayers;


@end

// iOS Helper GameCenter Delegate. Know when the stuff is done.
@protocol IHGameCenterViewDelegate <NSObject>

@required
- (void)presentGameCenterAuthentificationView:(UIViewController *)gameCenterLoginController;

@end

@protocol IHGameCenterControlDelegate <NSObject>

@optional
- (void)didPlayerDataSync;


@optional

@end

