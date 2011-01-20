//
//  PageViewController.h
//  NeverEnding
//
//  Created by Mikkel Malmberg on 20/01/11.
//  Copyright 2011 Detersmart.dk. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface PageViewController : UIViewController {
  NSUInteger index;
  UILabel *indexLabel;
}

@property (assign) NSUInteger index;
@property (nonatomic, retain) IBOutlet UILabel *indexLabel;

@end
