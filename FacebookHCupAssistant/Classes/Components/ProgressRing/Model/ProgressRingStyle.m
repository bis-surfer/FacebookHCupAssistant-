//
//  ProgressRingStyle.m
//  BinaryOptions
//
//  Created by Ilya Borisov on 3/14/14.
//  Copyright (c) 2014 Ilya Borisov. All rights reserved.
//

#import "ProgressRingStyle.h"


@implementation ProgressRingStyle

+ (ProgressRingStyle *)sharedInstance {
    
    static ProgressRingStyle *_sharedInstance = nil;
    
    if (!_sharedInstance) {
        
        _sharedInstance = [[ProgressRingStyle alloc] init];
    }
    
    return _sharedInstance;
}

+ (CGFloat)defaultThickness {
    
    return 0.20;
}

+ (CGFloat)defaultInitialAngle {
    
    return 90.0;
}

+ (BOOL)defaultClockwise {
    
    return YES;
}

+ (NSColor *)defaultColor {
    
    return [NSColor colorWithDeviceRed:88.0/255.0 green:86.0/255.0 blue:214.0/255.0 alpha:1.0];
    
    // iOS7 Violet
}

+ (CGFloat)defaultUnderlayAlpha {
    
    return 0.10;
}

+ (NSString *)defaultFontName {
    
    return @"HelveticaNeue-Light";
}

+ (CGFloat)defaultFontsizeFactor {
    
    return 0.40;
}

- (id)init {
    
    self = [super init];
    
    if (self) {
        
        _thickness     = [ProgressRingStyle defaultThickness];
        _initialAngle  = [ProgressRingStyle defaultInitialAngle];
        _clockwise     = [ProgressRingStyle defaultClockwise];
        
        _color         = [ProgressRingStyle defaultColor];
        
        _underlayAlpha = [ProgressRingStyle defaultUnderlayAlpha];
        
        _fontName       = [ProgressRingStyle defaultFontName];
        _fontsizeFactor = [ProgressRingStyle defaultFontsizeFactor];
        
        [self setupColors];
    }
    
    return self;
}

- (void)setColor:(NSColor *)color {
    
    if ([color isEqual:_color]) {
        
        return;
    }
    
    _color = color;
    
    [self setupColors];
}

- (void)setUnderlayAlpha:(CGFloat)underlayAlpha {
    
    _underlayAlpha = underlayAlpha;
    
    [self setupColors];
}

- (NSArray *)underlayAndProgressColorsFromBaseColor:(NSColor *)baseColor {
    
    NSColor *underlayColor, *progressColor;
    
    if (CGColorGetNumberOfComponents(baseColor.CGColor) == 2) {
        
        CGFloat white = 0.0, alpha = 0.0;
        if ([baseColor respondsToSelector:@selector(getWhite:alpha:)]) {
            // Available in iOS 5.0 and later.
            [baseColor getWhite:&white alpha:&alpha];
        }
        else {
            // Available in iOS 2.0 and later.
            const CGFloat *components = CGColorGetComponents(baseColor.CGColor);
            white = components[0];
            alpha = components[1];
        }
        
        CGFloat absoluteUnderlayAlpha = self.underlayAlpha*alpha;
        CGFloat absoluteProgressAlpha = 1.0 - (1.0 - alpha)/(1.0 - absoluteUnderlayAlpha);
        
        underlayColor = [NSColor colorWithWhite:white alpha:absoluteUnderlayAlpha];
        progressColor = [NSColor colorWithWhite:white alpha:absoluteProgressAlpha];
    }
    else {
        
        CGFloat red = 0.0, green = 0.0, blue = 0.0, alpha = 0.0;
        if ([baseColor respondsToSelector:@selector(getRed:green:blue:alpha:)]) {
            // Available in iOS 5.0 and later.
            [baseColor getRed:&red green:&green blue:&blue alpha:&alpha];
        }
        else {
            // Available in iOS 2.0 and later.
            const CGFloat *components = CGColorGetComponents(baseColor.CGColor);
            red   = components[0];
            green = components[1];
            blue  = components[2];
            alpha = components[3];
        }
        
        CGFloat absoluteUnderlayAlpha = self.underlayAlpha*alpha;
        CGFloat absoluteProgressAlpha = 1.0 - (1.0 - alpha)/(1.0 - absoluteUnderlayAlpha);
        
        underlayColor = [NSColor colorWithDeviceRed:red green:green blue:blue alpha:absoluteUnderlayAlpha];
        progressColor = [NSColor colorWithDeviceRed:red green:green blue:blue alpha:absoluteProgressAlpha];
    }
    
    return [NSArray arrayWithObjects:underlayColor, progressColor, nil];
}

- (void)setupColors {
    
    NSArray *colors = [self underlayAndProgressColorsFromBaseColor:self.color];
    _underlayColor = colors[0];
    _progressColor = colors[1];
}

@end
