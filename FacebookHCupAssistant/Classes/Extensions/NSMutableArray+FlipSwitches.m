//
//  NSMutableArray+FlipSwitches.m
//  FacebookHCupAssistant
//
//  Created by Ilya Borisov on 4/26/14.
//  Copyright (c) 2014 Ilya Borisov. All rights reserved.
//

#import "NSMutableArray+FlipSwitches.h"


@implementation NSMutableArray (FlipSwitches)

- (void)flipSwitchWithIndex:(NSUInteger)index {
    
    for (NSMutableString *s in self) {
        
        NSRange r = NSMakeRange(index, 1);
        
        NSString *bit = [s substringWithRange:r];
        NSString *inverseBit = @"0";
        if ([bit isEqualToString:@"0"]) {
            inverseBit = @"1";
        }
        
        [s replaceCharactersInRange:r withString:inverseBit];
    }
}

@end
