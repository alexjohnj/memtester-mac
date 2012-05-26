//
//  SCHighScoresController.m
//  Memtester
//
//  Created by Alex Jackson on 26/05/2012.
//

#import "SCHighScoresController.h"

@implementation SCHighScoresController

@synthesize highScores = _highScores;

- (id)init{
    self = [super init];
    
    if(self){
        if(![self checkHighScoresFileExists]){
            return nil;
        }
        
        NSString *plistPath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDirectory, YES) objectAtIndex:0] stringByAppendingPathComponent:@"Scores.plist"];
        _highScores = [NSDictionary dictionaryWithContentsOfFile:plistPath];
    }
    
    return self;
}

- (BOOL)checkHighScoresFileExists{
    NSFileManager *fManager = [[NSFileManager alloc] init];
    NSString *plistPath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDirectory, YES) objectAtIndex:0] stringByAppendingPathComponent:@"Scores.plist"];
    
    if([fManager fileExistsAtPath:plistPath])
        return YES;
    else
        return [self createHighScoresFile];
}

- (BOOL)createHighScoresFile{
    NSString *plistPath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDirectory, YES) objectAtIndex:0] stringByAppendingPathComponent:@"Scores.plist"];
    
    NSArray *easyModeScores = [[NSArray alloc] init];
    NSArray *mediumModeScores = [[NSArray alloc] init];
    NSArray *hardModeScores = [[NSArray alloc] init];
    
    NSString *easyModeScoresKey = @"easyModeScores";
    NSString *mediumModeScoresKey = @"mediumModeScores";
    NSString *hardModeScoresKey = @"hardModeScoresKey";
    
    NSArray *highScores = [NSArray arrayWithObjects:easyModeScores, mediumModeScores, hardModeScores, nil];
    NSArray *highScoresKeys = [NSArray arrayWithObjects:easyModeScoresKey, mediumModeScoresKey, hardModeScoresKey, nil];
    
    NSDictionary *rootDictionary = [[NSDictionary alloc] initWithObjects:highScores forKeys:highScoresKeys];
    
    if([rootDictionary writeToFile:plistPath atomically:YES])
        return YES;
    else
        return NO;
}

- (void)saveNewHighScoresFile{
    NSString *plistPath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDirectory, YES) objectAtIndex:0] stringByAppendingPathComponent:@"Scores.plist"];
    
    if(![self.highScores writeToFile:plistPath atomically:YES]){
        NSLog(@"Failed to save new high scores plist");
    }
}

@end
