//
//  ProgressRingView.m
//  BinaryOptions
//
//  Created by Ilya Borisov on 3/14/14.
//  Copyright (c) 2014 Ilya Borisov. All rights reserved.
//

#import "ProgressRingView.h"

#import "ProgressRingStyle.h"
#import "ArcView.h"


@interface ProgressRingView ()

@property (assign, nonatomic) CGFloat radius;
@property (assign, nonatomic) CGFloat lineWidth;

@property (strong, nonatomic) ProgressRingStyle *style;

@property (strong, nonatomic) ArcView *underlayArcView;
@property (strong, nonatomic) ArcView *progressArcView;

@end


@implementation ProgressRingView

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.style = [[ProgressRingStyle alloc] init];
        
        [self setup];
    }
    
    return self;
}

- (ProgressRingStyle *)style {
    
    return _style;
}

- (Class)arcViewClass {
    
    return [ArcView class];
}

- (void)setupGeometry {
    
    CGFloat halfWidth = 0.5*CGRectGetWidth(self.bounds);
    CGFloat halfHeight = 0.5*CGRectGetHeight(self.bounds);
    CGFloat externalRadius = MIN(halfWidth, halfHeight);
    
    self.lineWidth = self.style.thickness*externalRadius;
    self.radius = externalRadius - 0.5*self.lineWidth;
}

- (void)setup {
    
    [self setupGeometry];
    
    self.underlayArcView = [[self.arcViewClass alloc] initWithFrame:self.bounds radius:self.radius lineWidth:self.lineWidth startAngle:self.style.initialAngle endAngle:(self.style.initialAngle - 360.0) clockwise:self.style.clockwise color:self.style.underlayColor];
    [self addSubview:self.underlayArcView];
    
    self.progressArcView = [[self.arcViewClass alloc] initWithFrame:self.bounds radius:self.radius lineWidth:self.lineWidth startAngle:self.style.initialAngle endAngle:(self.style.initialAngle - self.deltaAngle) clockwise:self.style.clockwise color:self.style.progressColor];
    [self addSubview:self.progressArcView];
}

- (void)invalidate {
    
    [self.progressArcView removeFromSuperview];
    self.progressArcView = nil;
    
    [self.underlayArcView removeFromSuperview];
    self.underlayArcView = nil;
}

- (void)setupUnderlayColor:(NSColor *)underlayColor andProgressColor:(NSColor *)progressColor {
    
    self.underlayArcView.color = underlayColor;
    self.progressArcView.color = progressColor;
    
    [self.underlayArcView setNeedsDisplay:YES];
}

- (CGFloat)deltaAngle {
    
    CGFloat directionMultiplier = self.style.clockwise ? 1.0 : (- 1.0);
    
    return 360.0*directionMultiplier*self.progress;
}

- (void)updateProgress {
    
    self.progressArcView.endAngle = self.style.initialAngle - self.deltaAngle;
    
    [self.progressArcView setNeedsDisplay:YES];
}

- (void)updateColors {
    
    [self setupUnderlayColor:self.style.underlayColor andProgressColor:self.style.progressColor];
}

@end
