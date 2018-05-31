//
//  ViewController.h
//  balls
//

//  Copyright (c) 2014 Gerardo Valdés. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SpriteKit/SpriteKit.h>
#import <iAd/iAD.h>
#import <GameKit/GameKit.h>

@interface ViewController : UIViewController <ADBannerViewDelegate, GKGameCenterControllerDelegate> {
    //iAd
    ADBannerView *adView;
}

//- (void)open;
- (void)showLeaderBoard:(BOOL)shouldShowLeaderboard;
+ (ViewController*)defaultHelper;

@end
