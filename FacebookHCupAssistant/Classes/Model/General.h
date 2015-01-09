//
//  General.h
//  FacebookHCupAssistant
//
//  Created by Ilya Borisov on 2/27/14.
//  Copyright (c) 2014 Ilya Borisov. All rights reserved.
//

#import <Foundation/Foundation.h>


#ifdef DEBUG
#   define GeneralLog()  NSLog(@"-[%@ %@]", NSStringFromClass([self class]), NSStringFromSelector(_cmd))
#   define GenCMLog()     NSLog(@"+[%@ %@]", NSStringFromClass([self class]), NSStringFromSelector(_cmd))
#else
#   define GeneralLog()
#   define GenCMLog()
#endif


#define kComputationCompletedNotification @"ComputationCompletedNotification"


@interface General : NSObject

@end
