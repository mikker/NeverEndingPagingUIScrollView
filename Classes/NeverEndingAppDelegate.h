//
//  NeverEndingAppDelegate.h
//  NeverEnding
//
//  Created by Mikkel Malmberg on 20/01/11.
//  Copyright 2011 Detersmart.dk. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NeverEndingViewController;

@interface NeverEndingAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    NeverEndingViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet NeverEndingViewController *viewController;

@end

