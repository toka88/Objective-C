//
//  ImageViewController.m
//  Side Menu - Map
//
//  Created by Apple on 3/17/16.
//  Copyright © 2016 Tokovic Goran. All rights reserved.
//

#import "ImageViewController.h"
#import "SWRevealViewController.h"

@interface ImageViewController ()
@property(strong, nonatomic) UIScrollView* scrollView;

@property(strong, nonatomic) UIPageControl* pageControl;



@end

@implementation ImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self UIInit];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)UIInit{
    
    
    SWRevealViewController *revealController = [self revealViewController];
    
   // [revealController panGestureRecognizer];
    
    //Menu button
    
    UIImage* buttonImage = [[UIImage imageNamed:@"menu_icon (1).png"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    
    CGRect rect = CGRectMake(10, 0, 30, 25);
    
    UIButton* customButton = [[UIButton alloc] initWithFrame:rect];
    
    [customButton setImage:buttonImage forState:UIControlStateNormal];
    
    customButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    [customButton addTarget:revealController action:@selector(revealToggle:) forControlEvents:UIControlEventTouchUpInside];
    
    customButton.imageView.tintColor = [UIColor blackColor ];
    
    UIBarButtonItem *menuButtonItem = [[UIBarButtonItem alloc] initWithCustomView:customButton];
    self.navigationItem.leftBarButtonItem = menuButtonItem;
    
    
    
    CAGradientLayer* gradien = [CAGradientLayer layer];
    gradien.frame = self.view.bounds;
    
    gradien.colors = @[(id)[[UIColor colorWithRed:0.749 green:0.749 blue:0.749 alpha:1]CGColor],(id)[[UIColor colorWithRed:0.07854 green:0.07854 blue:0.07854 alpha:1]CGColor]];
    [self.view.layer addSublayer:gradien];
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(10, 100, self.view.frame.size.width - 20, 250)];
    
      self.scrollView.delegate = self;
    
    self.scrollView.pagingEnabled = YES;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.backgroundColor = [UIColor whiteColor];
    self.scrollView.layer.cornerRadius = 10;
    
    [self.view addSubview:self.scrollView];
    
    
    self.scrollView.backgroundColor = [UIColor colorWithWhite:1 alpha:0.4];
    
    [self addImageToScrollView:@[[UIImage imageNamed:@"pic1.jpg"],[UIImage imageNamed:@"pic2.jpg"],[UIImage imageNamed:@"pic3.jpg"],[UIImage imageNamed:@"pic4.jpg"]]];
    
    _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2 - 40, CGRectGetMaxY(self.scrollView.frame), 80, 15)];
    _pageControl.backgroundColor = [UIColor blackColor];
    _pageControl.pageIndicatorTintColor = [UIColor colorWithRed:0.33 green:0.33 blue:0.33 alpha:1];
    _pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
    _pageControl.numberOfPages = 4;
    _pageControl.layer.cornerRadius = 4;
    
    [_pageControl addTarget:self action:@selector(changePage) forControlEvents:UIControlEventValueChanged];
    
    
    [self.view addSubview:_pageControl];
    
    
    
    
}


-(void)addImageToScrollView: (NSArray*) images{
    
    
//    UIImageView* firstImage = [[UIImageView alloc] initWithFrame:CGRectMake(50, -45, self.scrollView.frame.size.width - 100, self.scrollView.frame.size.height-40)];
    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width * images.count, self.scrollView.contentSize.height);
    
    for (int i = 0; i< images.count; i++) {
        
        UIImageView* imageView = [[UIImageView alloc] initWithFrame:CGRectMake( i * self.scrollView.frame.size.width + 50, -45, self.scrollView.frame.size.width - 100, self.scrollView.frame.size.height - 40)];
        
        imageView.image = images[i];
        
        [self.scrollView addSubview:imageView];
    }
    
    
    
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGFloat pageWidth = self.scrollView.bounds.size.width;
    NSInteger pageNumber = floor((self.scrollView.contentOffset.x - pageWidth/2)/pageWidth)+1;
    self.pageControl.currentPage = pageNumber;
    
    
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
