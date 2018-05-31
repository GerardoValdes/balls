//
//  EndGameScene.m
//  balls
//
//  Created by Gerardo Valdés on 31/08/14.
//  Copyright (c) 2014 Gerardo Valdés. All rights reserved.
//

#import "EndGameScene.h"
#import "MyScene.h"
#import "Menu.h"
#import <Social/Social.h>
#import <GameKit/GameKit.h>
#import "ViewController.h"
#import "AppDelegate.h"

@import GoogleMobileAds;

@implementation EndGameScene

-(void)SetupAdmob  //call only first time
{
    self.interstitial = [[GADInterstitial alloc] initWithAdUnitID:@"YOUR-UNIT-ID"];
    [_interstitial loadRequest:[GADRequest request]];
    [self performSelector:@selector(showAdmobInterstitial) withObject:nil afterDelay:1.5];
}

-(void)showAdmobInterstitial  //call this to show fullScreen ads
{
    AppDelegate *app = ((AppDelegate *)[[UIApplication sharedApplication] delegate]);
    [self.interstitial presentFromRootViewController: app.viewController];
    self.interstitial = nil;
    
    self.interstitial = [[GADInterstitial alloc]
                         initWithAdUnitID:@"YOUR-UNIT-ID"];
    
    [_interstitial loadRequest:[GADRequest request]];
}

