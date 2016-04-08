//________________________________________________________________________________//
//
// DA Side Menu - Map
// Copyright (c) 2016 DA
// All Rights Reserved Worldwide
// DIGITAL ATRIUM
//
// WeatherViewController.m
//
// Author IDENTITY:
//		Goran Tokovic		4/4/16
//

//________________________________________________________________________________//
//________________________________________________________________________________//
//********************************************************************************//
#import "Weather.h"
#import "WeatherUserService.h"
#import "WeatherViewController.h"
#import "ScrollGraphUIView.h"
#import "WeatherTableViewCell.h"

#define SHOW_BORDER_MACRO

#define TOP_CONTAINER_HEIGHT 150
#define CONTAINER_WIDTH 335
#define TEMPERATURE_LABEL_HEIGHT 90
#define TEMPERATURE_LABEL_WEIGHT 335

//________________________________________________________________________________//
//________________________________________________________________________________//
@interface WeatherViewController ()

@property (strong, nonatomic) UIScrollView* scrollView;
@property (strong, nonatomic) UIView* containerView;
@property (strong, nonatomic) UIView* bottomContainerView;

//Top container items
@property (strong, nonatomic) NSString* url;
@property (strong, nonatomic) Weather* weather;
@property (strong, nonatomic) UILabel* temperatureLabel;
@property (strong, nonatomic) UILabel* countryLabel;
@property (strong, nonatomic) UILabel* cityLabel;
@property (strong, nonatomic) UILabel* iconDescriptionLabel;
@property (strong, nonatomic) UIImageView* iconImageView;

//Bottom container items
@property(strong, nonatomic) ScrollGraphUIView* temperatureGraph;
@property(strong, nonatomic) UITableView* tableView;

@end

//________________________________________________________________________________//
//________________________________________________________________________________//
#pragma mark -
@implementation WeatherViewController

- (void)viewDidLoad
{

    [super viewDidLoad];

    [self UIInit];

    self.url = [NSString stringWithFormat:@"http://api.openweathermap.org/data/2.5/forecast/daily?lat=%f&lon=%f&cnt=10&mode=json&appid=5397c1af17fbb5af41946989d2e01642", self.latitude, self.longitude];

    [self loadWeatherDataFromUrl];
}

- (void)UIInit
{

    double width = self.view.frame.size.width;
    double height = self.view.frame.size.height;

    //background gradient
    CAGradientLayer* gradient = [CAGradientLayer layer];
    gradient.frame = self.view.bounds;
    gradient.colors = @[ (id)[[UIColor colorWithRed:0 green:0.698 blue:0.7765 alpha:1] CGColor], (id)[[UIColor colorWithRed:0.6039 green:0.8 blue:0.7765 alpha:1] CGColor] ];

    [self.view.layer addSublayer:gradient];

    self.countryLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 70, CONTAINER_WIDTH, 30)];
    [self.countryLabel setTextAlignment:NSTextAlignmentCenter];
    [self.countryLabel setTextColor:[UIColor whiteColor]];
    [self.countryLabel setFont:[UIFont fontWithName:@"ChalkboardSE-Bold" size:24]];

#ifdef SHOW_BORDER_MACRO
    self.countryLabel.layer.borderWidth = 1.0;
    self.countryLabel.layer.borderColor = [UIColor blackColor].CGColor;
#endif

    [self.view addSubview:self.countryLabel];

    self.cityLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(self.countryLabel.frame), CONTAINER_WIDTH, 30)];
    [self.cityLabel setTextAlignment:NSTextAlignmentCenter];
    [self.cityLabel setTextColor:[UIColor whiteColor]];
    [self.cityLabel setFont:[UIFont fontWithName:@"ChalkboardSE-Regular" size:24]];

#ifdef SHOW_BORDER_MACRO
    self.cityLabel.layer.borderWidth = 1.0;
    self.cityLabel.layer.borderColor = [UIColor blackColor].CGColor;
#endif
    [self.view addSubview:self.cityLabel];

    NSLog(@"\n\nHeight: %f", height);
    NSLog(@"\n\nMAx Y: %f", CGRectGetMaxY(self.cityLabel.frame));

    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(self.cityLabel.frame) + 20, CONTAINER_WIDTH, 500)];

    NSLog(@"\n***************************\n Frame Y: %f", self.view.frame.size.height - CGRectGetMaxY(self.cityLabel.frame) - 40);

    self.scrollView.delegate = self;
    self.scrollView.contentSize = CGSizeMake(self.scrollView.bounds.size.width, 1000);
    self.scrollView.showsVerticalScrollIndicator = NO;

    [self.view addSubview:self.scrollView];

    /****************************************************************/
    /*--------------- Top container initialization ------------*/

    self.containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width - width * 0.05333 * 2, 150)];
  //  [self.containerView setBackgroundColor:[UIColor colorWithWhite:0.6 alpha:0.3]];
