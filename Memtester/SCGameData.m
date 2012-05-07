//
//  SCGameData.m
//  Memtester
//
//  Created by Alex Jackson on 07/05/2012.

#import "SCGameData.h"

@implementation SCGameData

@synthesize score, difficulty, generatedItems, enteredItems, itemsLeftToEnter, cheatsLeft;

enum difficulties{
kEasyDifficulty = 0,
kMediumDifficulty = 1,
kHardDifficulty = 2
};

- (id)initWithDifficultyLevel:(int)level{
    self = [super init];
    if(self){
        generatedItems = [[NSMutableArray alloc] init];
        enteredItems = [[NSMutableArray alloc] init];
        score = 0;
        difficulty = level;
        cheatsLeft = 3;
    }
    
    return self;
}

- (void)storeSubmittedItem:(NSString *)anItem{
    [self.enteredItems addObject:anItem];
    self.itemsLeftToEnter = self.generatedItems.count - self.enteredItems.count;
}
 
- (BOOL)checkSubmittedItems{
    if([self.generatedItems isEqualToArray:self.enteredItems]){
        self.score++;
        return YES;
    }
    else{
        return NO;
    }
}

#pragma mark - Item Generation

- (void)generateNewItem{
    [self.enteredItems removeAllObjects];
    
    switch (self.difficulty) {
        case kEasyDifficulty:
            [self generateEasyItem];
            break;
        case kMediumDifficulty:
            [self generateMediumItem];
            break;
        case kHardDifficulty:
            [self generateHardItem];
            break;
    }
    self.itemsLeftToEnter = self.generatedItems.count;
}

- (void)generateEasyItem{
	srand((unsigned int) time(0));
    srand(rand());
    int generatedNumber = 10 + rand() / ( RAND_MAX / ( 0 - 10 ) + 1 );
    [self.generatedItems addObject:[NSString stringWithFormat:@"%d", generatedNumber]];
}

- (void)generateMediumItem{
	srand((unsigned int) time(0));
    srand(rand());
    char generatedLetter = 122 + rand() / ( RAND_MAX / ( 97 - 122 ) + 1 );
    [self.generatedItems addObject:[NSString stringWithFormat:@"%c", generatedLetter]];
}

- (void)generateHardItem{
	srand((unsigned int) time(0));
    srand(rand());
    char generatedCharacter = 126 + rand() / ( RAND_MAX / ( 32 - 126 ) + 1 );
    [self.generatedItems addObject:[NSString stringWithFormat:@"%c", generatedCharacter]];
}

@end
