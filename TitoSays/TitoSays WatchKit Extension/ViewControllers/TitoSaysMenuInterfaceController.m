//
//  TitoSaysMenuInterfaceController.m
//  TitoSays
//
//  Created by Dulio Denis on 4/20/15.
//  Copyright (c) 2015 Dulio Denis. All rights reserved.
//

#import "TitoSaysMenuInterfaceController.h"

@interface TitoSaysMenuInterfaceController ()
@property (weak, nonatomic) IBOutlet WKInterfaceButton *startGameButton;
@property (weak, nonatomic) IBOutlet WKInterfaceLabel *gameOverLabel;
@property (weak, nonatomic) IBOutlet WKInterfaceLabel *scoreLabel;
@property (nonatomic) NSArray *currentGameSequence;
@end

@implementation TitoSaysMenuInterfaceController

const static int kGameTurnCount = 1000;

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    
    // Configure interface objects here.
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
    self.currentGameSequence = [self generateNewGameSequence];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}

- (IBAction)startGame {
    [self pushControllerWithName:@"TitoSaysGameInterfaceController" context:self];
}


#pragma mark - Game Sequence 

- (NSArray *)generateNewGameSequence {
    NSMutableArray *newSequence = [NSMutableArray array];
    
    for (int i=0; i < kGameTurnCount; i++) {
        int randomNumber = arc4random() % 4;
        [newSequence addObject:[NSNumber numberWithInt:randomNumber]];
    }
    
    return newSequence;
}

@end



