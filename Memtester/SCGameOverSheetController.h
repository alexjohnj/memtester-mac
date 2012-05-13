//
//  SCGameOverSheetController.h
//  Memtester
//
//  Created by Alex Jackson on 13/05/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface SCGameOverSheetController : NSWindowController

@property (assign) BOOL isHighScore;
@property (assign) int score;
@property (assign) int difficulty;

@property (weak) IBOutlet NSTextField *scoreField;
@property (weak) IBOutlet NSTextField *nameField;

- (id)initWithWindowNibName:(NSString *)windowNibName score:(int)endScore isHighScore:(BOOL)hScore difficulty:(int)diff;

- (IBAction)quitGame:(id)sender;
- (IBAction)startNewGame:(id)sender;
- (IBAction)goToMainMenu:(id)sender;
- (void)saveHighScore;

@end
