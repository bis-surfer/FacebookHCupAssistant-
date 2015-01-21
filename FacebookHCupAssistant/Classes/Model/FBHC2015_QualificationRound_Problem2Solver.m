//
//  FBHC2015_QualificationRound_Problem2Solver.m
//  FacebookHCupAssistant
//
//  Created by Ilya Borisov on 1/8/15.
//  Copyright (c) 2015 Ilya Borisov. All rights reserved.
//
//  In order to build fully-functional OS X app (with simple UI)
//  intended to construct output text file by input text file according to Facebook Hacker Cup contest requirements
//  please download Xcode project at https://github.com/bis-surfer/FacebookHCupAssistant-.git
//  and replace file of the same name ("FBHC2015_QualificationRound_Problem2Solver.m") with the present file.
//  Also rewrite method +[Computer specificProblemSolverClass] to return [FBHC2015_QualificationRound_Problem2Solver class].
//
//  New Year's Resolution (2-nd Problem)
//

#import "FBHC2015_QualificationRound_Problem2Solver.h"


@implementation FBHC2015_QualificationRound_Problem2Solver

NSString *kImpossible = @"no";
NSString *kPossible = @"yes";

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
    
    NSArray *desired_PCF = [[inputLines firstObject] componentsSeparatedByString:@" "];
    
    NSInteger desired_P = [[desired_PCF objectAtIndex:0] integerValue];
    NSInteger desired_C = [[desired_PCF objectAtIndex:1] integerValue];
    NSInteger desired_F = [[desired_PCF objectAtIndex:2] integerValue];
    
    unsigned long N = [[inputLines objectAtIndex:1] integerValue];
    
    NSMutableArray* appropriateFoods = [NSMutableArray array];
    
    for (NSUInteger foodIndex = 0; foodIndex < N; foodIndex++) {
        
        NSArray *PCF = [[inputLines objectAtIndex:(2 + foodIndex)] componentsSeparatedByString:@" "];
        
        NSInteger P = [[PCF objectAtIndex:0] integerValue];
        NSInteger C = [[PCF objectAtIndex:1] integerValue];
        NSInteger F = [[PCF objectAtIndex:2] integerValue];
        
        if (P <= desired_P && C <= desired_C && F <= desired_F) {
            
            [appropriateFoods addObject:PCF];
        }
    }
    
    unsigned long M = appropriateFoods.count;
    
    NSInteger *P = malloc(M * sizeof(NSInteger));
    NSInteger *C = malloc(M * sizeof(NSInteger));
    NSInteger *F = malloc(M * sizeof(NSInteger));
    
    NSInteger total_P = 0;
    NSInteger total_C = 0;
    NSInteger total_F = 0;
    
    /* used for debugging purposes only
    NSMutableString *appropriateFoodsString = [NSMutableString string];
     */
    
    for (NSUInteger foodIndex = 0; foodIndex < M; foodIndex++) {
        
        NSArray *PCF = [appropriateFoods objectAtIndex:foodIndex];
        
        P[foodIndex] = [[PCF objectAtIndex:0] integerValue];
        C[foodIndex] = [[PCF objectAtIndex:1] integerValue];
        F[foodIndex] = [[PCF objectAtIndex:2] integerValue];
        
        total_P += P[foodIndex];
        total_C += C[foodIndex];
        total_F += F[foodIndex];
        
        /* used for debugging purposes only
        [appropriateFoodsString appendFormat:@"%lu %lu %lu\n", P[foodIndex], C[foodIndex], F[foodIndex]];
         */
    }
    
    if (total_P < desired_P || total_C < desired_C || total_F < desired_F) {
        
        free(P);
        free(C);
        free(F);
        
        return kImpossible;
        
        /* used for debugging purposes only
        return [NSString stringWithFormat:@"For Alex's desired PCF '%@' with %lu food(s); %lu among them appropriate: \n%@answer is %@ \nbecause total_P < desired_P || total_C < desired_C || total_F < desired_F\n", [inputLines firstObject], N, M, appropriateFoodsString, kImpossible];
         */
    }
    
    NSInteger *inclusion = malloc(M * sizeof(NSInteger));
    
    for (NSUInteger caseIndex = 1; caseIndex < pow(2.0, M); caseIndex++) {
        
        NSUInteger decimal = caseIndex;
        for (NSUInteger foodIndex = 0; foodIndex < M; foodIndex++) {
            
            inclusion[foodIndex] = decimal % 2;
            decimal /= 2;
        }
        
        NSInteger case_P = 0;
        NSInteger case_C = 0;
        NSInteger case_F = 0;
        
        for (NSUInteger foodIndex = 0; foodIndex < M; foodIndex++) {
            
            case_P += inclusion[foodIndex]*P[foodIndex];
            case_C += inclusion[foodIndex]*C[foodIndex];
            case_F += inclusion[foodIndex]*F[foodIndex];
        }
        
        if (case_P == desired_P && case_C == desired_C && case_F == desired_F) {
            
            /* used for debugging purposes only
            NSMutableString *caseString = [NSMutableString string];
            
            for (NSUInteger foodIndex = 0; foodIndex < M; foodIndex++) {
                
                [caseString appendFormat:@"%lu \n", inclusion[foodIndex]];
            }
             */
            
            free(P);
            free(C);
            free(F);
            free(inclusion);
            
            return kPossible;
            
            /* used for debugging purposes only
            return [NSString stringWithFormat:@"For Alex's desired PCF '%@' with %lu food(s); %lu among them appropriate: \n%@answer is %@ \nbecause the following case was found: \n%@(answer was confirmed on %lu-th iteration)\n", [inputLines firstObject], N, M, appropriateFoodsString, kPossible, caseString, caseIndex];
             */
        }
    }
    
    free(P);
    free(C);
    free(F);
    free(inclusion);
    
    return kImpossible;
    
    /* used for debugging purposes only
    return [NSString stringWithFormat:@"For Alex's desired PCF '%@' with %lu food(s); %lu among them appropriate: \n%@answer is %@ \nbecause no right case found\n", [inputLines firstObject], N, M, appropriateFoodsString, kImpossible];
     */
}

@end
