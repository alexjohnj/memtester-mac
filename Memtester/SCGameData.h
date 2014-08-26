//
//  SCGameData.h
//  Memtester
//
//  Created by Alex Jackson on 07/05/2012.

#import <Foundation/Foundation.h>

@interface SCGameData : NSObject

@property (assign) int score;
@property (assign) NSInteger difficulty;
@property (assign) NSUInteger itemsLeftToEnter;
@property (assign) int cheatsLeft;
@property (copy) NSMutableArray *generatedItems;
@property (copy) NSMutableArray *enteredItems;

-(void)generateNewItem;
-(void)generateEasyItem;
-(void)generateMediumItem;
-(void)generateHardItem;

-(void)storeSubmittedItem:(NSString *)anItem;
-(BOOL)checkSubmittedItems;

-(id)initWithDifficultyLevel:(NSInteger)level;

@end
