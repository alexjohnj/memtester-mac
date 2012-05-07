//
//  SCEasyGameController.m
//  Memtester
//
//  Created by Alex Jackson on 07/05/2012.

#import "SCGameController.h"

@implementation SCGameController
@synthesize scoreField, itemsGuessField, itemsToGuessField, itemField, submitItemButton, displayItemsTimer, displayItemsTimerCount, difficulty;
@synthesize currentGame;
@synthesize cheatButton1, cheatButton2, cheatButton3;

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
                                                            selector:@selector(displayItems)
                                                            userInfo:nil
                                                             repeats:YES];
    self.displayItemsTimerCount = 0;
    [self.submitItemButton setEnabled:NO];
    [self.itemsGuessField setEnabled:NO];
    [self.displayItemsTimer fire];
}

- (void)displayItems{
    if(self.displayItemsTimerCount > self.currentGame.generatedItems.count - 1){
        [self.displayItemsTimer invalidate];
        self.displayItemsTimer = nil;
        [self.submitItemButton setEnabled:YES];
        [self.itemsGuessField setEnabled:YES];
        [self.itemField setStringValue:@""];
        [[[NSApp delegate] window] makeFirstResponder:self.itemsGuessField];
        return;
    }
    
    NSString *currentItem = [self.currentGame.generatedItems objectAtIndex:self.displayItemsTimerCount];
    [self.itemField setStringValue:currentItem];
    
    
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
    BOOL correct = [self.currentGame checkSubmittedItems];
    if(correct){
        [self getNewItem];
    }
    else{
        NSAlert *gameOverAlert = [NSAlert alertWithMessageText:@"Game Over :("
                                                 defaultButton:@"Try Again"
                                               alternateButton:@"Quit"
                                                   otherButton:nil
                                     informativeTextWithFormat:[NSString stringWithFormat:@"That wasn't quite right.\n Your score: %d", self.currentGame.score]];
        [gameOverAlert beginSheetModalForWindow:[[NSApp delegate]window]
                                  modalDelegate:self
                                 didEndSelector:@selector(sheetDidEnd:resultCode:contextInfo:)
                                    contextInfo:NULL];
    }
}

- (void)sheetDidEnd:(NSWindow *)sheet resultCode:(NSInteger)resultCode contextInfo:(void *)contextInfo {
	switch (resultCode) {
        case NSAlertDefaultReturn:
            [self startNewGame];
            break;
            
        default:
            [NSApp terminate:self];
            break;
    }
}
@end
