//
//  TitoSaysGameInterfaceController.m
//  TitoSays
//
//  Created by Dulio Denis on 4/20/15.
//  Copyright (c) 2015 Dulio Denis. All rights reserved.
//

#import "TitoSaysGameInterfaceController.h"

@interface TitoSaysGameInterfaceController ()
@property (nonatomic) NSMutableArray *userInput;
@property (weak, nonatomic) IBOutlet WKInterfaceButton *upperLeftButton;
@property (weak, nonatomic) IBOutlet WKInterfaceButton *upperRightButton;
@property (weak, nonatomic) IBOutlet WKInterfaceButton *lowerLeftButton;
@property (weak, nonatomic) IBOutlet WKInterfaceButton *lowerRightButton;
@property (weak, nonatomic) IBOutlet WKInterfaceLabel *notificationLabel;
@property (nonatomic) NSArray *currentGameSequence;
@property (assign, nonatomic) NSUInteger currentPlayerTurn;
@property (assign, nonatomic) BOOL isBlockingButtons;
@property (weak, nonatomic) id<TitoSaysGameDelegate> delegate;
@end

@implementation TitoSaysGameInterfaceController


// Game Sequence Turn Count and Flash Duration Constants
const static int kGameTurnCount = 1000;
const static float kFlashDuration = 0.4;


#pragma mark - Interface Lifecycle

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    self.delegate = context;
    // Configure interface objects here.
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
    [self startGame];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}


#pragma mark - Button Action Methods

- (IBAction)upperLeftTapped {
    [self playerPressedQuadrant:@(0)];
}


- (IBAction)upperRightTapped {
    [self playerPressedQuadrant:@(1)];
}


- (IBAction)lowerLeftTapped {
    [self playerPressedQuadrant:@(2)];
}


- (IBAction)lowerRightTapped {
    [self playerPressedQuadrant:@(3)];
}


- (void)playerPressedQuadrant:(NSNumber *)quadrant {
    if (self.isBlockingButtons) {
        return;
    }
    
    [self.userInput addObject:quadrant];
    for (NSUInteger i=0; i < [self.userInput count]; i++) {
        if (![self.userInput[i] isEqual:self.currentGameSequence[i]]) {
            // no match! - end game
            [self endGame];
            return;
        }
    }
    
    if ([self.userInput count] == self.currentPlayerTurn) {
        [self startMachineTurn];
    }
}


- (void)startMachineTurn {
    self.currentPlayerTurn++;
    self.isBlockingButtons = YES;
    [self.notificationLabel setText:@"Watch to repeat"];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self playSeriesForTurn:self.currentPlayerTurn];
    });
}


- (void)startPlayerTurn {
    [self.notificationLabel setText:@"Your turn"];
    self.userInput = [NSMutableArray array];
    self.isBlockingButtons = NO;
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


#pragma mark - Game Buttons and Colors

- (NSArray *)gameButtons {
    return @[self.upperLeftButton, self.upperRightButton, self.lowerLeftButton, self.lowerRightButton];
}


- (NSArray *)quadrantColors {
    return @[[UIColor greenColor], [UIColor redColor], [UIColor blueColor], [UIColor yellowColor]];
}


- (NSArray *)quadrantFlashColors {
    NSMutableArray *flashColors = [NSMutableArray array];
    
    for (int i=0; i < [[self quadrantColors] count]; i++) {
        UIColor *flashColor = [[self quadrantColors][i] colorWithAlphaComponent:0.1f];
        [flashColors addObject:flashColor];
    }
    
    return flashColors;
}


#pragma mark - Flash Quadrant

- (void)flashQuadrantWithIndex:(NSUInteger)quadrantIndex withDuration:(float)duration {
    UIColor *startingColor = [[self quadrantColors] objectAtIndex:quadrantIndex];
    UIColor *flashColor = [[self quadrantFlashColors] objectAtIndex:quadrantIndex];
    
    WKInterfaceButton *buttonToFlash = [[self gameButtons] objectAtIndex:quadrantIndex];
    [buttonToFlash setBackgroundColor:flashColor];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(duration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [buttonToFlash setBackgroundColor:startingColor];
    });
}


#pragma mark - Game Start and End Mechanics

- (void)startGame {
    self.currentPlayerTurn = 1;
    self.isBlockingButtons = YES;
    self.currentGameSequence = [self generateNewGameSequence];
    
    [self.notificationLabel setText:@"Ready"];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.notificationLabel setText:@"Set"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.notificationLabel setText:@"Go!"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self playSeriesForTurn:self.currentPlayerTurn];
            });
        });
    });
}


- (void)endGame {
    [self.notificationLabel setText:@"Game Over"];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.delegate didEndGameWithScore:self.currentPlayerTurn];
    });
}


#pragma mark - Game Turn Mechanics

- (void)playSeriesForTurn:(NSUInteger)turnIndex {
    [self playSeriesFromIndex:0 toIndex:turnIndex];
}


// Recursive Method
- (void)playSeriesFromIndex:(NSUInteger)startIndex toIndex:(NSUInteger)finishIndex {
    // base case = the start = the end
    if (startIndex == finishIndex) {
        // start the next player turn
        [self startPlayerTurn];
        return;
    }
    
    NSNumber *currentQuadrant = [self.currentGameSequence objectAtIndex:startIndex];
    [self flashQuadrantWithIndex:[currentQuadrant unsignedIntegerValue] withDuration:kFlashDuration];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self playSeriesFromIndex:startIndex+1 toIndex:finishIndex];
    });
}

@end



