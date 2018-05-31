//
//  GameKitHelper.h
//  balls
//
//  Created by Gerardo Valdés on 3/30/15.
//  Copyright (c) 2015 Gerardo Valdés. All rights reserved.
//

#import <Foundation/Foundation.h>
@import GameKit;
extern NSString *const PresentAuthenticationViewController;
@interface GameKitHelper : NSObject

@property (nonatomic, readonly) UIViewController *authenticationViewController;
@property (nonatomic, readonly) NSError *lastError;

+ (instancetype)sharedGameKitHelper;
- (void)authenticateLocalPlayer;

@end
