//
//  CarouselViewController.m
//  Sid-InApp
//
//  Created by  on 09/06/15.
//  Copyright (c) 2015 Ehb.be. All rights reserved.
//

#import "CarouselViewController.h"
#import "Image.h"
#import <RestKit/CoreData.h>
#import <RestKit/RestKit.h>
#import "GTMBAse64.h"

@interface CarouselViewController ()

@property NSMutableArray *images;

@end

@implementation CarouselViewController

@synthesize scrollView;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self fetchImagesFromContext];
    [self decodeImages]; //
    [self setupScrollView];
    scrollView.delegate = self;
    [self toNextPage:scrollView];
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapReceived:)];
    [tapGestureRecognizer setDelegate:self];
    [self.view addGestureRecognizer:tapGestureRecognizer];
    
}

-(void)tapReceived:(UITapGestureRecognizer *)tapGestureRecognizer{
    
    [self dismissViewControllerAnimated:YES completion:nil];    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void) setupScrollView {
    [self.scrollView setAlwaysBounceHorizontal:NO];
    [self.scrollView setPagingEnabled:YES];
    
    NSInteger numberOfViews = (NSInteger) self.images.count;
    
    for(int i = 0; i < numberOfViews; i++){
        CGFloat xOrigin = i * self.view.frame.size.width;
        UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(xOrigin, 0, self.view.frame.size.width, self.view.frame.size.height)];
        image.image = self.images[i];
        image.contentMode = UIViewContentModeScaleAspectFit;
        [self.scrollView addSubview:image];
    }
    
    self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width * numberOfViews, self.view.frame.size.height);
    [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(toNextPage:) userInfo:nil repeats:YES];
}

-(void)toNextPage:(UIScrollView *)scrollview {
    
    int nextPage = (self.scrollView.contentOffset.x / self.scrollView.frame.size.width) +1;
    
    if(nextPage!=self.images.count){
        [self.scrollView scrollRectToVisible:CGRectMake(self.scrollView.frame.size.width * nextPage, 0, self.scrollView.frame.size.width, self.scrollView.frame.size.height) animated:YES];
    } else {
        [self.scrollView scrollRectToVisible:CGRectMake(0, 0, self.scrollView.frame.size.width, self.scrollView.frame.size.height) animated:NO];
    }
}

-(void)fetchImagesFromContext{
    
    self.rawImages = [self.synchronizationService.persistentStoreManager
               fetchAll:[Image entityName]
               sort:
               [NSSortDescriptor sortDescriptorWithKey:@"priority"
                                             ascending:YES]];
}

-(void)decodeImages{ //
    
    self.images = [[NSMutableArray alloc]init];
    
    for(int i = 0; i < self.rawImages.count; i++){
        
        //image uit array halen
        ImageEntity *image = self.rawImages[i];
        
        //image string ophalen
        NSString *imgString = image.image;
        
        //string omzetten naar data
        NSData *imageData = [GTMBase64 decodeString: imgString];
        
        //image maken met data
        UIImage *sImage = [UIImage imageWithData:imageData];
        
        //image aan array toevoegen
        [self.images addObject:sImage];
    }
}

@end
