//
//  albumPlayerAppDelegate.h
//  albumPlayer
//
//  Created by noboru on 3/1/11.
//  Copyright 2011 Nine Drafts Inc.. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface albumPlayerAppDelegate : NSObject <UIApplicationDelegate, UITabBarControllerDelegate> {
    UIWindow *window;
    UITabBarController *tabBarController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UITabBarController *tabBarController;

@end
