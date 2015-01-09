//
//  FBHC2015_QualificationRound_Problem2Solver.m
//  FacebookHCupAssistant
//
//  Created by Ilya Borisov on 1/8/15.
//  Copyright (c) 2015 Ilya Borisov. All rights reserved.
//
//  In order to build fully-functional OS X app (with simple UI)
//  intended to construct output text file by input text file according to Facebook Hacker Cup contest requirements
//  please download Xcode project at ***
//  and replace file of the same name ("FBHC2015_QualificationRound_Problem2Solver.m") with the present file.
//  Also rewrite method +[Computer specificProblemSolverClass] to return [FBHC2015_QualificationRound_Problem2Solver class].
//
//  New Year's Resolution (2-nd Problem)
//

#import "FBHC2015_QualificationRound_Problem2Solver.h"


@implementation FBHC2015_QualificationRound_Problem2Solver

- (BOOL)isLinesPerCaseCountVariable {
    
    return YES;
}

- (NSUInteger)indexOfLinesPerCaseCountLine {
    
    return 1;
}

- (NSUInteger)linesPerCaseCountWithString:(NSString *)linesCountString {
    
    return (2 + [linesCountString integerValue]);
}

- (NSString *)outputForTestCaseWithIndex:(NSUInteger)testCaseIndex andInputLines:(NSArray *)inputLines {
    
    return @"Please write down the specific algorithm!";
}

@end
