//
//  ViewController.m
//  Practice
//
//  Created by 浅井 雅己 on 2012/12/23.
//  Copyright (c) 2012年 Masami Asai. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
  NSMutableArray *animSnowArray;
  UIImageView *santa;
}
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
  self.view.backgroundColor = [UIColor blackColor];
  UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 300, 30)];
  label.backgroundColor = [UIColor clearColor];
  label.text = @"メリークリスマス";
  label.textColor = [UIColor whiteColor];
  label.textAlignment = NSTextAlignmentCenter;
  label.font = [UIFont systemFontOfSize:18];
  
  UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 568, 320, 568)];
  imageView.image = [UIImage imageNamed:@"bg.png"];
  imageView.contentMode = UIViewContentModeScaleAspectFit;
  
  [self.view addSubview:imageView];
  [self.view addSubview:label];
  
  animSnowArray = [[NSMutableArray alloc] init];
  
  [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(snowAnim) userInfo:nil repeats:YES];
  [NSTimer scheduledTimerWithTimeInterval:0.4 target:self selector:@selector(snowAnim) userInfo:nil repeats:YES];
  [NSTimer scheduledTimerWithTimeInterval:0.3 target:self selector:@selector(snowAnim) userInfo:nil repeats:YES];
  [NSTimer scheduledTimerWithTimeInterval:0.2 target:self selector:@selector(snowAnim) userInfo:nil repeats:YES];
  [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(snowAnim) userInfo:nil repeats:YES];

  UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
  button.frame = CGRectMake(10, 10, 32, 32);
  [button setImage:[UIImage imageNamed:@"btn.png"] forState:UIControlStateNormal];
  
  [button addTarget:self action:@selector(showSanta) forControlEvents:UIControlEventTouchUpInside];
  
  [self.view addSubview:button];
  
  santa = [[UIImageView alloc] initWithFrame:CGRectMake(160, self.view.frame.size.height - 200, 160, 200)];
  santa.animationDuration = 3.0f;
  santa.animationImages = [[NSArray alloc] initWithObjects:[UIImage imageNamed:@"1.png"],
                                                           [UIImage imageNamed:@"2.png"],
                                                           nil];
  [self.view addSubview:santa];
    
  [self snowAnim];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)snowAnim
{
  int start_x = arc4random() % 320;
  int size = arc4random() % 30;
  
  UIImageView *snow = [[UIImageView alloc] initWithFrame:CGRectMake(start_x, -40, size, size)];
  snow.image = [UIImage imageNamed:@"snow.png"];
  [self.view addSubview:snow];
  
  CGContextRef context = UIGraphicsGetCurrentContext();
  [UIView beginAnimations:nil context:context];
  [UIView setAnimationDelegate:self];
  [UIView setAnimationDidStopSelector:@selector(stopAnim)];
  [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
  [UIView setAnimationDuration:10.0f];
  [animSnowArray addObject:snow];
  snow.frame = CGRectMake(start_x, self.view.frame.size.height, size, size);
  snow.transform = CGAffineTransformMakeRotation(M_PI);
  [UIView commitAnimations];
}

- (void)stopAnim
{
  UIImageView *animSnow = [animSnowArray objectAtIndex:0];
  [animSnowArray removeObjectAtIndex:0];
  [animSnow removeFromSuperview];
  animSnow = nil;
}

- (void) showSanta
{
  if (!santa.isAnimating) {
    [self.view bringSubviewToFront:santa];
    [santa startAnimating];
  } else {
    [santa stopAnimating];
    [self.view sendSubviewToBack:santa];
  }
}

@end
