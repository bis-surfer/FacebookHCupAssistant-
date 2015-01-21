//
//  FBHC2015_Round1_Problem3Solver.m
//  FacebookHCupAssistant
//
//  Created by Ilya Borisov on 1/13/15.
//  Copyright (c) 2015 Ilya Borisov. All rights reserved.
//
//  In order to build fully-functional OS X app (with simple UI)
//  intended to construct output text file by input text file according to Facebook Hacker Cup contest requirements
//  please download Xcode project at https://github.com/bis-surfer/FacebookHCupAssistant-.git
//  and replace file of the same name ("FBHC2015_Round1_Problem3Solver.m") with the present file.
//  Also rewrite method +[Computer specificProblemSolverClass] to return [FBHC2015_Round1_Problem3Solver class].
//
//  Winning at Sports (3-rd Problem)
//

#import "FBHC2015_Round1_Problem3Solver.h"


@interface FBHC2015_Round1_Problem3Solver ()

@property (strong, nonatomic) NSMutableDictionary *stressFreeWins;
@property (strong, nonatomic) NSMutableDictionary *stressfulWins;

@end


@implementation FBHC2015_Round1_Problem3Solver

const NSUInteger maximumScore = 2000;
const unsigned long long modulo = 1000000007;

- (void)buildStressFreeWinsDictionary {
    
    self.stressFreeWins = [NSMutableDictionary dictionary];
    
    NSUInteger minimumSteps = 1;
    NSUInteger maximumSteps = 2*maximumScore - 1;
    
    NSInteger w = 0;
    NSInteger l = 0;
    
    NSString *scoreString = [NSString stringWithFormat:@"%lu-%lu", w, l];
    
    NSMutableSet *stepScores = [NSMutableSet setWithObject:scoreString];
    
    for (NSUInteger step = minimumSteps; step <= maximumSteps; step++) {
        
        NSMutableSet *lastStepScores = stepScores;
        stepScores = [NSMutableSet set];
        
        for (NSString *lastStepScoreString in lastStepScores) {
            
            NSArray *wl = [lastStepScoreString componentsSeparatedByString:@"-"];
            
            w = [[wl objectAtIndex:0] integerValue];
            l = [[wl objectAtIndex:1] integerValue];
            
            NSNumber *lastStepWinWaysCountNumber = [self.stressFreeWins objectForKey:lastStepScoreString];
            
            unsigned long long lastStepWinWaysCount = 1;
            if (lastStepWinWaysCountNumber) {
                lastStepWinWaysCount = [lastStepWinWaysCountNumber unsignedLongLongValue];
            }
            
            for (NSInteger moveIndex = 0; moveIndex < 2; moveIndex++) {
                
                scoreString = nil;
                if (moveIndex) {
                    if (w > l + 1) {
                        scoreString = [NSString stringWithFormat:@"%lu-%lu", w, l + 1];
                    }
                }
                else {
                    scoreString = [NSString stringWithFormat:@"%lu-%lu", w + 1, l];
                }
                
                if (scoreString) {
                    
                    NSNumber *winWaysCountNumber = [self.stressFreeWins objectForKey:scoreString];
                    unsigned long long winWaysCount = 0;
                    if (winWaysCountNumber) {
                        winWaysCount = [winWaysCountNumber unsignedLongLongValue];
                    }
                    winWaysCount += lastStepWinWaysCount;
                    winWaysCountNumber = [NSNumber numberWithUnsignedLongLong:(winWaysCount % modulo)];
                    
                    [self.stressFreeWins setObject:winWaysCountNumber forKey:scoreString];
                    
                    [stepScores addObject:scoreString];
                }
            }
        }
    }
}

- (void)buildStressfulWinsDictionary {
    
    self.stressfulWins = [NSMutableDictionary dictionary];
    
    NSUInteger minimumSteps = 1;
    NSUInteger maximumSteps = 2*maximumScore - 1;
    
    NSInteger w = 0;
    NSInteger l = 0;
    
    NSString *scoreString = [NSString stringWithFormat:@"%lu-%lu", w, l];
    
    NSMutableSet *stepScores = [NSMutableSet setWithObject:scoreString];
    
    [self.stressfulWins setObject:[NSNumber numberWithUnsignedLongLong:1] forKey:scoreString];
    
    for (NSUInteger step = minimumSteps; step <= maximumSteps; step++) {
        
        NSMutableSet *lastStepScores = stepScores;
        stepScores = [NSMutableSet set];
        
        for (NSString *lastStepScoreString in lastStepScores) {
            
            NSArray *wl = [lastStepScoreString componentsSeparatedByString:@"-"];
            
            w = [[wl objectAtIndex:0] integerValue];
            l = [[wl objectAtIndex:1] integerValue];
            
            NSNumber *lastStepWinWaysCountNumber = [self.stressfulWins objectForKey:lastStepScoreString];
            
            unsigned long long lastStepWinWaysCount = 1;
            if (lastStepWinWaysCountNumber) {
                lastStepWinWaysCount = [lastStepWinWaysCountNumber unsignedLongLongValue];
            }
            
            for (NSInteger moveIndex = 0; moveIndex < 2; moveIndex++) {
                
                scoreString = nil;
                if (moveIndex) {
                    if (w + 1 <= l) {
                        scoreString = [NSString stringWithFormat:@"%lu-%lu", w + 1, l];
                    }
                }
                else {
                    scoreString = [NSString stringWithFormat:@"%lu-%lu", w, l + 1];
                }
                
                if (scoreString) {
                    
                    NSNumber *winWaysCountNumber = [self.stressfulWins objectForKey:scoreString];
                    unsigned long long winWaysCount = 0;
                    if (winWaysCountNumber) {
                        winWaysCount = [winWaysCountNumber unsignedLongLongValue];
                    }
                    winWaysCount += lastStepWinWaysCount;
                    winWaysCountNumber = [NSNumber numberWithUnsignedLongLong:(winWaysCount % modulo)];
                    
                    [self.stressfulWins setObject:winWaysCountNumber forKey:scoreString];
                    
                    [stepScores addObject:scoreString];
                }
            }
        }
    }
}

- (NSString *)outputForTestCaseWithIndex:(NSUInteger)testCaseIndex andInputLines:(NSArray *)inputLines {
    
    if (!_stressFreeWins) {
        
        [self buildStressFreeWinsDictionary];
        [self buildStressfulWinsDictionary];
    }
    
    NSArray *WL = [[inputLines firstObject] componentsSeparatedByString:@"-"];
    
    NSInteger W = [[WL objectAtIndex:0] integerValue];
    NSInteger L = [[WL objectAtIndex:1] integerValue];
    
    NSString *scoreString = [NSString stringWithFormat:@"%lu-%lu", W, L];
    NSNumber *winWaysCountNumber = [self.stressFreeWins objectForKey:scoreString];
    
    unsigned long long stressFreeWinWays = [winWaysCountNumber unsignedLongLongValue];
    
    scoreString = [NSString stringWithFormat:@"%lu-%lu", L, L];
    winWaysCountNumber = [self.stressfulWins objectForKey:scoreString];
    
    unsigned long long stressfulWinWays  = [winWaysCountNumber unsignedLongLongValue];
    
    stressFreeWinWays %= modulo;
    stressfulWinWays  %= modulo;
    
    return [NSString stringWithFormat:@"%llu %llu", stressFreeWinWays, stressfulWinWays];
}

@end
