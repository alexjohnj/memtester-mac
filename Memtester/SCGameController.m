//
//  SCEasyGameController.m
//  Memtester
//
//  Created by Alex Jackson on 07/05/2012.

#import "SCGameController.h"
#import "SCAppDelegate.h"

static NSString * const easyModeHighScores = @"easyModeHighScores";
static NSString * const mediumModeHighScores = @"mediumModeHighScores";
static NSString * const hardModeHighScores = @"hardModeHighScores";

@implementation SCGameController

@synthesize scoreField, itemsGuessField, itemsToGuessField, itemField, submitItemButton, displayItemsTimer, displayItemsTimerCount, difficulty;
@synthesize currentGame;
@synthesize cheatButton1, cheatButton2, cheatButton3;
@synthesize gameOverSheet;

enum sheetDismissalCode{
kNewGame = 0,
kMainMenu = 1,
kQuitGame = 2
};

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil difficultyLevel:(int)level{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if(self){
        difficulty = level;
    }
    
    return self;
}

-(void)awakeFromNib{
    [self startNewGame];
}

-(IBAction)cheat:(id)sender{
    [sender setEnabled:NO];
    self.currentGame.cheatsLeft--;
    
    self.displayItemsTimer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                                              target:self
                                                            selector:@selector(displayItems)
                                                            userInfo:nil
                                                             repeats:YES];
    self.displayItemsTimerCount = 0;
    [self.submitItemButton setEnabled:NO];
    [self.itemsGuessField setEnabled:NO];
    [self.displayItemsTimer fire];
}

- (void)startNewGame{
    [self.displayItemsTimer invalidate];
    self.displayItemsTimer = nil;
    self.currentGame = nil;
    self.currentGame = [[SCGameData alloc] initWithDifficultyLevel:self.difficulty];
    [self.cheatButton1 setEnabled:YES];
    [self.cheatButton2 setEnabled:YES];
    [self.cheatButton3 setEnabled:YES];
    [self getNewItem];
}

- (void)getNewItem{
    [self.currentGame generateNewItem];
    self.displayItemsTimer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                                              target:self
                                                            selector:@selector(displayItem)
                                                            userInfo:nil
                                                             repeats:YES];
    self.displayItemsTimerCount = 0;
    [self.submitItemButton setEnabled:NO];
    [self.itemsGuessField setEnabled:NO];
    [self.displayItemsTimer fire];
}

- (void)displayItem{
    [self.itemField setAlphaValue:0.0];
    if(self.displayItemsTimerCount > self.currentGame.generatedItems.count - 1){
        [self.displayItemsTimer invalidate];
        self.displayItemsTimer = nil;
        [self.submitItemButton setEnabled:YES];
        [self.itemsGuessField setEnabled:YES];
        [self.itemField setStringValue:@""];
        [[self.itemField animator] setAlphaValue:1.0];
        [[[NSApp delegate] window] makeFirstResponder:self.itemsGuessField];
        return;
    }
    
    NSString *currentItem = [self.currentGame.generatedItems objectAtIndex:self.displayItemsTimerCount];
    [self.itemField setStringValue:currentItem];
    [[self.itemField animator] setAlphaValue:1.0];
    
    self.displayItemsTimerCount++;
}

- (IBAction)submitNextItem:(id)sender{
    [self.currentGame storeSubmittedItem:self.itemsGuessField.stringValue];
    if(self.currentGame.itemsLeftToEnter == 0){
        [self checkEnteredItems];
    }
    [self.itemsGuessField setStringValue:@""];
}

- (void)checkEnteredItems{
    [self.scoreField setAlphaValue:0.0];
    BOOL correct = [self.currentGame checkSubmittedItems];
    [self.scoreField.animator setAlphaValue:1.0];
    if(correct){
        [self getNewItem];
    }
    else{
        BOOL highScore = [self checkForHighScore];
        if(highScore == YES){
            self.gameOverSheet = nil;
            self.gameOverSheet = [[SCGameOverSheetController alloc] initWithWindowNibName:@"SCGameOverHighScoreSheet" score:self.currentGame.score isHighScore:YES difficulty:self.currentGame.difficulty];
        }
        else{
            self.gameOverSheet = nil;
            self.gameOverSheet = [[SCGameOverSheetController alloc] initWithWindowNibName:@"SCGameOverLoserSheet" score:self.currentGame.score isHighScore:NO difficulty:self.currentGame.difficulty];
        }
        [NSApp beginSheet:self.gameOverSheet.window
           modalForWindow:[[NSApp delegate] window]
            modalDelegate:self
           didEndSelector:@selector(sheetDidEnd:resultCode:contextInfo:)
              contextInfo:NULL];
    }
}

- (BOOL)checkForHighScore{
    SCHighScoresController *highScoresController = [[SCHighScoresController alloc] init];
    
    if(highScoresController == nil){
        NSLog(@"Couldn't make/find a high scores file");
        return NO;
    }
    
    NSArray *currentDifficultysHighScores;
    if(self.difficulty == 0)
        currentDifficultysHighScores = [highScoresController.highScores valueForKey:easyModeHighScores];
    else if(self.difficulty == 1)
        currentDifficultysHighScores = [highScoresController.highScores valueForKey:mediumModeHighScores];
    else if(self.difficulty == 2)
        currentDifficultysHighScores = [highScoresController.highScores valueForKey:hardModeHighScores];
    
    if(currentDifficultysHighScores.count < 10)
        return YES;
                      
    NSMutableArray *sortedScores = [[currentDifficultysHighScores sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
            if([[obj1 valueForKey:@"score"] integerValue] > [[obj2 valueForKey:@"score"] integerValue])
                return (NSComparisonResult)NSOrderedAscending; //yeah, I know this is the wrong way around. The array's easier to work with if it's reversed though, so using NSOrderedAscending will give me that reversed array easily. 
            
            if([[obj1 valueForKey:@"score"] integerValue] < [[obj2 valueForKey:@"score"] integerValue])
                return (NSComparisonResult)NSOrderedDescending;
            
            return NSOrderedSame;

        }] mutableCopy];
    
    NSLog(@"Unsorted:%@\n Sorted:%@" ,currentDifficultysHighScores, sortedScores);
    
    if(self.currentGame.score > [[[sortedScores objectAtIndex:(sortedScores.count - 1)] valueForKey:@"score"] integerValue]){
        [sortedScores removeObjectAtIndex:(sortedScores.count - 1)];
        if(self.difficulty == 0)
            [highScoresController.highScores setValue:[sortedScores copy] forKey:easyModeHighScores];
        else if(self.difficulty == 1)
            [highScoresController.highScores setValue:[sortedScores copy] forKey:mediumModeHighScores];
        else if(self.difficulty == 2)
            [highScoresController.highScores setValue:[sortedScores copy] forKey:mediumModeHighScores];
        
        [highScoresController saveNewHighScores];
        return YES;
    }
    else
        [highScoresController saveNewHighScores];
        return NO;
    
}

- (void)sheetDidEnd:(NSWindow *)sheet resultCode:(NSInteger)resultCode contextInfo:(void *)contextInfo {
	switch (resultCode) {
        case kNewGame:
            [sheet orderOut:self];
            [self startNewGame];
            break;
            
        case kQuitGame:
            [sheet orderOut:self];
            [NSApp terminate:self];
            break;
        case kMainMenu:
            [sheet orderOut:self];
            SCAppDelegate *appDelegate = (SCAppDelegate *)[NSApp delegate];
            [appDelegate chooseDifficulty];
            break;
    }
}
@end
