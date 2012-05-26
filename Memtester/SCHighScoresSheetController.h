//
//  SCHighScoresSheetController.h
//  Memtester
//
//  Created by Alex Jackson on 13/05/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "SCHighScoresController.h"

@interface SCHighScoresSheetController : NSWindowController

@property (weak) IBOutlet NSButton *easyScoresButton;
@property (weak) IBOutlet NSButton *mediumScoresButton;
@property (weak) IBOutlet NSButton *hardScoresButton;
@property (weak) IBOutlet NSTableView *scoresTable;

- (IBAction)easyButtonClicked:(id)sender;
- (IBAction)mediumButtonClicked:(id)sender;
- (IBAction)hardButtonClicked:(id)sender;
- (IBAction)closeHighScores:(id)sender;

@end
