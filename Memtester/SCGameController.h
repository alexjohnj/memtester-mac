//
//  SCEasyGameController.h
//  Memtester
//
//  Created by Alex Jackson on 07/05/2012.

#import <Foundation/Foundation.h>
#import "SCGameData.h"
#import "SCGameOverSheetController.h"
#import "SCHighScoresController.h"

@interface SCGameController : NSViewController

@property (weak) IBOutlet NSTextField *scoreField;
@property (weak) IBOutlet NSTextField *itemsToGuessField;
@property (weak) IBOutlet NSTextField *itemsGuessField;
@property (weak) IBOutlet NSTextField *itemField;
@property (weak) IBOutlet NSButton *submitItemButton;
@property (weak) IBOutlet NSButton *cheatButton1;
@property (weak) IBOutlet NSButton *cheatButton2;
@property (weak) IBOutlet NSButton *cheatButton3;


@property (assign) int difficulty;
@property (strong) SCGameData *currentGame;

@property (strong) SCGameOverSheetController *gameOverSheet;

// These iVars are for keeping track of the time between each item being displayed.
@property (strong) NSTimer *displayItemsTimer;
@property (assign) int displayItemsTimerCount;


- (IBAction)submitNextItem:(id)sender;
- (IBAction)cheat:(id)sender;

- (void)startNewGame;
- (void)getNewItem;
- (void)displayItems;

- (void)checkEnteredItems;

-(BOOL)checkForHighScore;

- (void)sheetDidEnd:(NSWindow *)sheet resultCode:(NSInteger)resultCode contextInfo:(void *)contextInfo;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil difficultyLevel:(int)level;

@end
