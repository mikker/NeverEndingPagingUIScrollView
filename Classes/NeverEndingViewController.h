//
//  NeverEndingViewController.h
//  NeverEnding
//
//  Created by Mikkel Malmberg on 20/01/11.
//  Copyright 2011 Detersmart.dk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NeverEndingViewController : UIViewController
<UIScrollViewDelegate> {
  UIScrollView *pagingView;
  
  NSMutableSet *visiblePages;
  NSMutableSet *recycledPages;
  
  BOOL isAnimating;
}

@end

