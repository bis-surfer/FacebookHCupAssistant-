//
//  FBHC2015_Round1_Problem4Solver.m
//  FacebookHCupAssistant
//
//  Created by Ilya Borisov on 1/18/15.
//  Copyright (c) 2015 Ilya Borisov. All rights reserved.
//
//  In order to build fully-functional OS X app (with simple UI)
//  intended to construct output text file by input text file according to Facebook Hacker Cup contest requirements
//  please download Xcode project at https://github.com/bis-surfer/FacebookHCupAssistant-.git
//  and replace file of the same name ("FBHC2015_Round1_Problem4Solver.m") with the present file.
//  Also rewrite method +[Computer specificProblemSolverClass] to return [FBHC2015_Round1_Problem4Solver class].
//
//  Corporate Gifting (4-th Problem)
//

#import "FBHC2015_Round1_Problem4Solver.h"


@implementation FBHC2015_Round1_Problem4Solver

- (NSUInteger)linesPerCaseCount {
    
    return 2;
}

const BOOL orderedHierarchically = YES;

- (NSString *)outputForTestCaseWithIndex:(NSUInteger)testCaseIndex andInputLines:(NSArray *)inputLines {
    
    NSInteger N = [[inputLines firstObject] integerValue];
    
    NSArray *managerIDs = [[inputLines lastObject] componentsSeparatedByString:@" "];
    
    NSInteger *subordinatesCount = malloc(N * sizeof(NSInteger));
    NSInteger *level = malloc(N * sizeof(NSInteger));
    level[0] = 1;
    
    if (!orderedHierarchically) {
        for (NSUInteger employeeID = 1; employeeID <= N; employeeID++) {
            subordinatesCount[employeeID] = 0;
        }
    }
    
    NSInteger lastManagerID = 0;
    NSInteger lastLevel = 0;
    
    for (NSInteger employeeID = 1; employeeID <= N; employeeID++) {
        
        if (orderedHierarchically) {
            subordinatesCount[(employeeID - 1)] = 0;
        }
        
        NSString *employeeManagerIDString = [managerIDs objectAtIndex:(employeeID - 1)];
        NSInteger employeeManagerID = [employeeManagerIDString integerValue];
        
        subordinatesCount[(employeeManagerID - 1)] += 1;
        
        if (employeeManagerID > 0) {
            
            level[(employeeID - 1)] = 1 + level[(employeeManagerID - 1)];
        }
        
        if (lastManagerID < employeeManagerID) {
            
            lastManagerID = employeeManagerID;
        }
        
        if (lastLevel < level[(employeeID - 1)]) {
            
            lastLevel = level[(employeeID - 1)];
        }
    }
    
    NSInteger *singleSubordinatesCount = malloc(N * sizeof(NSInteger));
    
    for (NSInteger employeeID = 1; employeeID <= N; employeeID++) {
        
        singleSubordinatesCount[(employeeID - 1)] = subordinatesCount[(employeeID - 1)];
        
        NSString *employeeManagerIDString = [managerIDs objectAtIndex:(employeeID - 1)];
        NSInteger employeeManagerID = [employeeManagerIDString integerValue];
        
        if (subordinatesCount[(employeeID - 1)] > 0) {
            
            singleSubordinatesCount[(employeeManagerID - 1)] -= 1;
        }
    }
    
    unsigned long long totalExpenditure = N;
    
    for (NSInteger employeeID = lastManagerID; employeeID >= 1; employeeID --) {
        
        if (subordinatesCount[(employeeID - 1)] > 1) {
            
            if (singleSubordinatesCount[(employeeID - 1)] < subordinatesCount[(employeeID - 1)]) {
                
                if (singleSubordinatesCount[(employeeID - 1)] < 2) {
                    
                    totalExpenditure += singleSubordinatesCount[(employeeID - 1)];
                }
                else {
                    
                    totalExpenditure += 2;
                }
            }
            else {
                
                totalExpenditure += 1;
            }
        }
        else {
            
            totalExpenditure += (lastLevel - level[(employeeID - 1)]) % 2;
        }
    }
    
    free(singleSubordinatesCount);
    free(subordinatesCount);
    free(level);
    
    return [NSString stringWithFormat:@"%llu", totalExpenditure];
}

@end