- (id) initWithSize:(CGSize)size
{

    if (self = [super initWithSize:size]) {
        
        [self SetupAdmob];
        [self showAdmobInterstitial];
        
        GKScore *scoreReporter = [[GKScore alloc] initWithLeaderboardIdentifier: @"ballsredandblue"];
        scoreReporter.value = [GameState sharedInstance].score;
        NSArray *scores = @[scoreReporter];
        [GKScore reportScores:scores withCompletionHandler:^(NSError *error) {
            if (error != nil) {
                NSLog(@"%@", [error localizedDescription]);
            }
            
        }];

        self.backgroundColor = [SKColor colorWithRed:0.23 green:0.27 blue:0.36 alpha:1.0];

        // Score
        SKLabelNode *lblScore = [SKLabelNode labelNodeWithFontNamed:@"Avenir"];
        lblScore.fontSize = CGRectGetWidth(self.frame)/2.6;
        lblScore.fontColor = [SKColor colorWithRed:0.847 green:0.847 blue:0.847 alpha:1];;
        lblScore.position = CGPointMake(CGRectGetMidX(self.frame),CGRectGetMaxY(self.frame)*.66);
        lblScore.alpha = .5;
        
        [lblScore setText:[NSString stringWithFormat:@"%d", [GameState sharedInstance].score]];
        [self addChild:lblScore];
        
        // High Score
        SKLabelNode *lblHighScore = [SKLabelNode labelNodeWithFontNamed:@"Avenir"];
        lblHighScore.fontSize = CGRectGetWidth(self.frame)*.08;
        lblHighScore.fontColor = [SKColor colorWithRed:1 green:1 blue:1 alpha:1];
        lblHighScore.position = CGPointMake(lblScore.position.x, CGRectGetMaxY(self.frame)*.59);
        lblHighScore.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeCenter;
        [lblHighScore setText:[NSString stringWithFormat:@"High Score: %d", [GameState sharedInstance].highScore]];
        [self addChild:lblHighScore];
        
        // Try again
        SKLabelNode *lblTryAgain = [SKLabelNode labelNodeWithFontNamed:@"Avenir"];
        lblTryAgain.fontSize = CGRectGetWidth(self.frame)*.08;
        lblTryAgain.fontColor = [SKColor colorWithRed:0.847 green:0.847 blue:0.847 alpha:1];
        lblTryAgain.position = CGPointMake(lblScore.position.x, CGRectGetMaxY(self.frame)*.50);
        lblTryAgain.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeCenter;
        [lblTryAgain setText:@"TAP"];
    
        SKTextureAtlas *atlasball = [SKTextureAtlas atlasNamed:@"ball"];
        
        SKTexture *twitter = [atlasball textureNamed:@"twitter.png"];
        self.twitter =[SKSpriteNode spriteNodeWithTexture:twitter];
        #define IPAD UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad
        if (IPAD) {self.twitter.size = CGSizeMake(95,80);}
        else {self.twitter.size = CGSizeMake(47,40);}
        self.twitter.position = CGPointMake(CGRectGetMidX(self.frame) + self.twitter.size.width/1.6,CGRectGetMidY(self.frame)/3);
        self.twitter.name = @"tweet";
        self.twitter.alpha = .5;
        [self addChild:self.twitter];
        
        SKTexture *leaderboard = [atlasball textureNamed:@"leaderboard.png"];
        self.leaderboard =[SKSpriteNode spriteNodeWithTexture:leaderboard];
        //#define IPAD UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad
        if (IPAD) {self.leaderboard.size = CGSizeMake(96,100);}
        else {self.leaderboard.size = CGSizeMake(48,50);}
        self.leaderboard.position = CGPointMake(CGRectGetMidX(self.frame) - self.leaderboard.size.width/1.6,CGRectGetMidY(self.frame)/3);
        self.leaderboard.name = @"leader";
        self.leaderboard.alpha = .5;
        [self addChild:self.leaderboard];
    }
    return self;
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    SKNode *node = [self nodeAtPoint:location];
    
    if ([node.name isEqualToString:@"tweet"]) {
        //  Create an instance of the Tweet Sheet
        node.name = @"botonoprimido";
        SKAction *shrink = [SKAction scaleTo:.60 duration:.1];
        SKAction *wait = [SKAction waitForDuration:.2];
        SKAction *grow = [SKAction scaleTo:1 duration:.1];
        SKAction *seq = [SKAction sequence:@[shrink,grow,wait]];
        [node runAction:seq];
        node.name = @"tweet";

        SLComposeViewController *tweetSheet = [SLComposeViewController
                                               composeViewControllerForServiceType:
                                               SLServiceTypeTwitter];
        // Sets the completion handler.  Note that we don't know which thread the
        // block will be called on, so we need to ensure that any required UI
        // updates occur on the main queue
        tweetSheet.completionHandler = ^(SLComposeViewControllerResult result) {
            switch(result) {
                    //  This means the user cancelled without sending the Tweet
                case SLComposeViewControllerResultCancelled:
                    break;
                    //  This means the user hit 'Send'
                case SLComposeViewControllerResultDone:
                    break;
            }
        };
        
        //  Set the initial body of the Tweet
        [tweetSheet setInitialText:[NSString stringWithFormat:@"I've just scored %d points in #Balls #Red #Blue https://appsto.re/mx/LtlE6.i", [GameState sharedInstance].score]];
        //  Adds an image to the Tweet.  Image named image.png
        if (![tweetSheet addImage: [self snapshot]]) {
            NSLog(@"Error: Unable to add image");
        }
        //  Add an URL to the Tweet.  You can add multiple URLs.

        UIViewController *controller = self.view.window.rootViewController;
        [controller presentViewController:tweetSheet animated: YES completion:nil]; 
    }
    
    else if ([node.name isEqualToString:@"leader"]) {
        
        node.name = @"botonoprimido";
        SKAction *shrink = [SKAction scaleTo:.60 duration:.1];
        SKAction *wait = [SKAction waitForDuration:.2];
        SKAction *grow = [SKAction scaleTo:1 duration:.1];
        SKAction *seq = [SKAction sequence:@[shrink,grow,wait]];
        [node runAction:seq];
        node.name = @"leader";
        ViewController *viewController = self.view.window.rootViewController;
        [viewController showLeaderBoard:YES];
    }
    
    else {
    // Transition back to the Game
    SKScene *myScene = [[Menu alloc] initWithSize:self.size];
    SKTransition *reveal = [SKTransition fadeWithDuration:0.5];
    [self.view presentScene:myScene transition:reveal];

    }
}

-(UIImage*)snapshot
{
    UIGraphicsBeginImageContextWithOptions(self.view.bounds.size, NO, [UIScreen mainScreen].scale);
    [self.view drawViewHierarchyInRect:self.view.bounds afterScreenUpdates:YES];
    UIImage *snapshotImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return snapshotImage;
}

@end
