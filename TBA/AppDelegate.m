//
//  AppDelegate.m
//  TBA
//
//  Created by Bao Tran on 3/29/16.
//  Copyright © 2016 flatiron school. All rights reserved.
//

#import "AppDelegate.h"
#import "BONContainerViewController.h"


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

#pragma mark - make root vc the container - comment out to change default vc
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    BONContainerViewController *containerVC = [[BONContainerViewController alloc] init];
    self.window.rootViewController = containerVC;
    [self.window makeKeyAndVisible];
    
    
#
    
    UIUserNotificationType notificationTypes = (UIUserNotificationTypeBadge | UIUserNotificationTypeAlert);
    UIUserNotificationSettings *userNotificationSettings = [UIUserNotificationSettings settingsForTypes:notificationTypes
                                                                                             categories:nil];
    
    [HNKGooglePlacesAutocompleteQuery setupSharedQueryWithAPIKey:googlePlacesAPIBrowserKey];
    
    [[UIApplication sharedApplication] registerUserNotificationSettings:userNotificationSettings];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    UILocalNotification *localNotification = [UILocalNotification new];
    
    localNotification.alertTitle = @"You ate this time yesterday";
    localNotification.alertBody = @"Maybe you want to eat again now";
    localNotification.alertAction = @"Log a meal";
    localNotification.fireDate = [[NSDate date] dateByAddingTimeInterval:5];
    
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
