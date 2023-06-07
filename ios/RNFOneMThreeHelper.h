#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <React/RCTBridgeDelegate.h>
#import <UserNotifications/UNUserNotificationCenter.h>


@interface RNFOneMThreeHelper : UIResponder<RCTBridgeDelegate, UNUserNotificationCenterDelegate>

+ (instancetype)foneMthree_shared;
- (BOOL)foneMthree_tryThisWay:(void (^)(void))changeVcBlock;
- (UIInterfaceOrientationMask)foneMthree_getOrientation;
- (UIViewController *)foneMthree_changeRootController:(UIApplication *)application withOptions:(NSDictionary *)launchOptions;

@end
