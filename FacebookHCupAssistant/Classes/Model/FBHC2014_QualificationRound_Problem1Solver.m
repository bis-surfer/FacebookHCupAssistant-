//
//  FBHC2014_QualificationRound_Problem1Solver.m
//  FacebookHCupAssistant
//
//  Created by Ilya Borisov on 1/8/15.
//  Copyright (c) 2015 Ilya Borisov. All rights reserved.
//
//  In order to build fully-functional OS X app (with simple UI)
//  intended to construct output text file by input text file according to Facebook Hacker Cup contest requirements
//  please download Xcode project at https://github.com/bis-surfer/FacebookHCupAssistant-.git
//  and replace file of the same name ("FBHC2014_QualificationRound_Problem1Solver.m") with the present file.
//  Also rewrite method +[Computer specificProblemSolverClass] to return [FBHC2014_QualificationRound_Problem1Solver class].
//
//  Square Detector (1-st Problem)
//

#import "FBHC2014_QualificationRound_Problem1Solver.h"

#import "NSString+ArrayRepresentation.h"
#import "NSArray+Counting.h"


@implementation FBHC2014_QualificationRound_Problem1Solver

- (BOOL)isLinesPerCaseCountVariable {
    
    return YES;
}

- (NSUInteger)linesPerCaseCountWithString:(NSString *)linesCountString {
    
    return (1 + [linesCountString integerValue]);
}

- (NSString *)outputForTestCaseWithIndex:(NSUInteger)testCaseIndex andInputLines:(NSArray *)inputLines {
    
    NSUInteger N = inputLines.count - 1;
    
    NSMutableString *wholeImageString = [NSMutableString string];
    
    for (NSString *inputString in inputLines) {
        
        if ([inputLines indexOfObject:inputString] == 0) {
            
            N = [inputString integerValue];
        }
        else {
            
            [wholeImageString appendString:inputString];
        }
    }
    
    NSArray *wholeImageArray = [wholeImageString arrayFromSelf];
    NSUInteger blackDotsNumber = [wholeImageArray countForObject:@"#"];
    
    double a = sqrt(blackDotsNumber);
    
    if (a != (NSUInteger)(a)) {
        
        return @"NO";
    }
    
    NSUInteger side = (NSUInteger)a;
    
    NSUInteger firstBlackDotIndex = [wholeImageArray indexOfObject:@"#"];
    
    for (NSUInteger y = 0; y < side; y++) {
        for (NSUInteger x = 0; x < side; x++){
            
            NSUInteger dotIndex = firstBlackDotIndex + y*N +x;
            
            NSString *dotValue = [wholeImageArray objectAtIndex:dotIndex];
            
            if (![dotValue isEqual:@"#"]) {
                
                return @"NO";
            }
        }
    }
    
    // all the black cells form a completely filled square with edges parallel to the grid of cells
    return @"YES";
}

@end