#ifdef SHOW_BORDER_MACRO
    self.containerView.layer.borderColor = [UIColor brownColor].CGColor;
    self.containerView.layer.borderWidth = 1;
#endif
    self.containerView.layer.cornerRadius = 5;
    [self.scrollView addSubview:self.containerView];

    NSLog(@"Container HEIGHT: %f", width * 0.05333 * 3 + height * 0.134932);

    //Icon

    self.iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake((width - width * (1 - 0.05333)) * 4, 0, 60, 60)];

#ifdef SHOW_BORDER_MACRO
    self.iconImageView.layer.borderColor = [UIColor blackColor].CGColor;
    self.iconImageView.layer.borderWidth = 1.0;
#endif

    [self.containerView addSubview:self.iconImageView];

    //Icon description
    self.iconDescriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.iconImageView.frame), width * 0.05333 / 2, self.scrollView.frame.size.width - CGRectGetMaxX(self.iconImageView.frame), width * 0.05333 * 2)];
    [self.iconDescriptionLabel setTextColor:[UIColor whiteColor]];
    [self.iconDescriptionLabel setTextAlignment:NSTextAlignmentLeft];
    [self.iconDescriptionLabel setFont:[UIFont fontWithName:@"ChalkboardSE-Light" size:20]];

#ifdef SHOW_BORDER_MACRO
    self.iconDescriptionLabel.layer.borderColor = [UIColor blackColor].CGColor;
    self.iconDescriptionLabel.layer.borderWidth = 1.0;
#endif

    [self.containerView addSubview:self.iconDescriptionLabel];

    //Temperature

    self.temperatureLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.iconImageView.frame) - 10, self.containerView.bounds.size.width, height * 0.134932)];
    [self.temperatureLabel setTextColor:[UIColor whiteColor]];
    [self.temperatureLabel setFont:[UIFont boldSystemFontOfSize:86]];
    [self.temperatureLabel setTextAlignment:NSTextAlignmentCenter];

#ifdef SHOW_BORDER_MACRO
    self.temperatureLabel.layer.borderColor = [UIColor blackColor].CGColor;
    self.temperatureLabel.layer.borderWidth = 1.0;
#endif

    [self.scrollView addSubview:self.temperatureLabel];

    /******************************************************************/
    /*-------------- Bottom container view initialization ------------*/

    self.bottomContainerView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.containerView.frame), self.scrollView.frame.size.width, self.scrollView.contentSize.height - self.containerView.frame.size.height)];
 //   [self.bottomContainerView setBackgroundColor:[UIColor colorWithWhite:0.5 alpha:0.3]];
    self.bottomContainerView.layer.cornerRadius = 5;

//    UILabel* bottomLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 100, 30, 30)];
//    [bottomLabel setBackgroundColor:[UIColor purpleColor]];
//    [self.bottomContainerView addSubview:bottomLabel];

#ifdef SHOW_BORDER_MACRO
    self.bottomContainerView.layer.borderColor = [UIColor blackColor].CGColor;
    self.bottomContainerView.layer.borderWidth = 1.0;
#endif

    [self.scrollView addSubview:self.bottomContainerView];

    
    
    self.temperatureGraph = [[ScrollGraphUIView alloc] initWithFrame:CGRectMake(0, 10, self.bottomContainerView.frame.size.width, 150)];
    
    [self.temperatureGraph setTitleLabel:@"15 days weather" color:[UIColor whiteColor] font:[UIFont fontWithName:@"ChalkboardSE-Bold" size:12]];
    
#ifdef SHOW_BORDER_MACRO
    [self.temperatureGraph.layer setBorderColor:[UIColor blackColor].CGColor];
    [self.temperatureGraph.layer setBorderWidth:1.0];
#endif
    
    [self.bottomContainerView addSubview:self.temperatureGraph];
    
    
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.temperatureGraph.frame), self.scrollView.frame.size.width, 400)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.bottomContainerView addSubview:self.tableView];
#ifdef SHOW_BORDER_MACRO
    [self.tableView.layer setBorderColor:[UIColor blackColor].CGColor];
    [self.tableView.layer setBorderWidth:1.0];    
