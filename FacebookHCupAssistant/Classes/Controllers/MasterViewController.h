//
//  MasterViewController.h
//  FacebookHCupAssistant
//
//  Created by Ilya Borisov on 2/27/14.
//  Copyright (c) 2014 Ilya Borisov. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface MasterViewController : NSViewController

@property (strong, nonatomic) IBOutlet NSTextField *inputFileNameTextField;

@property (strong, nonatomic) IBOutlet NSButton *inputFileNameButton;
@property (strong, nonatomic) IBOutlet NSButton *computeOutputButton;

@property (strong, nonatomic) IBOutlet NSView *progressRingContainingView;
@property (strong, nonatomic) IBOutlet NSTextField *timeSpentTextField;


- (IBAction)invokeOpenFileDialog:(id)sender;

- (IBAction)computeOutput:(id)sender;


@end
