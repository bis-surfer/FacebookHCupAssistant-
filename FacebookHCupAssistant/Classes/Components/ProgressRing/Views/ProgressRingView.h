//
//  ProgressRingView.h
//  BinaryOptions
//
//  Created by Ilya Borisov on 3/14/14.
//  Copyright (c) 2014 Ilya Borisov. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class ProgressRingStyle;


@interface ProgressRingView : NSView

@property (assign, nonatomic) double progress;


- (ProgressRingStyle *)style;

- (Class)arcViewClass;

- (void)setup;
- (void)invalidate;

- (void)setupUnderlayColor:(NSColor *)underlayColor andProgressColor:(NSColor *)progressColor;

- (void)updateProgress;
- (void)updateColors;


@end