#endif
    
    
    
}

- (void)loadWeatherDataFromUrl
{

    [[WeatherUserService sharedInstance] getWeatherData:self.url CompletionBlock:^(Weather* weatherObject) {
        self.weather = weatherObject;

        self.temperatureLabel.text = [NSString stringWithFormat:@"%2.1f°C", [self.weather getCurrentTemperatureInCelsius]];

        self.countryLabel.text = [self.weather getCountryName];
        self.cityLabel.text = [self.weather getCityName];
        
        NSMutableArray* temperatures = [NSMutableArray arrayWithArray:[self.weather getTemperatures]];
        [self.temperatureGraph setGraphPoints:temperatures];
        [self.temperatureGraph drawScrollGraph:YES duration:0.8];
        
        NSLog(@"NumOfDays: %d", [self.weather getNumOfDays]);
        
        

        dispatch_async(dispatch_get_global_queue(0, 0), ^{

            NSLog(@"URL: %@", [self.weather getIconURLs]);
            NSData* data = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:[self.weather getCirrentIconURL]]];
            if (data == nil)
                return;
            dispatch_async(dispatch_get_main_queue(), ^{

                UIImage* iconImage = [UIImage imageWithData:data];

                [self.iconImageView setImage:iconImage];

                [self.iconImageView setContentMode:UIViewContentModeScaleAspectFill];
                NSLog(@"Weather: %@", [self.weather getCurrentWeatherDescription]);
            });
        });

        [self.iconDescriptionLabel setText:[self.weather getCurrentWeatherDescription]];

    }];
}

- (UIImage*)resizeImage:(UIImage*)image scaledToSize:(CGSize)newSize
{
    //UIGraphicsBeginImageContext(newSize);
    // In next line, pass 0.0 to use the current device's pixel scaling factor (and thus account for Retina resolution).
    // Pass 1.0 to force exact pixel size.
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

#pragma mark - ScrollView Delegate

- (void)scrollViewDidScroll:(UIScrollView*)scrollView
{

    CGFloat offset = scrollView.contentOffset.y;
    CGFloat percentage = offset / TOP_CONTAINER_HEIGHT;
    CGFloat value = TOP_CONTAINER_HEIGHT * percentage;

    if (TOP_CONTAINER_HEIGHT - value > 60) {
        self.containerView.frame = CGRectMake(0, value, self.scrollView.bounds.size.width, TOP_CONTAINER_HEIGHT - value);
    }

    //self.containerView.frame = CGRectMake(0, value, self.scrollView.bounds.size.width, TOP_CONTAINER_HEIGHT - value);

    //Temperature label parallax
//    CGFloat percentageOfTemperature = offset / TEMPERATURE_LABEL_HEIGHT;
//
//    CGFloat valueTemp = TEMPERATURE_LABEL_HEIGHT * percentageOfTemperature;
//
//    CGFloat widthPercentage = offset / TEMPERATURE_LABEL_WEIGHT;
//    CGFloat widthValue = TEMPERATURE_LABEL_WEIGHT * widthPercentage;

    CGFloat alphaValue = 1 - percentage;
    self.temperatureLabel.alpha = alphaValue * alphaValue * alphaValue;
//
//    CGFloat fontSizePercentage = offset / 86;
//    CGFloat fSize = 86 * fontSizePercentage;
//
//    if (fSize > 0) {
//         self.temperatureLabel.font = [UIFont boldSystemFontOfSize:90 - fSize];
//    }

    self.temperatureLabel.transform = CGAffineTransformMakeScale(1 - (percentage / 2.9), 1 - (percentage / 2.9));

    //    self.temperatureLabel.frame = CGRectMake(widthValue,CGRectGetMaxY(self.iconImageView.frame)+ valueTemp, TEMPERATURE_LABEL_WEIGHT - widthValue, TEMPERATURE_LABEL_HEIGHT - valueTemp);

    //    CGFloat newHeight =
    //
    //
    //
    //    self.iconImageView.alpha = alphaValue*alphaValue*alphaValue;
    //    self.iconDescriptionLabel.alpha = alphaValue*alphaValue*alphaValue;
}


#pragma mark - TableView delegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [self.weather getNumOfDays];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //TODO
    WeatherTableViewCell* cell = [self.tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell setCellData:<#(NSString *)#> iconURL:<#(NSString *)#> temperature:<#(NSString *)#>
    
}

@end
