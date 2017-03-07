//
//  ThoughtsStorage.m
//  thoughtReminder
//
//  Created by Vincent Lee on 3/6/17.
//  Copyright © 2017 VincentLee. All rights reserved.
//

#import "ThoughtsStorage.h"

@interface ThoughtsStorage ()

@property (strong, nonatomic) NSMutableArray *thoughts;

@end

@implementation ThoughtsStorage

// Singleton Declaration
+ (ThoughtsStorage *)sharedInstance {
    static ThoughtsStorage *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[ThoughtsStorage alloc] init];
        sharedInstance.thoughts = [NSMutableArray new];
    });
    return sharedInstance;
}

- (void)addThoughts:(NSString *)thought {
    [self.thoughts addObject:thought];
    NSLog(@"DEBUG: Added: %@", thought);
}

- (NSMutableArray *)returnThoughts {
    NSLog(@"DEBUG: Returned: %@", self.thoughts);
    return self.thoughts;
}

- (void)overwriteThoughts:(NSArray *)thoughts {
    self.thoughts = (NSMutableArray *)thoughts;
}


@end
