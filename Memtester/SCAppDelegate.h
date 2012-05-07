//
//  SCAppDelegate.h
//  Memtester
//
//  Created by Alex Jackson on 07/05/2012.

#import <Cocoa/Cocoa.h>
#import "SCLevelPickerWindowController.h"
#import "SCGameController.h"

@interface SCAppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;
@property (strong) SCLevelPickerWindowController *levelChooser;
@property (weak) IBOutlet NSView *gameView;

@property (strong) SCGameController *gameViewController;

-(IBAction)chooseNewDifficulty:(id)sender;

- (void)didEndSheet:(NSWindow *)sheet returnCode:(NSInteger)returnCode contextInfo:(void *)contextInfo;

@end
