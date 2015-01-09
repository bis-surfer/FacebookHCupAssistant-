//
//  ArcView.m
//  BinaryOptions
//
//  Created by Ilya Borisov on 3/14/14.
//  Copyright (c) 2014 Ilya Borisov. All rights reserved.
//

#import "ArcView.h"


@interface ArcView ()

@property (assign, nonatomic) NSPoint center;

@end


@implementation ArcView

- (id)initWithFrame:(NSRect)frame radius:(CGFloat)radius lineWidth:(CGFloat)lineWidth startAngle:(CGFloat)startAngle endAngle:(CGFloat)endAngle clockwise:(BOOL)clockwise color:(NSColor *)color {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        _radius     = radius;
        _lineWidth  = lineWidth;
        _startAngle = startAngle;
        _endAngle   = endAngle;
        _clockwise  = clockwise;
        
        _color = color;
        
        [self setup];
    }
    
    return self;
}

- (void)setup {
    
    self.center = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
    
    // (typedef CGPoint NSPoint;)
}

- (void)drawRect:(NSRect)dirtyRect {
    
    [super drawRect:dirtyRect];
    
    NSBezierPath *arc = [NSBezierPath bezierPath];
    [arc appendBezierPathWithArcWithCenter:self.center radius:self.radius startAngle:self.startAngle endAngle:self.endAngle clockwise:self.clockwise];
    
    arc.lineWidth = self.lineWidth;
    
    [self.color setStroke];
    [arc stroke];
}

@end
