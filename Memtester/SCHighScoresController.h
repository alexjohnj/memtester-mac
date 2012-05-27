//
//  SCHighScoresController.h
//  Memtester
//
//  Created by Alex Jackson on 26/05/2012.
//

#import <Foundation/Foundation.h>

@interface SCHighScoresController : NSObject

@property (strong) NSDictionary *highScores; 

- (BOOL)checkHighScoresFileExists;
- (BOOL)createHighScoresFile;
- (void)saveNewHighScores;

@end
