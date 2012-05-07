//
//  SCAppDelegate.m
//  Memtester
//
//  Created by Alex Jackson on 07/05/2012.

#import "SCAppDelegate.h"

@implementation SCAppDelegate

@synthesize window = _window;
@synthesize difficultyChooser = _levelChooser;
@synthesize gameView;
@synthesize gameViewController;

enum levelSelectionConstants{
kEasyMode = 0,
kMediumMode = 1,
kHardMode = 2,
kQuitApplication = 99
}; 

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    [self chooseDifficulty];
}

-(void)chooseDifficulty{
    if(_levelChooser == nil)
        _levelChooser = [[SCDifficultyPickerWindowController alloc] initWithWindowNibName:@"SCDifficultyPickerWindow"];
    
    [NSApp beginSheet:self.difficultyChooser.window
       modalForWindow:[[NSApp delegate] window]
        modalDelegate:self
       didEndSelector:@selector(didEndSheet:returnCode:contextInfo:)
          contextInfo:nil];
}

-(IBAction)chooseNewDifficulty:(id)sender{
    [self chooseDifficulty];
}

- (void)didEndSheet:(NSWindow *)sheet returnCode:(NSInteger)returnCode contextInfo:(void *)contextInfo{
    if(returnCode == kQuitApplication){
        [sheet orderOut:self];
        [NSApp terminate:self];
    }
    else{
        self.gameViewController = nil;
        self.gameViewController = [[SCGameController alloc] initWithNibName:@"SCGameView" bundle:[NSBundle mainBundle] difficultyLevel:returnCode];
        if(self.gameView.subviews.count == 0){
            [self.gameView addSubview:self.gameViewController.view];
        }
        else{
            [self.gameView replaceSubview:[self.gameView.subviews objectAtIndex:0] with:self.gameViewController.view];
        }
        
        [sheet orderOut:self];
    }
}

@end
