//
//  TitoSaysGameInterfaceController.h
//  TitoSays
//
//  Created by Dulio Denis on 4/20/15.
//  Copyright (c) 2015 Dulio Denis. All rights reserved.
//

#import <WatchKit/WatchKit.h>
#import <Foundation/Foundation.h>

@protocol TitoSaysGameDelegate <NSObject>

- (void)didEndGameWithScore:(NSUInteger)score;

@end

@interface TitoSaysGameInterfaceController : WKInterfaceController

@end
