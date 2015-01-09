//
//  NSArray+Ordering.m
//  FacebookHCupAssistant
//
//  Created by Ilya Borisov on 3/21/14.
//  Copyright (c) 2014 Ilya Borisov. All rights reserved.
//

#import "NSArray+Ordering.h"


@implementation NSArray (Ordering)

- (NSArray *)ascendingStringsArray {
    
    NSArray *orderedAscendingArray = [self sortedArrayUsingComparator: ^(NSString *key1, NSString *key2) {
        
        if ([key1 integerValue] < [key2 integerValue]) {
            return NSOrderedAscending;
        }
        else if ([key1 integerValue] > [key2 integerValue]) {
            return NSOrderedDescending;
        }
        
        return NSOrderedSame;
    }];
    
    return orderedAscendingArray;
}

- (NSArray *)ascendingStringsWithDoubleArray {
    
    NSArray *orderedAscendingArray = [self sortedArrayUsingComparator: ^(NSString *key1, NSString *key2) {
        
        if ([key1 doubleValue] < [key2 doubleValue]) {
            return NSOrderedAscending;
        }
        else if ([key1 doubleValue] > [key2 doubleValue]) {
            return NSOrderedDescending;
        }
        
        return NSOrderedSame;
    }];
    
    return orderedAscendingArray;
}

- (NSArray *)ascendingArraysArray {
    
    NSArray *orderedAscendingArray = [self sortedArrayUsingComparator: ^(NSArray *key1, NSArray *key2) {
        
        NSUInteger index = 0;
        
        while (index < MIN(key1.count, key2.count)) {
            
            if ([key1[index] integerValue] < [key2[index] integerValue]) {
                return NSOrderedAscending;
            }
            else if ([key1[index] integerValue] > [key2[index] integerValue]) {
                return NSOrderedDescending;
            }
            
            index++;
        }
        
        return NSOrderedSame;
    }];
    
    return orderedAscendingArray;
}

@end
