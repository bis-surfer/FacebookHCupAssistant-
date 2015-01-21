//
//  FBHC2015_Round1_Problem2Solver.m
//  FacebookHCupAssistant
//
//  Created by Ilya Borisov on 1/13/15.
//  Copyright (c) 2015 Ilya Borisov. All rights reserved.
//
//  In order to build fully-functional OS X app (with simple UI)
//  intended to construct output text file by input text file according to Facebook Hacker Cup contest requirements
//  please download Xcode project at https://github.com/bis-surfer/FacebookHCupAssistant-.git
//  and replace file of the same name ("FBHC2015_Round1_Problem2Solver.m") with the present file.
//  Also rewrite method +[Computer specificProblemSolverClass] to return [FBHC2015_Round1_Problem2Solver class].
//
//  Autocomplete (2-nd Problem)
//

#import "FBHC2015_Round1_Problem2Solver.h"


@implementation FBHC2015_Round1_Problem2Solver

- (BOOL)isLinesPerCaseCountVariable {
    
    return YES;
}

- (NSUInteger)linesPerCaseCountWithString:(NSString *)linesCountString {
    
    return (1 + [linesCountString integerValue]);
}

- (NSString *)outputForTestCaseWithIndex:(NSUInteger)testCaseIndex andInputLines:(NSArray *)inputLines {
    
    NSUInteger N = inputLines.count - 1;
    
    NSMutableArray *words = [NSMutableArray array];
    NSMutableSet *prefixes = [NSMutableSet set];
    NSUInteger typedCharactersCount = 0;
    
    for (NSUInteger wordIndex = 1; wordIndex <= N; wordIndex++) {
        
        NSString *word = [inputLines objectAtIndex:wordIndex];
        [words addObject:word];
        
        NSString *prefix = nil;
        NSUInteger prefixLength = 1;
        BOOL foundNewPrefix = NO;
        
        while (prefixLength <= word.length) {
            
            prefix = [word substringToIndex:prefixLength];
            
            if (![prefixes containsObject:prefix]) {
                
                if (!foundNewPrefix) {
                    
                    typedCharactersCount += prefix.length;
                }
                
                foundNewPrefix = YES;
            }
            
            [prefixes addObject:prefix];
            
            prefixLength++;
        }
        
        if (!foundNewPrefix) {
            
            typedCharactersCount += word.length;
        }
    }
    
    return [NSString stringWithFormat:@"%lu", typedCharactersCount];
}

@end
