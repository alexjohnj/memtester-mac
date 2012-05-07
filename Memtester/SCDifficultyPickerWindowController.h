//
//  SCDifficultyPickerWindowController.h
//  Memtester
//
//  Created by Alex Jackson on 07/05/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface SCDifficultyPickerWindowController : NSWindowController

- (IBAction)chooseEasyLevel:(id)sender;
- (IBAction)chooseMediumLevel:(id)sender;
- (IBAction)chooseHardLevel:(id)sender;
- (IBAction)quit:(id)sender;

@end
