//
//  PageViewController.m
//  NeverEnding
//
//  Created by Mikkel Malmberg on 20/01/11.
//  Copyright 2011 Detersmart.dk. All rights reserved.
//

#import "PageViewController.h"

@implementation PageViewController

@synthesize index;
@synthesize indexLabel;

- (id)initWithNib {
  if ((self != [super initWithNibName:@"PageViewController" bundle:nil]))
    return nil;
  return self;
}

- (void)dealloc {
  [super dealloc];
}

- (void)viewDidLoad {
  NSArray *colors = [NSArray arrayWithObjects:
                     [UIColor greenColor],
                     [UIColor grayColor],
                     [UIColor blueColor],
                     [UIColor cyanColor], nil];
  self.view.backgroundColor = [colors objectAtIndex:(arc4random() % [colors count])];
}

- (void)setIndex:(NSUInteger)i {
  index = i;
  indexLabel.text = [NSString stringWithFormat:@"%i", i];
}

@end
