//
//  MasterViewController.m
//  FacebookHCupAssistant
//
//  Created by Ilya Borisov on 2/27/14.
//  Copyright (c) 2014 Ilya Borisov. All rights reserved.
//

#import "MasterViewController.h"

#import "General.h"
#import "Settings.h"
#import "ProgressMeter.h"
#import "Computer.h"

#import "ProgressRingStyle.h"
#import "ProgressRingView.h"


@interface MasterViewController ()

@property (strong, nonatomic) ProgressRingView *progressRingView;

@end


@implementation MasterViewController

- (NSString *)nibName {
    
    return @"MasterView";
}

- (id)init {
    
    self = [super initWithNibName:self.nibName bundle:nil];
    
    if (self) {
        
        [[Settings sharedInstance] addObserver:self forKeyPath:@"inputFilePath" options:NSKeyValueObservingOptionNew context:NULL];
        
        [self addHandlersOfNotifications];
    }
    
    return self;
}

- (void)addHandlersOfNotifications {
    
    [self removeHandlersOfNotifications];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didObtainComputationCompletedNotification:) name:kComputationCompletedNotification object:nil];
}

- (void)removeHandlersOfNotifications {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didObtainComputationCompletedNotification:(NSNotification *)notification {
    
    [[ProgressMeter sharedInstance] endTimeCount];
    
    [self setButtonsEnabled:YES];
}

- (void)loadView {
    
    [super loadView];
    
    [[Settings sharedInstance] setup];
    
    self.progressRingView = [[ProgressRingView alloc] initWithFrame:self.progressRingContainingView.bounds];
    [self.progressRingContainingView addSubview:self.progressRingView];
    self.timeSpentTextField.textColor = [ProgressRingStyle defaultColor];
    [[ProgressMeter sharedInstance] addObserver:self forKeyPath:@"progress" options:NSKeyValueObservingOptionNew context:NULL];
    [self updateProgressDisplay];
    [self updateTimeSpentDisplay];
}

- (IBAction)invokeOpenFileDialog:(id)sender {
    
    // Create the Open File Dialog class
    NSOpenPanel *openFileDlg = [NSOpenPanel openPanel];
    
    [openFileDlg setCanChooseFiles:YES];
    [openFileDlg setCanChooseDirectories:NO];
    [openFileDlg setResolvesAliases:NO];
    [openFileDlg setAllowsMultipleSelection:NO];

    // Display the dialog; if OK button is pressed, Open the File
    if ([openFileDlg runModal] == NSOKButton) {
        
        // Get an array containing the full filenames of all selected files and directories
        NSArray *selectedFileURLs = [openFileDlg URLs];
        
        GeneralLog();
        // Loop through all the selected files and process them
        for (NSURL *selectedFileURL in selectedFileURLs) {
            
            NSString *selectedFilePath = [selectedFileURL path];
            NSLog(@"selectedFilePath: %@", selectedFilePath);
            
            [[Settings sharedInstance] setInputFilePath:selectedFilePath];
        }
    }
}

- (IBAction)computeOutput:(id)sender {
    
    [self setButtonsEnabled:NO];
    
    [[ProgressMeter sharedInstance] beginTimeCount];
    
    [NSThread detachNewThreadSelector:@selector(computeOutputInBackground) toTarget:self withObject:nil];
}

- (void)computeOutputInBackground {
    
    @autoreleasepool {
        
        [Computer computeOutput];
    }
}

- (void)updateInputFileNameDisplay {
    
    NSString *inputFileName = [[[Settings sharedInstance].inputFilePath componentsSeparatedByString:@"/"] lastObject];
    
    [self.inputFileNameTextField setStringValue:inputFileName];
}

- (void)updateTimeSpentDisplay {
    
    NSTimeInterval timeSpent = [ProgressMeter sharedInstance].timeSpent;
    
    NSUInteger minutes = (NSUInteger)timeSpent/60;
    NSUInteger hours   = minutes/60;
    double seconds     = timeSpent - 60.0*(minutes + 60.0*hours);
    
    NSString *orderZero = @"0";
    if (seconds >= 10) {
        orderZero = @"";
    }
    NSString *secondsString = [NSString stringWithFormat:@"%@%.3f", orderZero, seconds];
    if (minutes == 0) {
        orderZero = @"00";
    }
    else if (minutes < 10) {
        orderZero = @"0";
    }
    else {
        orderZero = @"";
    }
    NSString *minutesString = [NSString stringWithFormat:@"%@%.lu", orderZero, minutes];
    if (hours == 0) {
        orderZero = @"00";
    }
    else if (hours < 10) {
        orderZero = @"0";
    }
    else {
        orderZero = @"";
    }
    NSString *hoursString   = [NSString stringWithFormat:@"%@%.lu", orderZero, hours];
    
    NSString *timeSpentString = [NSString stringWithFormat:@"%@:%@:%@", hoursString, minutesString, secondsString];
    
    [self.timeSpentTextField setStringValue:timeSpentString];
}

- (void)setButtonsEnabled:(BOOL)enable {
    
    [self.inputFileNameButton setEnabled:enable];
    [self.computeOutputButton setEnabled:enable];
}

- (void)updateProgressDisplay {
    
    self.progressRingView.progress = [ProgressMeter sharedInstance].progress;
    
    [self.progressRingView updateProgress];
}

#pragma mark -
#pragma mark NSKeyValueObserving Protocol method(s)

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    
    if ([object isEqual:[Settings sharedInstance]]) {
        
        [self updateInputFileNameDisplay];
    }
    else if ([object isEqual:[ProgressMeter sharedInstance]]) {
        
        [self updateProgressDisplay];
        [self updateTimeSpentDisplay];
    }
}

@end
