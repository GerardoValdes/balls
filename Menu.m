//
//  Menu.m
//  balls
//
//  Created by Gerardo Valdés on 16/09/14.
//  Copyright (c) 2014 Gerardo Valdés. All rights reserved.
//

#import "Menu.h"
#import "MyScene.h"
#import <AVFoundation/AVFoundation.h>

@implementation Menu

- (id) initWithSize:(CGSize)size
{
    if (self = [super initWithSize:size]) {
        
        self.backgroundColor = [SKColor colorWithRed:0.23 green:0.27 blue:0.36 alpha:1.0];
        self.playMySound = [SKAction playSoundFileNamed:@"plop.mp3" waitForCompletion:NO];
        
        SKLabelNode *tap = [SKLabelNode labelNodeWithFontNamed:@"Avenir"];
        tap.fontSize = CGRectGetWidth(self.frame)*.07;
        tap.fontColor = [SKColor colorWithRed:0.85 green:0.85 blue:0.85 alpha:1];
        tap.position = CGPointMake(CGRectGetMidX(self.frame),CGRectGetMaxY(self.frame)*.71);
        tap.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeCenter;
        [tap setText:@"TAP"];
        [self addChild:tap];
        
        SKLabelNode *left = [SKLabelNode labelNodeWithFontNamed:@"Avenir"];
        left.fontSize = CGRectGetWidth(self.frame)*.07;
        left.fontColor = [SKColor colorWithRed:0.25 green:0.64 blue:0.68 alpha:1];
        left.position = CGPointMake(CGRectGetMaxX(self.frame)*.35,CGRectGetMaxY(self.frame)*.65);
        left.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeCenter;
        [left setText:@"LEFT"];
        [self addChild:left];
        
        SKLabelNode *or = [SKLabelNode labelNodeWithFontNamed:@"Avenir"];
        or.fontSize = CGRectGetWidth(self.frame)*.07;
        or.fontColor = [SKColor colorWithRed:0.85 green:0.85 blue:0.85 alpha:1];
        or.position = CGPointMake(CGRectGetMidX(self.frame),CGRectGetMaxY(self.frame)*.65);
        or.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeCenter;
        [or setText:@"or"];
        [self addChild:or];
        
        SKLabelNode *right = [SKLabelNode labelNodeWithFontNamed:@"Avenir"];
        right.fontSize = CGRectGetWidth(self.frame)*.07;
        right.fontColor = [SKColor colorWithRed:0.85 green:0.35 blue:0.38 alpha:1];
        right.position = CGPointMake(CGRectGetMaxX(self.frame)*.68,CGRectGetMaxY(self.frame)*.65);
        right.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeCenter;
        [right setText:@"RIGHT"];
        [self addChild:right];
        
        }
    return self;
}


- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    // Transition back to the Game
    [self runAction:_playMySound];
    
    SKScene *myScene = [[MyScene alloc] initWithSize:self.size];
    SKTransition *reveal = [SKTransition fadeWithDuration:0.9];
    [self.view presentScene:myScene transition:reveal];
}

@end
