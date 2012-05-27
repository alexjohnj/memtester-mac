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
        
        NSString *plistPath = [[NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory, NSUserDirectory, YES) objectAtIndex:0] stringByAppendingPathComponent:@"MemTester/Scores.plist"];
        _highScores = [NSMutableDictionary dictionaryWithContentsOfFile:plistPath];
    }
    
    return self;
}

- (BOOL)checkHighScoresFileExists{
    NSFileManager *fManager = [[NSFileManager alloc] init];
    NSString *plistPath = [[NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory, NSUserDirectory, YES) objectAtIndex:0] stringByAppendingPathComponent:@"MemTester/Scores.plist"];
    
    if([fManager fileExistsAtPath:plistPath])
        return YES;
    else
        return [self createHighScoresFile];
}

- (BOOL)createHighScoresFile{
    NSString *plistPath = [[NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory, NSUserDirectory, YES) objectAtIndex:0] stringByAppendingPathComponent:@"MemTester/Scores.plist"];
    NSString *applicationSupportPath = [[NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory, NSUserDirectory, YES) objectAtIndex:0] stringByAppendingPathComponent:@"MemTester"];
    
    NSFileManager *fManager = [[NSFileManager alloc] init];
    
    if(![fManager fileExistsAtPath:applicationSupportPath]){
        NSError *applicationSupportDirectoryCreationError;
        if(![fManager createDirectoryAtPath:applicationSupportPath withIntermediateDirectories:NO attributes:nil error:&applicationSupportDirectoryCreationError]){
            NSLog(@"Could not create an application support folder: %@", [applicationSupportDirectoryCreationError localizedDescription]);
            return NO;
        }
    }
    
    NSArray *easyModeScores = [[NSArray alloc] init];
    NSArray *mediumModeScores = [[NSArray alloc] init];
    NSArray *hardModeScores = [[NSArray alloc] init];
    
    NSString *easyModeScoresKey = @"easyModeHighScores";
    NSString *mediumModeScoresKey = @"mediumModeHighScores";
    NSString *hardModeScoresKey = @"hardModeHighScores";
    
    NSArray *highScores = [NSArray arrayWithObjects:easyModeScores, mediumModeScores, hardModeScores, nil];
    NSArray *highScoresKeys = [NSArray arrayWithObjects:easyModeScoresKey, mediumModeScoresKey, hardModeScoresKey, nil];
    
    NSDictionary *rootDictionary = [[NSDictionary alloc] initWithObjects:highScores forKeys:highScoresKeys];
    
    if([rootDictionary writeToFile:plistPath atomically:YES])
        return YES;
    else
        return NO;
}

- (void)saveNewHighScores{
    NSString *plistPath = [[NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory, NSUserDirectory, YES) objectAtIndex:0] stringByAppendingPathComponent:@"MemTester/Scores.plist"];
    
    if(![self.highScores writeToFile:plistPath atomically:YES]){
        NSLog(@"Failed to save new high scores plist");
    }
}

@end
