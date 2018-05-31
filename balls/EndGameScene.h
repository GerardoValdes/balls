//
//  EndGameScene.h
//  balls
//
//  Created by Gerardo Valdés on 31/08/14.
//  Copyright (c) 2014 Gerardo Valdés. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "ViewController.h"
@import GoogleMobileAds;


@interface EndGameScene : SKScene <GKGameCenterControllerDelegate>

@property (nonatomic)SKSpriteNode *twitter;
@property (nonatomic)SKSpriteNode *leaderboard;
@property(nonatomic, strong) GADInterstitial *interstitial;


@end
