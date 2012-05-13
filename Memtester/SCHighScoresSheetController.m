//
//  SCHighScoresSheetController.m
//  Memtester
//
//  Created by Alex Jackson on 13/05/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SCHighScoresSheetController.h"

static NSString * const easyModeHighScores = @"easyModeHighScores";
static NSString * const mediumModeHighScores = @"mediumModeHighScores";
static NSString * const hardModeHighScores = @"hardModeHighScores";


@implementation SCHighScoresSheetController

@synthesize easyScoresButton, mediumScoresButton, hardScoresButton, scoresTable;

- (id)initWithWindow:(NSWindow *)window
{
    self = [super initWithWindow:window];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (void)windowDidLoad
{
    [super windowDidLoad];
    
    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
}

- (IBAction)easyButtonClicked:(id)sender{
    if(self.easyScoresButton.state == NSOffState && self.mediumScoresButton.state == NSOffState && self.hardScoresButton.state == NSOffState)
        self.easyScoresButton.state = NSOnState;
    
    if(self.easyScoresButton.state == NSOnState){
        self.mediumScoresButton.state = NSOffState;
        self.hardScoresButton.state = NSOffState;
    }
    
    [scoresTable reloadData];
}

- (IBAction)mediumButtonClicked:(id)sender{
    if(self.easyScoresButton.state == NSOffState && self.mediumScoresButton.state == NSOffState && self.hardScoresButton.state == NSOffState)
        self.mediumScoresButton.state = NSOnState;
    
    if(self.mediumScoresButton.state == NSOnState){
        self.easyScoresButton.state = NSOffState;
        self.hardScoresButton.state = NSOffState;
    }

    [scoresTable reloadData];
}

- (IBAction)hardButtonClicked:(id)sender{
    if(self.easyScoresButton.state == NSOffState && self.mediumScoresButton.state == NSOffState && self.hardScoresButton.state == NSOffState)
        self.hardScoresButton.state = NSOnState;
    
    if(self.hardScoresButton.state == NSOnState){
        self.mediumScoresButton.state = NSOffState;
        self.easyScoresButton.state = NSOffState;
    }
    
    [scoresTable reloadData];
}

- (IBAction)closeHighScores:(id)sender{
    [NSApp endSheet:self.window];
}

#pragma mark - TableView Datasource Methods

- (NSInteger)numberOfRowsInTableView:(NSTableView *)aTableView{
    NSArray *highScoresArray;
    if(self.easyScoresButton.state == NSOnState){
        highScoresArray = [[NSUserDefaults standardUserDefaults] arrayForKey:easyModeHighScores];
    }
    
    else if(self.mediumScoresButton.state == NSOnState){
        highScoresArray = [[NSUserDefaults standardUserDefaults] arrayForKey:mediumModeHighScores];
    }
    
    else if(self.hardScoresButton.state == NSOnState){
        highScoresArray = [[NSUserDefaults standardUserDefaults] arrayForKey:hardModeHighScores];
    }
    
    return highScoresArray.count;
    
}

- (id)tableView:(NSTableView *)aTableView objectValueForTableColumn:(NSTableColumn *)aTableColumn row:(NSInteger)rowIndex{
    NSArray *highScoresArray;
    if(self.easyScoresButton.state == NSOnState){
       highScoresArray = [[NSUserDefaults standardUserDefaults] arrayForKey:easyModeHighScores];
    }
    
    else if(self.mediumScoresButton.state == NSOnState){
         highScoresArray = [[NSUserDefaults standardUserDefaults] arrayForKey:mediumModeHighScores];
    }
    
    else if(self.hardScoresButton.state == NSOnState){
         highScoresArray = [[NSUserDefaults standardUserDefaults] arrayForKey:hardModeHighScores];
    }
    
    else{
        return nil;
    }
    
    NSArray *sortedScores = [highScoresArray sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        if([[obj1 valueForKey:@"score"] integerValue] > [[obj2 valueForKey:@"score"] integerValue])
            return (NSComparisonResult)NSOrderedAscending; //yeah, I know this is the wrong way around. The array's easier to work with if it's reversed though, so using NSOrderedAscending will give me that reversed array easily. 
        
        if([[obj1 valueForKey:@"score"] integerValue] < [[obj2 valueForKey:@"score"] integerValue])
            return (NSComparisonResult)NSOrderedDescending;
        
        return NSOrderedSame;
        
    }];
    if(sortedScores == nil)
        return nil;
    else
        return [[sortedScores objectAtIndex:rowIndex] valueForKey:aTableColumn.identifier];
}

@end
