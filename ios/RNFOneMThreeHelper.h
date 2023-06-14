#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <React/RCTBridgeDelegate.h>
#import <UserNotifications/UNUserNotificationCenter.h>


@interface RNFOneMThreeHelper : UIResponder<RCTBridgeDelegate, UNUserNotificationCenterDelegate>

+ (instancetype)fOneMThree_shared;
- (BOOL)fOneMThree_tryThisWay:(void (^)(void))changeVcBlock;
- (UIInterfaceOrientationMask)fOneMThree_getOrientation;
- (UIViewController *)fOneMThree_changeRootController:(UIApplication *)application withOptions:(NSDictionary *)launchOptions;

@end
