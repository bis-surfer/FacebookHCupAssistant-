//
//  AppDelegate.m
//  FacebookHCupAssistant
//
//  Created by Ilya Borisov on 1/8/15.
//  Copyright (c) 2015 Ilya Borisov. All rights reserved.
//

#import "AppDelegate.h"

#import "MasterViewController.h"


@interface AppDelegate ()

@property (weak) IBOutlet NSWindow *window;
@property (strong, nonatomic) MasterViewController *masterViewController;

@end


@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    
    self.masterViewController = [[MasterViewController alloc] init];
    
    NSView *masterView = (NSView *)self.masterViewController.view;
    masterView.frame = ((NSView *)self.window.contentView).bounds;
    
    [self.window.contentView addSubview:self.masterViewController.view];
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

@end
