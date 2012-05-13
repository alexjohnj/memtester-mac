//
//  SCDifficultyPickerWindowController.h
//  Memtester
//
//  Created by Alex Jackson on 07/05/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "SCHighScoresSheetController.h"

@interface SCDifficultyPickerWindowController : NSWindowController

@property (strong) SCHighScoresSheetController *highScoresSheet;

- (IBAction)chooseEasyLevel:(id)sender;
- (IBAction)chooseMediumLevel:(id)sender;
- (IBAction)chooseHardLevel:(id)sender;
- (IBAction)showHighScores:(id)sender;
- (IBAction)quit:(id)sender;

@end
