//________________________________________________________________________________//
//
// DA Side Menu - Map
// Copyright (c) 2016 DA
// All Rights Reserved Worldwide
// DIGITAL ATRIUM
//
// StreamViewController.m
//
// Author IDENTITY:
//		Goran Tokovic		3/31/16	
//

//________________________________________________________________________________//
//________________________________________________________________________________//
//********************************************************************************//
#import "StreamViewController.h"
#import <AVFoundation/AVFoundation.h>



//________________________________________________________________________________//
//________________________________________________________________________________//
@interface StreamViewController ()

@property(strong, nonatomic) AVAudioPlayer * audioPlayer;
@property(strong, nonatomic) UILabel* volumeLabel;



@property(strong, nonatomic) UIButton* playButton;
@property(strong, nonatomic) UIButton* stopButton;
@property(strong, nonatomic) UIButton* pauseButton;


@property(strong, nonatomic) UISlider * volumeSlider;


@end

//________________________________________________________________________________//
//________________________________________________________________________________//
#pragma mark -
@implementation StreamViewController


-(void)viewDidLoad{
    
    [super viewDidLoad];
    
    [self UIInit];
    
    [self.view setBackgroundColor:[UIColor colorWithWhite:0.9 alpha:0.9]];
    
    
    NSString * soundFile = [[NSBundle mainBundle] pathForResource:@"pesma" ofType:@"mp3"];
    
    NSURL * url = [[NSURL alloc] initFileURLWithPath:soundFile];
    
    
    self.audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    self.audioPlayer.numberOfLoops = 0;
    self.audioPlayer.volume = self.volumeSlider.value;
    [self.audioPlayer prepareToPlay];
    
    
}


-(void)UIInit{
    
    self.volumeLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2 - 40, 80, 80, 20)];
    [self.volumeLabel setTextAlignment:NSTextAlignmentCenter];
    [self.volumeLabel setText:@"Volume"];
    [self.view addSubview:self.volumeLabel];
    
    self.volumeSlider = [[UISlider alloc] initWithFrame:CGRectMake(30, CGRectGetMaxY(self.volumeLabel.frame)+10, self.view.frame.size.width - 60, 20)];
    [self.volumeSlider addTarget:self action:@selector(sliderValueChanged) forControlEvents:UIControlEventValueChanged];
    [self.volumeSlider setValue:0.5f];
    
    [self.view addSubview:self.volumeSlider];
    
    
    //Play
    self.playButton = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width * 0.106666, CGRectGetMaxY(self.volumeSlider.frame) + 40, self.view.frame.size.width * 0.34, 30)];
    [self.playButton addTarget:self action:@selector(playPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.playButton setTitle:@"Play" forState:UIControlStateNormal];
    [self.playButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.playButton setBackgroundColor:[UIColor whiteColor]];
    [self.playButton setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [self.view addSubview:self.playButton];
    
    //Pause
    self.pauseButton = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.playButton.frame)+self.view.frame.size.width*0.10666, CGRectGetMaxY(self.volumeSlider.frame)+40, self.view.frame.size.width*0.34, 30)];
    [self.pauseButton addTarget:self action:@selector(pausePressed) forControlEvents:UIControlEventTouchUpInside];
    [self.pauseButton setTitle:@"Pause" forState:UIControlStateNormal];
    [self.pauseButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.pauseButton setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [self.pauseButton setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:self.pauseButton];
    
    
    
    //Stop
    self.stopButton = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width*0.106666, CGRectGetMaxY(self.pauseButton.frame)+30, self.view.frame.size.width -  2 * self.view.frame.size.width * 0.106666, 30)];
    [self.stopButton addTarget:self action:@selector(stopPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.stopButton setTitle:@"Stop" forState:UIControlStateNormal];
    [self.stopButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.stopButton setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [self.stopButton setBackgroundColor:[UIColor whiteColor]];
    
    [self.view addSubview:self.stopButton];
    
}

#pragma mark - Actions

-(void)pausePressed{
    
    [self.audioPlayer pause];
    
    
}


-(void)playPressed{
    
    
    
    [self.audioPlayer play];
    
}


-(void)stopPressed{
    
    [self.audioPlayer stop];
    
}





-(void)sliderValueChanged{
    
    
    self.audioPlayer.volume = self.volumeSlider.value;
    
}





@end
