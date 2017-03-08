//
//  ThoughtsStorage.h
//  thoughtReminder
//
//  Created by Vincent Lee on 3/6/17.
//  Copyright © 2017 VincentLee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ThoughtsStorage : NSObject

// Singleton Declaration
+ (ThoughtsStorage *)sharedInstance;

- (void)addThoughts:(NSString *)thought;
- (NSMutableArray *)returnThoughts;
- (void)removeThoughts:(int)index;
- (void)overwriteThoughts:(NSArray *)thoughts;

@end

