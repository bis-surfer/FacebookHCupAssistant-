//
//  FBHC2015_QualificationRound_Problem3Solver.m
//  FacebookHCupAssistant
//
//  Created by Ilya Borisov on 1/8/15.
//  Copyright (c) 2015 Ilya Borisov. All rights reserved.
//
//  In order to build fully-functional OS X app (with simple UI)
//  intended to construct output text file by input text file according to Facebook Hacker Cup contest requirements
//  please download Xcode project at https://github.com/bis-surfer/FacebookHCupAssistant-.git
//  and replace file of the same name ("FBHC2015_QualificationRound_Problem3Solver.m") with the present file.
//  Also rewrite method +[Computer specificProblemSolverClass] to return [FBHC2015_QualificationRound_Problem3Solver class].
//
//  Lazer Maze (3-rd Problem)
//

#import "FBHC2015_QualificationRound_Problem3Solver.h"

#import "NSString+ArrayRepresentation.h"
#import "NSArray+Counting.h"


@interface NSString (TurretAndWall)

- (BOOL)isWallOrTurret;
- (BOOL)isTurret;
- (NSUInteger)turretDirection;

@end

@implementation NSString (TurretAndWall)

NSString *kWall        = @"#";

NSString *kTurretLeft  = @"<";
NSString *kTurretRight = @">";
NSString *kTurretUp    = @"^";
NSString *kTurretDown  = @"v";

- (BOOL)isWallOrTurret {
    
    if ([self isEqual:kWall]) return YES;
    
    return [self isTurret];
}

- (BOOL)isTurret {
    
    if ([self isEqual:kTurretUp])    return YES;
    if ([self isEqual:kTurretRight]) return YES;
    if ([self isEqual:kTurretDown])  return YES;
    if ([self isEqual:kTurretLeft])  return YES;
    
    return NO;
}

- (NSUInteger)turretDirection {
    
    if ([self isEqual:kTurretUp])    return 0;
    if ([self isEqual:kTurretRight]) return 1;
    if ([self isEqual:kTurretDown])  return 2;
    if ([self isEqual:kTurretLeft])  return 3;
    
    return NSNotFound;
}

@end


@interface NSString (EmptySpaceAndAllowed)

- (BOOL)isEmptySpace;
- (BOOL)isStart;
- (BOOL)isGoal;
- (BOOL)isForbidden;
- (BOOL)isMarked;
- (BOOL)isAllowed;

@end

@implementation NSString (EmptySpaceAndAllowed)

NSString *kEmptySpace = @".";
NSString *kStart      = @"S";
NSString *kGoal       = @"G";
NSString *kForbidden  = @"F";
NSString *kMarked     = @"M";

- (BOOL)isEmptySpace {
    
    return [self isEqual:kEmptySpace];
}

- (BOOL)isStart {
    
    return [self isEqual:kStart];
}

- (BOOL)isGoal {
    
    return [self isEqual:kGoal];
}

- (BOOL)isForbidden {
    
    return [self isEqual:kForbidden];
}

- (BOOL)isMarked {
    
    return [self isEqual:kMarked];
}

- (BOOL)isAllowed {
    
    return [self isEmptySpace] || [self isStart] || [self isGoal];
}

@end


@implementation FBHC2015_QualificationRound_Problem3Solver

NSString *kLMImpossible = @"impossible";

- (void)makeMoveVector:(NSInteger *)moveVector withIndex:(NSInteger)moveIndex {
    
    if (moveIndex == 0) {
        // move up
        moveVector[0] = 0;
        moveVector[1] = -1;
    }
    else if (moveIndex == 1) {
        // move right
        moveVector[0] = 1;
        moveVector[1] = 0;
    }
    else if (moveIndex == 2) {
        // move down
        moveVector[0] = 0;
        moveVector[1] = 1;
    }
    else if (moveIndex == 3) {
        // move left
        moveVector[0] = -1;
        moveVector[1] = 0;
    }
}

- (BOOL)isLinesPerCaseCountVariable {
    
    return YES;
}

- (NSUInteger)linesPerCaseCountWithString:(NSString *)linesCountString {
    
    NSArray *MN = [linesCountString componentsSeparatedByString:@" "];
    NSInteger M = [[MN objectAtIndex:0] integerValue];
    
    return (1 + M);
}

