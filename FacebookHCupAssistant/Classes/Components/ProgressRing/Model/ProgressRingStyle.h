//
//  ProgressRingStyle.h
//  BinaryOptions
//
//  Created by Ilya Borisov on 3/14/14.
//  Copyright (c) 2014 Ilya Borisov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AppKit/AppKit.h>


@interface ProgressRingStyle : NSObject

@property (assign, nonatomic) CGFloat thickness;
@property (assign, nonatomic) CGFloat initialAngle;
@property (assign, nonatomic) BOOL clockwise;

@property (strong, nonatomic) NSColor *color;
@property (assign, nonatomic) CGFloat underlayAlpha;

@property (strong, readonly, nonatomic) NSColor *underlayColor;
@property (strong, readonly, nonatomic) NSColor *progressColor;

@property (strong, nonatomic) NSString *fontName;
@property (assign, nonatomic) CGFloat fontsizeFactor;


+ (ProgressRingStyle *)sharedInstance;

+ (NSColor *)defaultColor;


@end
