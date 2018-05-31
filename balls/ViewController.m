//
//  ViewController.m
//  balls
//
//  Created by Gerardo Valdés on 21/08/14.
//  Copyright (c) 2014 Gerardo Valdés. All rights reserved.
//


#import "ViewController.h"
#import "MyScene.h"
#import "Menu.h"
#import <iAd/iAD.h>
#import <GameKit/GameKit.h>
#import <UIKit/UIKit.h>
#import "EndGameScene.h"
#import "AppDelegate.h"


@interface ViewController ()
@end

@implementation ViewController
BOOL isGameCenterAvailable = true;
static ViewController *_sharedHelper = nil;

- (void)viewWillLayoutSubviews
{
    AppDelegate *app = ((AppDelegate *)[[UIApplication sharedApplication] delegate]);
    app.viewController = self;
}

- (void)viewDidLoad
{
    
    //----------------- AUTENTICATE LOCAL PLAYER GAME CENTER -----------------------------------------

    GKLocalPlayer *localPlayer = [GKLocalPlayer localPlayer];
    localPlayer.authenticateHandler = ^(UIViewController *viewController, NSError *error){
        if (viewController != nil) {
            [self presentViewController:viewController animated:YES completion:nil];
        }
        else{
            if ([GKLocalPlayer localPlayer].authenticated) {
                // Get the default leaderboard identifier.
                [[GKLocalPlayer localPlayer] loadDefaultLeaderboardIdentifierWithCompletionHandler:^(NSString *leaderboardIdentifier, NSError *error) {
                    if (error != nil) {NSLog(@"%@", [error localizedDescription]);}
                    else{}
                            }];}
                    else{}
            }
        };
    
    //----------------------------------------------------------------------------------------------
    
    [super viewDidLoad];
    
    // Configure the view.
    SKView * skView = (SKView *)self.view;
    skView.showsFPS = NO;
    skView.showsNodeCount = NO;
    // Create and configure the scene.
    SKScene * scene = [Menu sceneWithSize:skView.bounds.size];
    scene.scaleMode = SKSceneScaleModeAspectFill;
    // Present the scene.
    [skView presentScene:scene];
}


- (BOOL)shouldAutorotate
{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    } else {
        return UIInterfaceOrientationMaskAll;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}


- (void)awakeFromNib{
    
    [super awakeFromNib];
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    
    adView = [[ADBannerView alloc] initWithFrame:CGRectZero];
    adView.frame = CGRectMake(0, screenRect.size.height - adView.frame.size.height, screenRect.size.width, adView.frame.size.height);
    adView.delegate=self;
    [self.view addSubview:adView];
}

//iAd
-(void)bannerViewDidLoadAd:(ADBannerView *)banner {
    
   [adView setAlpha:1.0];
    NSLog(@"Show Ad");
    
}

-(void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error {
    
   [adView setAlpha:0];
    NSLog(@"Hide Ad");
    
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

///---------------------------GAME CENTER-------------------------------------------------------------
/// show fron button

+(ViewController*)defaultHelper {
    static dispatch_once_t pred = 0;
    dispatch_once(&pred, ^{
        _sharedHelper = [[ViewController alloc] init];
    });
    return _sharedHelper;
}


-(void)showLeaderBoard:(BOOL)shouldShowLeaderboard
{
    GKGameCenterViewController *gameCenterController = [[GKGameCenterViewController alloc] init];
    if (gameCenterController != NULL)
    {
        gameCenterController.leaderboardIdentifier = @"ballsredandblue";
        gameCenterController.viewState = GKGameCenterViewControllerStateLeaderboards;
        gameCenterController.gameCenterDelegate = self;
        [self presentViewController: gameCenterController animated: YES completion:nil];
    }
}

- (void)gameCenterViewControllerDidFinish:(GKGameCenterViewController *)gameCenterController
{
    [gameCenterController dismissViewControllerAnimated:YES completion:nil];
}

///--------------------------------------------------------------------------------------------------
@end
