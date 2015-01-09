//
//  ProgressMeter.h
//  FacebookHCupAssistant
//
//  Created by Ilya Borisov on 3/14/14.
//  Copyright (c) 2014 Ilya Borisov. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ProgressMeter : NSObject

@property (assign, nonatomic) double progress;


+ (ProgressMeter *)sharedInstance;

- (void)beginTimeCount;
- (void)endTimeCount;

- (NSTimeInterval)timeSpent;


@end
