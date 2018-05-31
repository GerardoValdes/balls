//
//  MyScene.m
//  balls
//
//  Created by Gerardo Valdés on 21/08/14.
//  Copyright (c) 2014 Gerardo Valdés. All rights reserved.

#import "MyScene.h"
#import <AVFoundation/AVFoundation.h>
#import <GameKit/GameKit.h>

@implementation MyScene

- (void) endGame
{
    _gameOver = YES;

    [[GameState sharedInstance] saveState];
    
    SKScene *endGameScene = [[EndGameScene alloc] initWithSize:self.size];
    SKTransition *reveal = [SKTransition fadeWithDuration:0.5];
    [self.view presentScene:endGameScene transition:reveal];
}

-(void)bola{
    
    int azuloroja;
    int varicacion;
    azuloroja = arc4random_uniform(2) + 1;
    varicacion = arc4random_uniform(4) + 1;
    
    if(azuloroja == 1){
    
    SKTextureAtlas *atlasball = [SKTextureAtlas atlasNamed:@"ball"];
    SKTexture *rojo = [atlasball textureNamed:@"bolaroja.png"];
    
    self.bolaroja =[SKSpriteNode spriteNodeWithTexture:rojo];
    self.bolaroja.size = CGSizeMake(CGRectGetMaxX(self.frame)*.05,CGRectGetMaxX(self.frame)*.05);
    self.bolaroja.position = CGPointMake(CGRectGetMidX(self.frame) + varicacion,CGRectGetMaxY(self.frame) + self.bolaroja.size.height);
    self.bolaroja.name = @"bolarojo";
    self.bolaroja.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:(CGRectGetMaxX(self.frame)*.05)/2];
    self.bolaroja.physicsBody.dynamic = YES;
    self.bolaroja.physicsBody.affectedByGravity = YES;
    self.bolaroja.physicsBody.restitution = .1;
    [self addChild:self.bolaroja];
        
    }
    
    else if(azuloroja == 2){
    
        SKTextureAtlas *atlasball = [SKTextureAtlas atlasNamed:@"ball"];
        SKTexture *azul = [atlasball textureNamed:@"bolaazul.png"];
        
        self.bolaazul =[SKSpriteNode spriteNodeWithTexture:azul];
        self.bolaazul.size = CGSizeMake(CGRectGetMaxX(self.frame)*.05,CGRectGetMaxX(self.frame)*.05);
         self.bolaazul.position = CGPointMake(CGRectGetMidX(self.frame) + varicacion,CGRectGetMaxY(self.frame) + self.bolaazul.size.height);
        self.bolaazul.name = @"bolaazul";
        self.bolaazul.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:(CGRectGetMaxX(self.frame)*.05)/2];
        self.bolaazul.physicsBody.dynamic = YES;
        self.bolaazul.physicsBody.affectedByGravity = YES;
        self.bolaazul.physicsBody.restitution = .1;
        [self addChild:self.bolaazul];
    
    }
    
#define IPAD UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad
    
    if (IPAD) {self.physicsWorld.gravity = CGVectorMake(0.0f, -12.0f);}
    else  {self.physicsWorld.gravity = CGVectorMake(0.0f, -6.0f);}
    
    }


