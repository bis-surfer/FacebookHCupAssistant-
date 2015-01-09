//
//  SpecificProblemSolver.m
//  FacebookHCupAssistant
//
//  Created by Ilya Borisov on 3/10/14.
//  Copyright (c) 2014 Ilya Borisov. All rights reserved.
//

#import "SpecificProblemSolver.h"


@implementation SpecificProblemSolver

- (NSUInteger)linesPerCaseCount {
    
    return 1;
}

- (BOOL)isLinesPerCaseCountVariable {
    
    return NO;
}

- (NSUInteger)indexOfLinesPerCaseCountLine {
    
    return 0;
}

- (NSUInteger)linesPerCaseCountWithString:(NSString *)linesCountString {
    
    if (self.isLinesPerCaseCountVariable) {
        
        return [linesCountString integerValue];
    }
    
    return self.linesPerCaseCount;
}

- (NSString *)outputForTestCaseWithIndex:(NSUInteger)testCaseIndex andInputLines:(NSArray *)inputLines {
    
    return @"Please write down the specific algorithm!";
}

@end