- (NSString *)outputForTestCaseWithIndex:(NSUInteger)testCaseIndex andInputLines:(NSArray *)inputLines {
    
    NSArray *MN = [[inputLines firstObject] componentsSeparatedByString:@" "];
    
    NSInteger M = [[MN objectAtIndex:0] integerValue];
    NSInteger N = [[MN objectAtIndex:1] integerValue];
    
    NSMutableString *wholeMazeImageString = [NSMutableString string];
    
    for (NSString *inputString in inputLines) {
        
        if ([inputLines indexOfObject:inputString] > 0) {
            
            [wholeMazeImageString appendString:inputString];
        }
    }
    
    NSArray *wholeMazeImageArray = [wholeMazeImageString arrayFromSelf];
    
    NSMutableDictionary *turrets = [NSMutableDictionary dictionary];
    
    NSInteger xS = NSNotFound, yS = NSNotFound;
    NSInteger xG = NSNotFound, yG = NSNotFound;
    
    for (NSUInteger y = 0; y < M; y++) {
        for (NSUInteger x = 0; x < N; x++) {
            
            NSUInteger dotIndex = y*N + x;
            
            NSString *dotValue = [wholeMazeImageArray objectAtIndex:dotIndex];
            
            if ([dotValue isTurret]) {
                
                NSString *turretKey       = [NSString stringWithFormat:@"%lu", dotIndex];
                NSString *turretDirection = [NSString stringWithFormat:@"%lu", [dotValue turretDirection]];
                
                [turrets setObject:turretDirection forKey:turretKey];
            }
            else if ([dotValue isEqual:kStart]) {
                
                xS = x;
                yS = y;
            }
            else if ([dotValue isEqual:kGoal]) {
                
                xG = x;
                yG = y;
            }
        }
    }
    
    NSMutableArray *stepImageArrays = [NSMutableArray array];
    NSMutableString *stepImageStrings = [NSMutableString string];
    
    for (NSUInteger stepIndex = 0; stepIndex < 4; stepIndex++) {
        
        NSMutableArray *stepImageArray = [NSMutableArray arrayWithArray:wholeMazeImageArray];
        
        for (NSString *turretKey in turrets) {
            
            NSUInteger dotIndex = [turretKey integerValue];
            NSInteger y = dotIndex / N;
            NSInteger x = dotIndex % N;
            
            NSString *turretDirection = [turrets objectForKey:turretKey];
            
            NSUInteger stepTurretDirection = ([turretDirection integerValue] + 1 + stepIndex) % 4;
            
            BOOL dotIsInside = YES;
            NSString *dotValue = kEmptySpace;
            
            while (dotIsInside && ![dotValue isWallOrTurret]) {
                
                if (stepTurretDirection == 0) { // up
                    y--;
                }
                else if (stepTurretDirection == 1) { // right
                    x++;
                }
                else if (stepTurretDirection == 2) { // down
                    y++;
                }
                else if (stepTurretDirection == 3) { // left
                    x--;
                }
                
                dotIsInside = x >= 0 && x <= (N - 1) && y >= 0 && y <= (M - 1);
                
                if (dotIsInside) {
                    
                    NSUInteger dotIndex = y*N + x;
                    
                    dotValue = [wholeMazeImageArray objectAtIndex:dotIndex];
                    
                    if ([dotValue isAllowed]) {
                        
                        NSString *newDotValue = kForbidden;
                        [stepImageArray replaceObjectAtIndex:dotIndex withObject:newDotValue];
                    }
                }
            }
        }
        
        [stepImageArrays addObject:stepImageArray];
        
        /* used for debugging purposes only */
        NSMutableString *stepImageString = [NSMutableString string];
        
        for (NSUInteger y = 0; y < M; y++) {
            for (NSUInteger x = 0; x < N; x++) {
                
                NSUInteger dotIndex = y*N + x;
                
                NSString *dotValue = [stepImageArray objectAtIndex:dotIndex];
                
                [stepImageString appendString:dotValue];
            }
            
            [stepImageString appendString:@"\n"];
        }
        
        [stepImageStrings appendFormat:@"\nstep %lu is \n%@", 1 + stepIndex, stepImageString];
        /**/
    }
    
    NSMutableArray *mazeGraphArray = [NSMutableArray arrayWithArray:wholeMazeImageArray];
    NSMutableArray *stepNodesArrays = [NSMutableArray array];
    
    NSUInteger dotIndex = yS*N + xS;
    NSNumber *dotIndexNumber = [NSNumber numberWithUnsignedInteger:dotIndex];
    [mazeGraphArray replaceObjectAtIndex:dotIndex withObject:kMarked];
    NSMutableArray *stepDotsArray = [NSMutableArray arrayWithObject:dotIndexNumber];
    [stepNodesArrays addObject:stepDotsArray];
    
    NSInteger *moveVector = malloc(2 * sizeof(NSInteger));
    
    NSUInteger stepIndex = 0;
    
    while (stepIndex < M*N) {
        
        NSArray *stepImageArray = [stepImageArrays objectAtIndex:(stepIndex % 4)];
        NSArray *plus1StepImageArray = [stepImageArrays objectAtIndex:((stepIndex + 1) % 4)];
        NSArray *plus2StepImageArray = [stepImageArrays objectAtIndex:((stepIndex + 2) % 4)];
        
        NSUInteger index = stepNodesArrays.count;
        while (index <= stepIndex + 3) {
            [stepNodesArrays addObject:[NSMutableArray array]];
            index++;
        }
        
        NSMutableArray *lastStepDotsArray = [stepNodesArrays objectAtIndex:stepIndex];
        NSMutableArray *stepDotsArray = [stepNodesArrays objectAtIndex:(stepIndex + 1)];
        NSMutableArray *plus1StepDotsArray = [stepNodesArrays objectAtIndex:(stepIndex + 2)];
        NSMutableArray *plus2StepDotsArray = [stepNodesArrays objectAtIndex:(stepIndex + 3)];
        
        if (lastStepDotsArray.count == 0 && stepDotsArray.count == 0 && plus1StepDotsArray.count == 0) {
            
            free(moveVector);
            
            return kLMImpossible;
        }
        
        for (NSNumber *dotIndexNumber in lastStepDotsArray) {
            
            NSUInteger dotIndex = [dotIndexNumber unsignedIntegerValue];
            
            if ([[wholeMazeImageArray objectAtIndex:dotIndex] isGoal]) {
                
                free(moveVector);
                
                return [NSString stringWithFormat:@"%lu", stepIndex];
            }
            
            NSInteger y = dotIndex / N;
            NSInteger x = dotIndex % N;
            
            for (NSInteger moveIndex = 0; moveIndex < 4; moveIndex++) {
                
                [self makeMoveVector:moveVector withIndex:moveIndex];
                
                NSInteger xP = x + moveVector[0];
                NSInteger yP = y + moveVector[1];
                
                NSUInteger dotPIndex = yP*N + xP;
                
                BOOL isInside = xP >= 0 && xP < N && yP >= 0 && yP < M;
                
                if (isInside && ![[mazeGraphArray objectAtIndex:dotPIndex] isMarked]) {
                    
                    NSString *dotValue = [stepImageArray objectAtIndex:dotPIndex];
                    
                    NSNumber *dotPIndexNumber = [NSNumber numberWithUnsignedInteger:dotPIndex];
                    
                    if ([dotValue isAllowed]) {
                        
                        [stepDotsArray addObject:dotPIndexNumber];
                        [mazeGraphArray replaceObjectAtIndex:dotPIndex withObject:kMarked];
                        
                        if ([[wholeMazeImageArray objectAtIndex:dotPIndex] isGoal]) {
                            
                            free(moveVector);
                            
                            return [NSString stringWithFormat:@"%lu", MIN(abs(xG - xS) + abs(yG - yS), (stepIndex + 1))];
                        }
                    }
                    else if ([dotValue isForbidden]) {
                        
                        BOOL canStepAtThisPoint = NO;
                        for (NSInteger moveBackIndex = 0; moveBackIndex < 4; moveBackIndex++) {
                            
                            if (moveBackIndex == moveIndex) continue;
                            
                            [self makeMoveVector:moveVector withIndex:moveBackIndex];
                            
                            NSInteger xB = x + moveVector[0];
                            NSInteger yB = y + moveVector[1];
                            
                            NSUInteger dotBIndex = yB*N + xB;
                            
                            BOOL isInside = xB >= 0 && xB < N && yB >= 0 && yB < M;
                            
                            if (isInside) {
                                
                                NSString *dotValue = [stepImageArray objectAtIndex:dotBIndex];
                                
                                if ([dotValue isAllowed]) {
                                    
                                    canStepAtThisPoint = YES;
                                    break;
                                }
                            }
                        }
                        
                        // check that you can return back to the present point in this plus 1 steps without being shoot
                        dotValue = [plus1StepImageArray objectAtIndex:dotIndex];
                        BOOL canReturnBack = [dotValue isAllowed];
                        
                        // check that you can step to the point P in in this plus 2 steps without being shoot
                        dotValue = [plus2StepImageArray objectAtIndex:dotPIndex];
                        BOOL canStepToDestinationPoint = [dotValue isAllowed];
                        
                        if (canStepAtThisPoint && canReturnBack && canStepToDestinationPoint) {
                            
                            [plus2StepDotsArray addObject:dotPIndexNumber];
                            [mazeGraphArray replaceObjectAtIndex:dotPIndex withObject:kMarked];
                        }
                    }
                }
            }
        }
        
        stepIndex ++;
    }
    
    free(moveVector);
    
    return kLMImpossible;
}

@end
