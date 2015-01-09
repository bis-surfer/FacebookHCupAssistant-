//
//  NSString+ArrayRepresentation.m
//  FacebookHCupAssistant
//
//  Created by Ilya Borisov on 1/8/15.
//  Copyright (c) 2015 Ilya Borisov. All rights reserved.
//

#import "NSString+ArrayRepresentation.h"


@implementation NSString (ArrayRepresentation)

- (NSArray *)arrayFromSelf {
    
    NSMutableArray *array = [NSMutableArray array];
    
    for (NSUInteger characterIndex = 0; characterIndex < self.length; characterIndex++) {
        
        NSString *character = [self substringWithRange:NSMakeRange(characterIndex, 1)];
        
        [array addObject:character];
    }
    
    return [NSArray arrayWithArray:array];
}

@end
