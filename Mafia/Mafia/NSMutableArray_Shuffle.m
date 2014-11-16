//
//  NSMutableArray_Shuffle.m
//  Mafia
//
//  Created by Moises Holguin on 11/15/14.
//  Copyright (c) 2014 Group13. All rights reserved.
//

#import "NSMutableArray_Shuffle.h"

@implementation NSMutableArray (Shuffle)

- (void)shuffle {
    NSUInteger count = [self count];
    for(NSUInteger i = 0; i < count; ++i) {
        NSInteger remainingCount = count - i;
        NSInteger exchangeIndex = i + arc4random_uniform((arc4random_uniform((u_int32_t)remainingCount)));
        [self exchangeObjectAtIndex:i withObjectAtIndex:exchangeIndex];
    }
}

@end
