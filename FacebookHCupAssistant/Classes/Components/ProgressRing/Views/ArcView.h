//
//  ArcView.h
//  BinaryOptions
//
//  Created by Ilya Borisov on 3/14/14.
//  Copyright (c) 2014 Ilya Borisov. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface ArcView : NSView

@property (assign, nonatomic) CGFloat radius;
@property (assign, nonatomic) CGFloat lineWidth;
@property (assign, nonatomic) CGFloat startAngle;
@property (assign, nonatomic) CGFloat endAngle;
@property (assign, nonatomic) BOOL clockwise;

@property (strong, nonatomic) NSColor *color;


- (id)initWithFrame:(NSRect)frame radius:(CGFloat)radius lineWidth:(CGFloat)lineWidth startAngle:(CGFloat)startAngle endAngle:(CGFloat)endAngle clockwise:(BOOL)clockwise color:(NSColor *)color;


@end
