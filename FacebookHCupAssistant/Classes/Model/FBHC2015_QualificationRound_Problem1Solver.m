//
//  FBHC2015_QualificationRound_Problem1Solver.m
//  FacebookHCupAssistant
//
//  Created by Ilya Borisov on 1/8/15.
//  Copyright (c) 2015 Ilya Borisov. All rights reserved.
//
//  In order to build fully-functional OS X app (with simple UI)
//  intended to construct output text file by input text file according to Facebook Hacker Cup contest requirements
//  please download Xcode project at https://github.com/bis-surfer/FacebookHCupAssistant-.git
//  and replace file of the same name ("FBHC2015_QualificationRound_Problem1Solver.m") with the present file.
//  Also rewrite method +[Computer specificProblemSolverClass] to return [FBHC2015_QualificationRound_Problem1Solver class].
//
//  Cooking the Books (1-st Problem)
//

#import "FBHC2015_QualificationRound_Problem1Solver.h"


@implementation FBHC2015_QualificationRound_Problem1Solver

- (NSString *)outputForTestCaseWithIndex:(NSUInteger)testCaseIndex andInputLines:(NSArray *)inputLines {
    
    NSString *inputString = [inputLines firstObject];
    NSUInteger lastDigitIndex = inputString.length - 1;
    
    NSMutableString *smallestNumber = [NSMutableString stringWithString:inputString];
    NSMutableString *largestNumber  = [NSMutableString stringWithString:inputString];
    
    NSString *leadingDigit  = [inputString substringWithRange:NSMakeRange(0, 1)];
    NSString *smallestDigit = @"9";
    NSString *largestDigit  = @"0";
    
    NSUInteger leadingDigitIndex  = 0;
    NSUInteger smallestDigitIndex = NSNotFound;
    NSUInteger largestDigitIndex  = NSNotFound;
    
    while (leadingDigitIndex < lastDigitIndex && smallestDigitIndex == NSNotFound) {
        
        leadingDigit = [inputString substringWithRange:NSMakeRange(leadingDigitIndex, 1)];
        
        smallestDigit      = leadingDigit;
        smallestDigitIndex = NSNotFound;
        
        for (NSUInteger digitIndex = lastDigitIndex; digitIndex > leadingDigitIndex; digitIndex--) {
            
            NSString *digit = [inputString substringWithRange:NSMakeRange(digitIndex, 1)];
            
            if (leadingDigitIndex == 0 && [digit integerValue] == 0) {
                
                continue;
            }
            
            if ([digit integerValue] < [smallestDigit integerValue]) {
                
                smallestDigit      = [NSString stringWithString:digit];
                smallestDigitIndex = digitIndex;
            }
        }
        
        if (smallestDigitIndex == NSNotFound) {
            
            leadingDigitIndex++;
        }
    }
    
    if ([smallestDigit integerValue] < [leadingDigit integerValue]) { // equivalent to: if (smallestDigitIndex != NSNotFound) {
        
        // swap leading and smallest digits
        [smallestNumber replaceCharactersInRange:NSMakeRange(leadingDigitIndex, 1) withString:smallestDigit];
        [smallestNumber replaceCharactersInRange:NSMakeRange(smallestDigitIndex, 1) withString:leadingDigit];
    }
    
    
    leadingDigitIndex = 0;
    
    while (leadingDigitIndex < lastDigitIndex && largestDigitIndex == NSNotFound) {
        
        leadingDigit = [inputString substringWithRange:NSMakeRange(leadingDigitIndex, 1)];
        
        largestDigit      = leadingDigit;
        largestDigitIndex = NSNotFound;
        
        for (NSUInteger digitIndex = lastDigitIndex; digitIndex > leadingDigitIndex; digitIndex--) {
            
            NSString *digit = [inputString substringWithRange:NSMakeRange(digitIndex, 1)];
            
            if ([digit integerValue] > [largestDigit integerValue]) {
                
                largestDigit      = [NSString stringWithString:digit];
                largestDigitIndex = digitIndex;
            }
        }
        
        if (largestDigitIndex == NSNotFound) {
            
            leadingDigitIndex++;
        }
    }
    
    if ([largestDigit integerValue] > [leadingDigit integerValue]) { // equivalent to: if (largestDigitIndex != NSNotFound) {
        
        // swap first and largest digits
        [largestNumber replaceCharactersInRange:NSMakeRange(leadingDigitIndex, 1) withString:largestDigit];
        [largestNumber replaceCharactersInRange:NSMakeRange(largestDigitIndex, 1) withString:leadingDigit];
    }
    
    return [NSString stringWithFormat:@"%@ %@", smallestNumber, largestNumber];
}

@end
