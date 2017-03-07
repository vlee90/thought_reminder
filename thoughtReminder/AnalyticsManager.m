//
//  AnalyticsManager.m
//  thoughtReminder
//
//  Created by Vincent Lee on 3/6/17.
//  Copyright © 2017 VincentLee. All rights reserved.
//

#import "AnalyticsManager.h"
#import "TAGManager.h"
#import "TAGContainerOpener.h"
#import "TAGContainer.h"
#import "TAGDataLayer.h"
#import <AdSupport/AdSupport.h>

@interface AnalyticsManager () <TAGContainerOpenerNotifier>

@property (strong, nonatomic) TAGManager *tagManager;
@property (strong, nonatomic) TAGContainer *container;
@property (strong, nonatomic) NSMutableArray *storedHitsArray;

@end

@implementation AnalyticsManager

// Singleton Declaration
+ (AnalyticsManager *)sharedInstance {
    static AnalyticsManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[AnalyticsManager alloc] init];
        sharedInstance.storedHitsArray = [[NSMutableArray alloc] init];
        sharedInstance.tagManager = [TAGManager instance];
    });
    return sharedInstance;
}

-(void)startAnalytics {
    [self.tagManager.logger setLogLevel:kTAGLoggerLogLevelVerbose];
    [TAGContainerOpener openContainerWithId:@"GTM-MJ5TNVR"
                                 tagManager:self.tagManager
                                   openType:kTAGOpenTypePreferFresh
                                    timeout:nil
                                   notifier:self];
}

-(void)containerAvailable:(TAGContainer *)container {
    dispatch_async(dispatch_get_main_queue(), ^{
        self.container = container;
        
        NSString *adId = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
        NSString *isAdTrackingEnabled;
        if ([ASIdentifierManager sharedManager].isAdvertisingTrackingEnabled) {
            isAdTrackingEnabled = @"true";
        }
        else {
            isAdTrackingEnabled = @"false";
        }
        [[TAGManager instance].dataLayer push:@{@"event":@"app-init",
                                               @"adId":adId,
                                               @"isAdTrackingEnabled":isAdTrackingEnabled}];
        
        for (NSDictionary *event in self.storedHitsArray) {
            [self filterThenPushEvent:event];
        }
    });
}

- (void)filterThenPushEvent:(NSDictionary *)eventDict {
    if (self.container) {
        [[TAGManager instance].dataLayer push:eventDict];
    }
    else {
        [self.storedHitsArray addObject:eventDict];
    }
}

@end
