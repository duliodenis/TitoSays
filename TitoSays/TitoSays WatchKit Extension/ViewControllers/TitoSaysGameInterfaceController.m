//
//  TitoSaysGameInterfaceController.m
//  TitoSays
//
//  Created by Dulio Denis on 4/20/15.
//  Copyright (c) 2015 Dulio Denis. All rights reserved.
//

#import "TitoSaysGameInterfaceController.h"

@interface TitoSaysGameInterfaceController ()
@property (weak, nonatomic) IBOutlet WKInterfaceButton *upperLeftButton;
@property (weak, nonatomic) IBOutlet WKInterfaceButton *upperRightButton;
@property (weak, nonatomic) IBOutlet WKInterfaceButton *lowerLeftButton;
@property (weak, nonatomic) IBOutlet WKInterfaceButton *lowerRightButton;
@property (weak, nonatomic) IBOutlet WKInterfaceLabel *notificationLabel;
@property (nonatomic) NSArray *currentGameSequence;
@end

@implementation TitoSaysGameInterfaceController


// Game Sequence Turn Count Constant
const static int kGameTurnCount = 1000;


#pragma mark - Interface Lifecycle

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


#pragma mark - Button Action Methods

- (IBAction)upperLeftTapped {
}

- (IBAction)upperRightTapped {
}

- (IBAction)lowerLeftTapped {
}

- (IBAction)lowerRightTapped {
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

@end



