//
//  AppDelegate.m
//  PushTest
//
//  Created by Echo on 16/1/7.
//  Copyright © 2016年 Liu Xuanyi. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [[UIApplication sharedApplication] registerForRemoteNotifications];
    [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert categories:nil]];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
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

-(void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    NSString *originalDT = [NSString stringWithFormat:@"%@", deviceToken];
    NSLog(@"原始deviceToken : \n %@",originalDT);
    //获取到之后要去掉尖括号和中间的空格
    NSMutableString *st = [NSMutableString stringWithString:originalDT];
    [st deleteCharactersInRange:NSMakeRange(0, 1)];
    [st deleteCharactersInRange:NSMakeRange(st.length-1, 1)];
    
    NSString *formatDT = [st stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSLog(@"格式化deviceToken : \n %@",formatDT);
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"kReceiveDeviceTokenNotification" object:[NSDictionary dictionaryWithObjectsAndKeys:originalDT,@"originalDT",formatDT,@"formatDT", nil]];
}

-(void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    NSLog(@"didFailToRegisterForRemoteNotificationsWithError:%@",[error description]);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    NSLog(@"Receive remote notification : %@",userInfo);
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:userInfo[@"aps"][@"alert"] delegate:self cancelButtonTitle:@"好" otherButtonTitles:nil, nil];
    [alert show];
}

@end
