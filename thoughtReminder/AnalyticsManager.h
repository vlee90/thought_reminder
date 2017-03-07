//
//  AnalyticsManager.h
//  thoughtReminder
//
//  Created by Vincent Lee on 3/6/17.
//  Copyright © 2017 VincentLee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AnalyticsManager : NSObject

// Singleton Declaration
+ (AnalyticsManager *)sharedInstance;
- (void)startAnalytics;
- (void)filterThenPushEvent:(NSDictionary *)eventDict;

@end
