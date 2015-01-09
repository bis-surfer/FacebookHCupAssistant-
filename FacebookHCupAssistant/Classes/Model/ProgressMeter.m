//
//  ProgressMeter.m
//  FacebookHCupAssistant
//
//  Created by Ilya Borisov on 3/14/14.
//  Copyright (c) 2014 Ilya Borisov. All rights reserved.
//

#import "ProgressMeter.h"


@interface ProgressMeter ()

@property (strong, nonatomic) NSDate *beginDate;
@property (strong, nonatomic) NSDate *endDate;

@end


@implementation ProgressMeter

+ (ProgressMeter *)sharedInstance {
    
    static ProgressMeter *_sharedInstance = nil;
    
    if (!_sharedInstance) {
        
        _sharedInstance = [[ProgressMeter alloc] init];
    }
    
    return _sharedInstance;
}

- (id)init {
    
    self = [super init];
    
    if (self) {
        
        self.progress = 0.0;
    }
    
    return self;
}

- (void)beginTimeCount {
    
    self.beginDate = [NSDate date];
    self.endDate   = nil;
}

- (void)endTimeCount {
    
    self.endDate = [NSDate date];
}

- (NSTimeInterval)timeSpent {
    
    if (self.endDate) {
        
        return [self.endDate timeIntervalSinceDate:self.beginDate];
    }
    
    if (self.beginDate) {
        
        return [[NSDate date] timeIntervalSinceDate:self.beginDate];
    }
    
    return 0.0;
}

@end
