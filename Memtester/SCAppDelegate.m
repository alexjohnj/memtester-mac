//
//  SCAppDelegate.m
//  Memtester
//
//  Created by Alex Jackson on 07/05/2012.

#import "SCAppDelegate.h"

static NSString * const easyModeHighScores = @"easyModeHighScores";
static NSString * const mediumModeHighScores = @"mediumModeHighScores";
static NSString * const hardModeHighScores = @"hardModeHighScores";

@implementation SCAppDelegate

@synthesize window = _window;
@synthesize difficultyChooser = _levelChooser;
@synthesize gameView;
@synthesize gameViewController;
@synthesize highScoresSheet;

enum levelSelectionConstants{
kEasyMode = 0,
kMediumMode = 1,
kHardMode = 2,
kQuitApplication = 99,
kShowHighScores = 98
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

- (void)showHighScores{
    if(!highScoresSheet)
        highScoresSheet = [[SCHighScoresSheetController alloc] initWithWindowNibName:@"SCHighScoresSheetController"];
    
    [NSApp beginSheet:self.highScoresSheet.window
       modalForWindow:[[NSApp delegate] window]
        modalDelegate:self
       didEndSelector:@selector(didEndSheet:returnCode:contextInfo:)
          contextInfo:NULL];
}

-(IBAction)chooseNewDifficulty:(id)sender{
    [self chooseDifficulty];
}

- (void)didEndSheet:(NSWindow *)sheet returnCode:(NSInteger)returnCode contextInfo:(void *)contextInfo{
    if(sheet == self.difficultyChooser.window){
        if(returnCode == kQuitApplication){
            [sheet orderOut:self];
            [NSApp terminate:self];
        }
        
        if (returnCode == kShowHighScores) {
            [sheet orderOut:self];
            [self showHighScores];
        }
        
        else{
            [self.gameViewController.displayItemsTimer invalidate];
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
    if(sheet == self.highScoresSheet.window){
        [sheet orderOut:self];
        [self chooseDifficulty];
    }
}

-(BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)sender{
    return YES;
}

+(void)initialize{
    NSArray *easyModeScores = [[NSArray alloc] init];
    NSArray *mediumModeScores = [[NSArray alloc] init];
    NSArray *hardModeScores = [[NSArray alloc] init];
    
    NSString *easyModeScoresKey = @"easyModeScores";
    NSString *mediumModeScoresKey = @"mediumModeScores";
    NSString *hardModeScoresKey = @"hardModeScoresKey";
    
    NSArray *defaultsValues = [NSArray arrayWithObjects:easyModeScores, mediumModeScores, hardModeScores, nil];
    NSArray *defaultsKeys = [NSArray arrayWithObjects:easyModeScoresKey, mediumModeScoresKey, hardModeScoresKey, nil];
    
    NSDictionary *defaults = [NSDictionary dictionaryWithObjects:defaultsValues forKeys:defaultsKeys];
    
    [[NSUserDefaults standardUserDefaults] registerDefaults:defaults];
}

@end