-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        
        [GameState sharedInstance].score = 0;
        _gameOver = NO;
        cosagris = 0;
        
        self.playMySound = [SKAction playSoundFileNamed:@"plop.mp3" waitForCompletion:NO];
        
        /////SCORE INIT//////
        self.backgroundColor = [SKColor colorWithRed:0.23 green:0.27 blue:0.36 alpha:1.0];
        self._lblScore = [SKLabelNode labelNodeWithFontNamed:@"Avenir"];
        self. _lblScore.fontSize = CGRectGetWidth(self.frame)/2.6;
        self._lblScore.fontColor = [SKColor colorWithRed:0.847 green:0.847 blue:0.847 alpha:1];
        self._lblScore.position = CGPointMake(CGRectGetMidX(self.frame),CGRectGetMaxY(self.frame)*.66);
        self._lblScore.alpha = .5;
        [self._lblScore setText:@"0"];
        [self addChild:self._lblScore];

        ////draw Sprites////
        
        SKTextureAtlas *atlasball = [SKTextureAtlas atlasNamed:@"ball"];
        SKTexture *rojo = [atlasball textureNamed:@"cuadrorojo.png"];
        self.spriterojo =[SKSpriteNode spriteNodeWithTexture:rojo];
        self.spriterojo.position = CGPointMake(CGRectGetMidX(self.frame),0);
        self.spriterojo.size = CGSizeMake(CGRectGetWidth(self.frame),CGRectGetHeight(self.frame)/3);
        self.spriterojo.name = @"rojo";
        self.spriterojo.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.spriterojo.size];
        self.spriterojo.physicsBody.dynamic = NO;
        self.spriterojo.physicsBody.affectedByGravity = NO;
        [self addChild:self.spriterojo];
        
        SKTexture *azul = [atlasball textureNamed:@"cuadroazul.png"];
        self.spriteazul =[SKSpriteNode spriteNodeWithTexture:azul];
        self.spriteazul.position = CGPointMake(0,0);
        self.spriteazul.size = CGSizeMake(CGRectGetWidth(self.frame),CGRectGetHeight(self.frame)/3);
        self.spriteazul.name = @"azul";
        self.spriteazul.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.spriteazul.size];
        self.spriteazul.physicsBody.dynamic = NO;
        self.spriteazul.physicsBody.affectedByGravity = NO;
        [self addChild:self.spriteazul];
        
        SKTexture *gris = [atlasball textureNamed:@"cuadrogris.png"];
        self.spritegris =[SKSpriteNode spriteNodeWithTexture:gris];
        self.spritegris.position = CGPointMake(CGRectGetMidX(self.frame),CGRectGetMaxY(self.frame)*.5);
        self.spritegris.size = CGSizeMake(CGRectGetWidth(self.frame)*.25,CGRectGetWidth(self.frame)*.018);
        self.spritegris.name = @"gris";
        self.spritegris.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.spritegris.size];
        self.spritegris.physicsBody.dynamic = NO;
        self.spritegris.physicsBody.affectedByGravity = NO;
        [self addChild:self.spritegris];
        
        SKTexture *blanco = [atlasball textureNamed:@"cuadrobalnco.png"];
        self.spriteblanco =[SKSpriteNode spriteNodeWithTexture:blanco];
        self.spriteblanco.position = CGPointMake(CGRectGetMidX(self.frame),CGRectGetMaxY(self.frame)*.20);
        self.spriteblanco.size = CGSizeMake(CGRectGetWidth(self.frame)*.03,CGRectGetWidth(self.frame)*.07);
        self.spriteblanco.name = @"blanco";
        self.spriteblanco.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.spriteblanco.size];
        self.spriteblanco.physicsBody.dynamic = NO;
        self.spriteblanco.physicsBody.affectedByGravity = NO;
        self.spriteblanco.alpha = 0;
        [self addChild:self.spriteblanco];
        
        
        //////spawn balls/////////
        SKAction *intervalo = [SKAction waitForDuration: .75];
        SKAction *crearoja = [SKAction runBlock:^{[self bola];}];
        SKAction *spawnearbolas = [SKAction sequence:@[intervalo,crearoja]];
        [self runAction:[SKAction repeatActionForever:spawnearbolas]];

    }
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [touches anyObject];
    CGPoint touchLocation = [touch locationInNode:self];
    
    if (touchLocation.x < self.size.width / 2)
    {
        SKAction *izquierda = [SKAction rotateByAngle:.4 duration:.30];
        SKAction *enderezar1 = [SKAction rotateByAngle:-.4 duration:.30];
        SKAction *secuencia1 = [SKAction sequence:@[izquierda,enderezar1]];
        [self.spritegris runAction:secuencia1];
        
    }
    
    if (touchLocation.x > self.size.width / 2)
    {
        SKAction *derecha = [SKAction rotateByAngle:-.4 duration:.25];
        SKAction *enderezar2 = [SKAction rotateByAngle:.4 duration:.25];
        SKAction *secuencia2 = [SKAction sequence:@[derecha,enderezar2]];
        [self.spritegris runAction:secuencia2];
    }
}

-(void)update:(CFTimeInterval)currentTime {
    
    if (_gameOver) return;
    [self enumerateChildNodesWithName:@"bolarojo" usingBlock:^(SKNode *node, BOOL *stop) {
        if (node.position.x < CGRectGetMinX(self.frame))
        {
            [node removeFromParent];
            [self endGame];
        }
        else if (node.position.x > CGRectGetMaxX(self.frame))
        {
            [node removeFromParent];
            [GameState sharedInstance].score += 1;
            [self runAction:_playMySound];
        }
    }];
    
    
    [self enumerateChildNodesWithName:@"bolaazul" usingBlock:^(SKNode *node, BOOL *stop) {
        
        if (node.position.x > CGRectGetMaxX(self.frame))
        {
            [node removeFromParent];
            [self endGame];
        }
        
        else if (node.position.x < CGRectGetMinX(self.frame))
        {
            [node removeFromParent];
            [GameState sharedInstance].score+= 1;
            [self runAction:_playMySound];
        }
        
    }];
    
    [self._lblScore setText:[NSString stringWithFormat:@"%d", [GameState sharedInstance].score]];
}

@end
