//
//  Computer.m
//  FacebookHCupAssistant
//
//  Created by Ilya Borisov on 2/27/14.
//  Copyright (c) 2014 Ilya Borisov. All rights reserved.
//

#import "Computer.h"

#import "General.h"
#import "Settings.h"
#import "ProgressMeter.h"

#import "FBHC2014_QualificationRound_Problem1Solver.h"

#import "FBHC2015_QualificationRound_Problem1Solver.h"
#import "FBHC2015_QualificationRound_Problem2Solver.h"
#import "FBHC2015_QualificationRound_Problem3Solver.h"

#import "FBHC2015_Round1_Problem1Solver.h"
#import "FBHC2015_Round1_Problem2Solver.h"
#import "FBHC2015_Round1_Problem3Solver.h"


@interface Computer ()

@end


@implementation Computer

+ (Class)specificProblemSolverClass {
    
    return [FBHC2015_QualificationRound_Problem3Solver class];
}

+ (NSString *)inputString {
    
    NSString *inputFilePath = [Settings sharedInstance].inputFilePath;
    NSError *error = nil;
    NSString *inputString = [NSString stringWithContentsOfFile:inputFilePath encoding:NSUTF8StringEncoding error:&error];
    
    if (error) {
        
        NSLog(@"Failed to create input string from file at path '%@' with error '%@'", inputFilePath, error);
        
        return nil;
    }
    
    NSLog(@"inputString: \n%@", inputString);
    
    return inputString;
}

+ (void)saveOutputString:(NSString *)outputString {
    
    NSString *outputFilePath = [Settings sharedInstance].outputFilePath;
    
    NSData *outputData = [outputString dataUsingEncoding:NSUTF8StringEncoding];
    
    [outputData writeToFile:outputFilePath atomically:YES];
    
    NSLog(@"outputString: \n%@", outputString);
}

+ (void)logPlatformTypeSizesAndLimits {
    
    NSLog(@"The size of int is: %lu bytes.", sizeof(int));
    NSLog(@"The size of long is: %lu bytes.", sizeof(long));
    
    NSLog(@"The size of NSInteger is: %lu bytes.", sizeof(NSInteger));
    NSLog(@"The range of NSInteger is: from %li to %li.", NSIntegerMin, NSIntegerMax);
    
    NSLog(@"The size of long long is: %lu bytes.", sizeof(long long));
}

+ (void)computeOutput {
    
    [Computer updateTestCaseIndex:(-1)];
    
    [Computer logPlatformTypeSizesAndLimits];
    
    NSString *input = [Computer inputString];
    NSArray *inputLines = [input componentsSeparatedByString:@"\n"];
    NSUInteger testCasesCount = (NSUInteger)[[inputLines objectAtIndex:0] integerValue];
    [Settings sharedInstance].testCasesCount = testCasesCount;
    
    SpecificProblemSolver *specificProblemSolver = [[[Computer specificProblemSolverClass] alloc] init];
    
    if (inputLines.count - 1 < specificProblemSolver.linesPerCaseCount*testCasesCount) {
        
        NSLog(@"Failed to compute output for:\n numberOfTestCases = %lu;\n NUMBER_OF_LINES_PER_CASE = %lu and \n inputLines.count = %lu", testCasesCount, specificProblemSolver.linesPerCaseCount, inputLines.count);
        
        [Computer completeComputation];
        return;
    }
    
    NSMutableString *output = [NSMutableString stringWithString:@""];
    
    NSUInteger lineIndex = 1;
    
    for (NSInteger testCaseIndex = 0; testCaseIndex < testCasesCount; testCaseIndex++) {
        
        NSUInteger linesPerCaseCount = [specificProblemSolver linesPerCaseCountWithString:[inputLines objectAtIndex:lineIndex + specificProblemSolver.indexOfLinesPerCaseCountLine]];
        
        NSIndexSet *linesIndexSet = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(lineIndex, linesPerCaseCount)];
        NSArray *testCaseInputLines = [inputLines objectsAtIndexes:linesIndexSet];
        
        NSString *outputString = nil;
        
        @autoreleasepool {
            
            outputString = [specificProblemSolver outputForTestCaseWithIndex:testCaseIndex andInputLines:testCaseInputLines];
        }
        
        NSString *outputLine = [NSString stringWithFormat:@"Case #%lu: %@\n", (testCaseIndex + 1), outputString];
        [output appendString:outputLine];
        
        [Computer updateTestCaseIndex:testCaseIndex];
        
        lineIndex += linesPerCaseCount;
    }
    
    [Computer saveOutputString:output];
    
    [Computer completeComputation];
}

+ (void)updateTestCaseIndex:(NSInteger)testCaseIndex {
    
    [Settings sharedInstance].testCaseIndex = testCaseIndex;
    
    [ProgressMeter sharedInstance].progress = [[Settings sharedInstance] progress];
}

+ (void)completeComputation {
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kComputationCompletedNotification object:self];
}

@end
