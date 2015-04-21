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
@end

@implementation TitoSaysMenuInterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    
    // Configure interface objects here.
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}

- (IBAction)startGame {
    [self pushControllerWithName:@"TitoSaysGameInterfaceController" context:self];
}

@end



