//
//  FBHC2015_Round1_Problem1Solver.m
//  FacebookHCupAssistant
//
//  Created by Ilya Borisov on 1/13/15.
//  Copyright (c) 2015 Ilya Borisov. All rights reserved.
//
//  In order to build fully-functional OS X app (with simple UI)
//  intended to construct output text file by input text file according to Facebook Hacker Cup contest requirements
//  please download Xcode project at https://github.com/bis-surfer/FacebookHCupAssistant-.git
//  and replace file of the same name ("FBHC2015_Round1_Problem1Solver.m") with the present file.
//  Also rewrite method +[Computer specificProblemSolverClass] to return [FBHC2015_Round1_Problem1Solver class].
//
//  Homework (1-st Problem)
//

#import "FBHC2015_Round1_Problem1Solver.h"


@interface FBHC2015_Round1_Problem1Solver () {
    
    BOOL *isPrime;
    long *aPrimacity;
}

@property (strong, nonatomic) NSMutableArray *primeNumbers;
@property (strong, nonatomic) NSMutableDictionary *minimumNumberForPrimacityValue;

@property (nonatomic) long ceilPrimacity;

@end


@implementation FBHC2015_Round1_Problem1Solver

const long N = 10000000;

- (void)buildPrimeNumbersArray {
    
    self.primeNumbers = [NSMutableArray array];
    
    isPrime = malloc((N + 1) * sizeof(BOOL));
    
    for (long i = 0; i <= N; i++) {
        
        isPrime[i] = YES;
    }
    isPrime[0] = NO;
    isPrime[1] = NO;
    
    for (long i = 2; i*i <= N; i++) {
        
        if (isPrime[i]) {
            
            for (long j = i*i; j <= N; j += i) {
                
                isPrime[j] = NO;
            }
        }
    }
    
    for (long i = 2; i <= N; i++) {
        
        if (isPrime[i]) {
            
            NSNumber *primeNumber = [NSNumber numberWithLong:i];
            
            [self.primeNumbers addObject:primeNumber];
        }
    }
    
    free(isPrime);
}

/*
- (long)primacityOfNumber:(long)number {
    
    long primacity = 0;
    
    long indexOfPrimeNumber = 0;
    long i = 2;
    
    while (number > 1) {
        
        if (number % i == 0) {
            
            primacity ++;
            
            // number /= i;
            
            while (number % i == 0) {
                
                number /= i;
            }
        }
        
        indexOfPrimeNumber ++;
        NSNumber *primeNumber = [self.primeNumbers objectAtIndex:indexOfPrimeNumber];
        i = [primeNumber longValue];
    }
    
    return primacity;
}
 */

- (void)buildPrimacityArray {
    
    long *remainder = malloc((N + 1) * sizeof(long));
    aPrimacity = malloc((N + 1) * sizeof(long));
    
    for (long i = 0; i <= N; i++) {
        
        remainder[i] = i;
        aPrimacity[i] = 0;
    }
    
    for (NSNumber *primeNumber in self.primeNumbers) {
        
        long i = [primeNumber longValue];
        
        remainder[i]  = 1;
        aPrimacity[i] = 1;
            
        for (long j = i; j <= N; j += i) {
            
            if (remainder[j] > 1) {
                
                if (remainder[j] % i == 0) {
                    
                    aPrimacity[j] ++;
                    
                    while (remainder[j] % i == 0) {
                        
                        remainder[j] /= i;
                    }
                }
            }
        }
    }
    
    free(remainder);
    // free(aPrimacity);
}

- (void)buildMinimumNumberForPrimacityDictionary {
    
    self.minimumNumberForPrimacityValue = [NSMutableDictionary dictionary];
    
    long primacity = 1;
    long minimumNumberWithPrimacity = 2;
    
    while (minimumNumberWithPrimacity <= N) {
        
        NSString *primacityValueString = [NSString stringWithFormat:@"%li", primacity];
        NSNumber *number = [NSNumber numberWithLong:minimumNumberWithPrimacity];
        [self.minimumNumberForPrimacityValue setObject:number forKey:primacityValueString];
        
        NSNumber *primeNumber = [self.primeNumbers objectAtIndex:primacity];
        long i = [primeNumber longValue];
        
        minimumNumberWithPrimacity *= i;
        
        primacity ++;
    }
    
    self.ceilPrimacity = primacity;
}


- (NSString *)outputForTestCaseWithIndex:(NSUInteger)testCaseIndex andInputLines:(NSArray *)inputLines {
    
    if (!_primeNumbers) {
        
        [self buildPrimeNumbersArray];
        [self buildPrimacityArray];
        [self buildMinimumNumberForPrimacityDictionary];
    }
    
    NSArray *ABK = [[inputLines firstObject] componentsSeparatedByString:@" "];
    
    long A = [[ABK objectAtIndex:0] integerValue];
    long B = [[ABK objectAtIndex:1] integerValue];
    long K = [[ABK objectAtIndex:2] integerValue];
    
    NSUInteger count = 0;
    
    if (K < self.ceilPrimacity) {
        
        NSString *primacityValueString = [NSString stringWithFormat:@"%li", K];
        NSNumber *number = [self.minimumNumberForPrimacityValue objectForKey:primacityValueString];
        long minimumNumberWithGivenPrimacity = [number longValue];
        
        for (long i = MAX(A, minimumNumberWithGivenPrimacity); i <= B; i++) {
            
            // long primacity = [self primacityOfNumber:i];
            long primacity = aPrimacity[i];
            
            if (primacity == K) {
                
                count ++;
            }
        }
    }
    
    return [NSString stringWithFormat:@"%lu", count];
}

@end
