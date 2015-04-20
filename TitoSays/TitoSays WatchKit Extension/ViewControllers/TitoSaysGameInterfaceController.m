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
@end

@implementation TitoSaysGameInterfaceController

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


#pragma mark - Button Action Methods

- (IBAction)upperLeftTapped {
}

- (IBAction)upperRightTapped {
}

- (IBAction)lowerLeftTapped {
}

- (IBAction)lowerRightTapped {
}

@end



