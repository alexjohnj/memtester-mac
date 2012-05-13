//
//  SCAppDelegate.h
//  Memtester
//
//  Created by Alex Jackson on 07/05/2012.

#import <Cocoa/Cocoa.h>
#import "SCDifficultyPickerWindowController.h"
#import "SCGameController.h"
#import "SCHighScoresSheetController.h"

@interface SCAppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;
@property (strong) SCDifficultyPickerWindowController *difficultyChooser;
@property (weak) IBOutlet NSView *gameView;

@property (strong) SCGameController *gameViewController;

@property (strong) SCHighScoresSheetController *highScoresSheet;

- (IBAction)chooseNewDifficulty:(id)sender;
- (void)chooseDifficulty;
- (void)showHighScores;

- (void)didEndSheet:(NSWindow *)sheet returnCode:(NSInteger)returnCode contextInfo:(void *)contextInfo;

@end
