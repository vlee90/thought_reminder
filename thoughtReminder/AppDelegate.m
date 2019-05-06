//
//  AppDelegate.m
//  thoughtReminder
//
//  Created by Vincent Lee on 3/6/17.
//  Copyright © 2017 VincentLee. All rights reserved.
//

#import "AppDelegate.h"
#import "ThoughtsStorage.h"
#import <UserNotifications/UserNotifications.h>
#import <stdlib.h>

@import Firebase;

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [FIRApp configure];
    
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    [center requestAuthorizationWithOptions:(UNAuthorizationOptionAlert|UNAuthorizationOptionBadge) completionHandler:^(BOOL granted, NSError * _Nullable error) {
      
        if (error) {
            
        }
    }];
    
    
    NSMutableArray *thoughts = [[[NSUserDefaults standardUserDefaults] stringArrayForKey:@"thoughts"] mutableCopy];
    if (thoughts) {
        [[ThoughtsStorage sharedInstance] overwriteThoughts:thoughts];
        if (thoughts.count != 0) {
            UNMutableNotificationContent *content = [UNMutableNotificationContent new];
            content.title = @"Thought Reminder";
            
            NSUInteger length = thoughts.count;
            int index = arc4random_uniform(length);
            NSString *displayedThought = thoughts[index];
            content.body = displayedThought;
            
            
            NSDateComponents *date = [NSDateComponents new];
            date.hour = 12;
            date.minute = 5;
            
            UNCalendarNotificationTrigger *trigger = [UNCalendarNotificationTrigger triggerWithDateMatchingComponents:date repeats:NO];
            
            UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:@"TestRequest" content:content trigger:trigger];
            
            [center addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
                if (error) {
                    
                }
            }];
        }
    }
    else {
        
    }
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    [[NSUserDefaults standardUserDefaults] setObject:[[ThoughtsStorage sharedInstance] returnThoughts] forKey:@"thoughts"];
}


@end
