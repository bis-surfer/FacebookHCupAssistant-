//
//  Settings.m
//  FacebookHCupAssistant
//
//  Created by Ilya Borisov on 2/27/14.
//  Copyright (c) 2014 Ilya Borisov. All rights reserved.
//

#import "Settings.h"

#import "General.h"


#define INPUT_FILE_EXTENSION        @"_input.txt"
#define OUTPUT_FILE_EXTENSION       @"_output.txt"

#define MAIN_DIRECTORY              @"/Users/ilya.borisov/Documents/Google Code Jam/Input-Output/"
#define FILE_NAME                   @"practice"


@interface Settings ()

@end


@implementation Settings

+ (Settings *)sharedInstance {
    
    static Settings *_sharedInstance = nil;
    
    if (!_sharedInstance) {
        
        _sharedInstance = [[Settings alloc] init];
    }
    
    return _sharedInstance;
}

- (id)init {
    
    self = [super init];
    
    if (self) {
        
        //
    }
    
    return self;
}

- (void)setup {
    
    NSString *commonFilePath = [NSString stringWithFormat:@"%@%@", MAIN_DIRECTORY, FILE_NAME];
    self.inputFilePath = [commonFilePath stringByAppendingString:INPUT_FILE_EXTENSION];
}

- (double)progress {
    
    return (double)(self.testCaseIndex + 1)/(double)self.testCasesCount;
}

- (void)setInputFilePath:(NSString *)inputFilePath {
    
    _inputFilePath = inputFilePath;
    
    [self updateOutputFilePath];
}

- (void)updateOutputFilePath {
    
    NSString *inputFileExtension = [[self.inputFilePath componentsSeparatedByString:@"_"] lastObject];
    if ([inputFileExtension rangeOfString:@"input"].length == 0) {
        
        inputFileExtension = [[inputFileExtension componentsSeparatedByString:@"."] lastObject];
    }
    
    NSString *commonFilePath = [self.inputFilePath substringToIndex:(self.inputFilePath.length - inputFileExtension.length - 1)];
    
    self.outputFilePath = [commonFilePath stringByAppendingString:OUTPUT_FILE_EXTENSION];
}

@end
