//
//  SpecificProblemSolver.h
//  FacebookHCupAssistant
//
//  Created by Ilya Borisov on 3/10/14.
//  Copyright (c) 2014 Ilya Borisov. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface SpecificProblemSolver : NSObject

@property (nonatomic, readonly) NSUInteger linesPerCaseCount;
@property (nonatomic, readonly) BOOL isLinesPerCaseCountVariable;
@property (nonatomic, readonly) NSUInteger indexOfLinesPerCaseCountLine;

- (NSUInteger)linesPerCaseCountWithString:(NSString *)linesCountString;

- (NSString *)outputForTestCaseWithIndex:(NSUInteger)testCaseIndex andInputLines:(NSArray *)inputLines;


@end
