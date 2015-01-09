//
//  NSArray+Counting.m
//  FacebookHCupAssistant
//
//  Created by Ilya Borisov on 1/8/15.
//  Copyright (c) 2015 Ilya Borisov. All rights reserved.
//

#import "NSArray+Counting.h"


@implementation NSArray (Counting)

- (NSUInteger)countForObject:(id)anObject {
    
    NSUInteger aCount = 0;
    
    for (id obj in self) {
        
        if ([obj isEqual:anObject]) {
            
            aCount++;
        }
    }
    
    return aCount;
}

@end
