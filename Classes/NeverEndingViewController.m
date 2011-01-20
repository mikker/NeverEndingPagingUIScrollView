//
//  NeverEndingViewController.m
//  NeverEnding
//
//  Created by Mikkel Malmberg on 20/01/11.
//  Copyright 2011 Detersmart.dk. All rights reserved.
//

#import "NeverEndingViewController.h"
#import "PageViewController.h"

@interface NeverEndingViewController (Private)
- (void)tilePages;
@end


@implementation NeverEndingViewController

- (void)dealloc {
  [pagingView release];
  [super dealloc];
}

#pragma mark -

- (void)viewDidLoad {
  [super viewDidLoad];
  
  pagingView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
  pagingView.pagingEnabled = YES;
  pagingView.showsHorizontalScrollIndicator = NO;
  pagingView.delegate = self;
  [self.view addSubview:pagingView];
  
  visiblePages = [[NSMutableSet alloc] init];
  recycledPages = [[NSMutableSet alloc] init];
  
  [self tilePages];  
}

#pragma mark -
#pragma mark UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
  if (!isAnimating) isAnimating = YES;
  [self tilePages];
}

// When animation stops using setContentOffset
- (void) scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
  isAnimating = NO;
}

// When animation stops using dragging
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
  isAnimating = NO;
  NSLog(@"visiblePages: %@", visiblePages);
  NSLog(@"recycledPages: %@", recycledPages);
}

#pragma mark -

-(BOOL)isDisplayingPageForIndex:(NSUInteger)index
{
  BOOL foundPage = NO;
  for (PageViewController *vc in visiblePages) {
    if (vc.index == index) {
      foundPage = YES;
      break;
    }
  }
  return foundPage;
}

- (PageViewController *)dequeueRecycledPage
{
  PageViewController *viewController = [recycledPages anyObject];
  if (viewController) {
    [[viewController retain] autorelease];
    [recycledPages removeObject:viewController];
  }
  return viewController;
}

- (CGRect)frameForPageAtIndex:(NSInteger)index {
  CGSize pageSize = pagingView.bounds.size;
  return CGRectMake(index*pageSize.width, 0,
                    pageSize.width, pageSize.height);
}

- (void) addPageWithIndex: (int) index  {
  PageViewController *viewController = [self dequeueRecycledPage];
  if (viewController == nil)
    viewController = [[PageViewController alloc] init];
  viewController.view.frame = [self frameForPageAtIndex:index];
  viewController.index = index;
  [pagingView addSubview:viewController.view];
  [visiblePages addObject:viewController];
}

- (int)currentPageIndex {
  return (int)((pagingView.contentOffset.x /
                pagingView.bounds.size.width));
}

- (void)resizePagingViewContentSize {
  pagingView.contentSize = CGSizeMake(pagingView.bounds.size.width*([self currentPageIndex]+2),
                                      pagingView.bounds.size.height);
}

- (void)tilePages {
  int historyCount = 3;
  CGRect visibleBounds = pagingView.bounds;
  int firstNeededPageIndex = floorf(CGRectGetMinX(visibleBounds) / CGRectGetWidth(visibleBounds));
  int lastNeededPageIndex  = floorf((CGRectGetMaxX(visibleBounds)-1) / CGRectGetWidth(visibleBounds));
  firstNeededPageIndex = MAX(firstNeededPageIndex-historyCount, 0);
  lastNeededPageIndex  = MAX(lastNeededPageIndex+historyCount, 1);
  
  // Recycle unneeded controllers
  for (PageViewController *vc in visiblePages) {
    if (vc.index < firstNeededPageIndex || vc.index > lastNeededPageIndex) {
      [recycledPages addObject:vc];
      [vc.view removeFromSuperview];
    }
  }
  [visiblePages minusSet:recycledPages];
  
  // Add missing pages
  for (int i = firstNeededPageIndex; i <= lastNeededPageIndex; i++) {
    if (![self isDisplayingPageForIndex:i])
      [self addPageWithIndex: i];
  }
  
  [self resizePagingViewContentSize];  
}

@end
