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

@property NSArray *imagesData;
@property NSMutableArray *images;

@end

@implementation CarouselViewController

@synthesize scrollView;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self fetchImagesFromContext];
    [self setupScrollView];
    scrollView.delegate = self;
    [self toNextPage:scrollView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) setupScrollView {
    [self.scrollView setAlwaysBounceHorizontal:NO];
    [self.scrollView setPagingEnabled:YES];
    
    NSInteger numberOfViews = (NSInteger) _images.count;
    
    for(int i = 0; i < numberOfViews; i++){
        CGFloat xOrigin = i * self.view.frame.size.width;
        UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(xOrigin, 0, self.view.frame.size.width, self.view.frame.size.height)];
        image.image = _images[i];
        image.contentMode = UIViewContentModeScaleAspectFit;
        [self.scrollView addSubview:image];
    }
    
    self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width * numberOfViews, self.view.frame.size.height);
    [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(toNextPage:) userInfo:nil repeats:YES];
}

-(void)toNextPage:(UIScrollView *)scrollview {
    
    //int currentPage = self.scrollView.contentOffset.x / self.scrollView.frame.size.width;
    int nextPage = (self.scrollView.contentOffset.x / self.scrollView.frame.size.width) +1;
    
    if(nextPage!=_images.count){
        [self.scrollView scrollRectToVisible:CGRectMake(self.scrollView.frame.size.width * nextPage, 0, self.scrollView.frame.size.width, self.scrollView.frame.size.height) animated:YES];
    } else {
        [self.scrollView scrollRectToVisible:CGRectMake(0, 0, self.scrollView.frame.size.width, self.scrollView.frame.size.height) animated:NO];
    }
}

-(void)fetchImagesFromContext{
    
    NSManagedObjectContext *context = [RKManagedObjectStore defaultStore].mainQueueManagedObjectContext;
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Image"];
    
    NSError *error;
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    
    _imagesData = fetchedObjects;
    
    _images = [[NSMutableArray alloc]init];
    
    for(int i = 0; i < _imagesData.count; i++){
        
        //image uit array halen
        Image *image = _imagesData[i];
        
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
