//
//  SCGameOverSheetController.m
//  Memtester
//
//  Created by Alex Jackson on 13/05/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SCGameOverSheetController.h"

static NSString * const easyModeHighScores = @"easyModeHighScores";
static NSString * const mediumModeHighScores = @"mediumModeHighScores";
static NSString * const hardModeHighScores = @"hardModeHighScores";

@implementation SCGameOverSheetController

@synthesize isHighScore, score, difficulty, nameField;
@synthesize scoreField;

enum sheetDismissalCode{
kNewGame = 0,
kMainMenu = 1,
kQuitGame = 2
};

- (id)initWithWindowNibName:(NSString *)windowNibName score:(int)endScore isHighScore:(BOOL)hScore difficulty:(int)diff{
    
    self = [super initWithWindowNibName:windowNibName];
    
    if(self){
        score = endScore;
        isHighScore = hScore;
        difficulty = diff;
    }
    
    return self;
}

- (void)windowDidLoad
{
    [super windowDidLoad];
    
    [self.scoreField setStringValue:[NSString stringWithFormat:@"%d", self.score]];
}

- (void)saveHighScore{
    NSMutableArray *highScores;
    if(self.difficulty == 0)
        highScores = [[[NSUserDefaults standardUserDefaults] arrayForKey:easyModeHighScores] mutableCopy];
    else if(self.difficulty == 1)
        highScores = [[[NSUserDefaults standardUserDefaults] arrayForKey:mediumModeHighScores] mutableCopy];
    else if(self.difficulty == 2)
        highScores = [[[NSUserDefaults standardUserDefaults] arrayForKey:hardModeHighScores] mutableCopy];
    else
        highScores = nil;
    
    if(highScores == nil){
        highScores = [[NSMutableArray alloc] init];
    }
    
    NSString *userName = self.nameField.stringValue;
    if([userName isEqualToString:@""])
        userName = [[NSString alloc] initWithString:@"Anonymous"];
    
    NSMutableDictionary *scoreEntry = [[NSMutableDictionary alloc] init];
    [scoreEntry setValue:userName forKey:@"name"];
    [scoreEntry setValue:[NSNumber numberWithInt:self.score] forKey:@"score"];
    
    [highScores addObject:scoreEntry];
   
    if(self.difficulty == 0)
        [[NSUserDefaults standardUserDefaults] setValue:[highScores copy] forKey:easyModeHighScores];
    else if(self.difficulty == 1)
        [[NSUserDefaults standardUserDefaults] setValue:[highScores copy] forKey:mediumModeHighScores];
    else if(self.difficulty == 2)
        [[NSUserDefaults standardUserDefaults] setValue:[highScores copy] forKey:hardModeHighScores];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (IBAction)quitGame:(id)sender{
    if(self.isHighScore)
        [self saveHighScore];
    [NSApp endSheet:self.window returnCode:kQuitGame];
}

- (IBAction)startNewGame:(id)sender{
    if(self.isHighScore)
        [self saveHighScore];
    [NSApp endSheet:self.window returnCode:kNewGame];
}

- (IBAction)goToMainMenu:(id)sender{
    if(self.isHighScore)
        [self saveHighScore];
    [NSApp endSheet:self.window returnCode:kMainMenu];
}

@end
