//
//  TitoSaysMenuInterfaceController.m
//  TitoSays
//
//  Created by Dulio Denis on 4/20/15.
//  Copyright (c) 2015 Dulio Denis. All rights reserved.
//

#import "TitoSaysMenuInterfaceController.h"
#import "TitoSaysGameInterfaceController.h"

@interface TitoSaysMenuInterfaceController () <TitoSaysGameDelegate>
@property (weak, nonatomic) IBOutlet WKInterfaceButton *startGameButton;
@property (weak, nonatomic) IBOutlet WKInterfaceLabel *gameOverLabel;
@property (weak, nonatomic) IBOutlet WKInterfaceLabel *scoreLabel;
@property (nonatomic) NSNumber *score;
@end

@implementation TitoSaysMenuInterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    
    // Configure interface objects here.
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
    if (self.score) {
        [self.scoreLabel setText:[NSString stringWithFormat:@"Score: %@", self.score]];
        [self.scoreLabel setHidden:NO];
        [self.gameOverLabel setHidden:NO];
    } else {
        [self.gameOverLabel setHidden:YES];
        [self.scoreLabel setHidden:YES];
    }
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}

- (IBAction)startGame {
    [self pushControllerWithName:@"TitoSaysGameInterfaceController" context:self];
}


#pragma mark - TitoSays Game Delegate Methods

- (void)didEndGameWithScore:(NSUInteger)score {
    self.score = @(score);
}

@end



