//
//  GameState.h
//  balls
//
//  Created by Gerardo Valdés on 30/08/14.
//  Copyright (c) 2014 Gerardo Valdés. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GameState : NSObject

@property (nonatomic, assign) int score;
@property (nonatomic, assign) int highScore;
@property (nonatomic, assign) int stars;

+ (instancetype)sharedInstance;
- (void) saveState;

@end
