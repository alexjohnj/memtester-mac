//
//  SCDifficultyPickerWindowController.m
//  Memtester
//
//  Created by Alex Jackson on 07/05/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SCDifficultyPickerWindowController.h"

@interface SCDifficultyPickerWindowController ()

@end

@implementation SCDifficultyPickerWindowController

enum levelSelectionConstants{
kEasyMode = 0,
kMediumMode = 1,
kHardMode = 2,
kQuitApplication = 99
};

- (id)initWithWindow:(NSWindow *)window
{
    self = [super initWithWindow:window];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (void)windowDidLoad
{
    [super windowDidLoad];
    
    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
}

-(IBAction)chooseEasyLevel:(id)sender{
    [NSApp endSheet:self.window returnCode:kEasyMode];
}

-(IBAction)chooseMediumLevel:(id)sender{
    [NSApp endSheet:self.window returnCode:kMediumMode];
}

-(IBAction)chooseHardLevel:(id)sender{
    [NSApp endSheet:self.window returnCode:kHardMode];
}

-(IBAction)quit:(id)sender{
    [NSApp endSheet:self.window returnCode:kQuitApplication];
}

@end
