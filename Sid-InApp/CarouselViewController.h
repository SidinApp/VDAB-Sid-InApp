//
//  CarouselViewController.h
//  Sid-InApp
//
//  Created by  on 09/06/15.
//  Copyright (c) 2015 Ehb.be. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SynchronizationService.h"

@interface CarouselViewController : UIViewController <UIScrollViewDelegate, UIGestureRecognizerDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (nonatomic, strong) NSArray *rawImages;

@property (nonatomic, strong) SynchronizationService *synchronizationService;

-(void)toNextPage:(UIScrollView *)scrollview;

@end
