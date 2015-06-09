//
//  CarouselViewController.h
//  Sid-InApp
//
//  Created by  on 09/06/15.
//  Copyright (c) 2015 Ehb.be. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CarouselViewController : UIViewController <UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

-(void)toNextPage:(UIScrollView *)scrollview;

@end
