//
//  AppDelegate.h
//  balls
//
//  Created by Gerardo Valdés on 21/08/14.
//  Copyright (c) 2014 Gerardo Valdés. All rights reserved.
//

#import <UIKit/UIKit.h>
@import GoogleMobileAds;

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    UIViewController *viewController;
}

@property (strong, nonatomic) UIViewController *viewController;
@property (strong, nonatomic) UIWindow *window;
@property(nonatomic, strong) GADInterstitial *interstitial;


@end
