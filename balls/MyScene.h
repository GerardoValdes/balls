//
//  MyScene.h
//  balls
//

//  Copyright (c) 2014 Gerardo Valdés. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "EndGameScene.h"

@interface MyScene : SKScene <SKPhysicsContactDelegate> {

    int cosagris;
    BOOL _gameOver;
}

@property (nonatomic)SKSpriteNode *spriterojo;
@property (nonatomic)SKSpriteNode *spriteazul;
@property (nonatomic)SKSpriteNode *spritegris;
@property (nonatomic)SKSpriteNode *spriteblanco;
@property (nonatomic)SKSpriteNode *bolaazul;
@property (nonatomic)SKSpriteNode *bolaroja;
@property (nonatomic)SKLabelNode *_lblScore;
@property (nonatomic, assign) UIImage *snapshotImage;
@property (strong, nonatomic) SKAction *playMySound;

@end
