//
//  SCGameData.h
//  Memtester
//
//  Created by Alex Jackson on 07/05/2012.

#import <Foundation/Foundation.h>

@interface SCGameData : NSObject

@property (assign) int score;
@property (assign) int difficulty;
@property (assign) int itemsLeftToEnter;
@property (assign) int cheatsLeft;
@property (retain) NSMutableArray *generatedItems;
@property (retain) NSMutableArray *enteredItems;

-(void)generateNewItem;
-(void)generateEasyItem;
-(void)generateMediumItem;
-(void)generateHardItem;

-(void)storeSubmittedItem:(NSString *)anItem;
-(BOOL)checkSubmittedItems;

-(id)initWithDifficultyLevel:(int)level;

@end
