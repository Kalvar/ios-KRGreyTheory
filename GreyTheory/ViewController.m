//
//  ViewController.m
//  GreyTheory
//
//  Created by Kalvar Lin on 2015/9/3.
//  Copyright (c) 2015年 Kalvar Lin. All rights reserved.
//

#import "ViewController.h"
#import "KRGreyTheory.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Using GM1N model
    KRGreyGM1N *gm1n = [[KRGreyTheory sharedTheory] useGM1N];
    [gm1n addPatterns:@[@2.0f, @11.0f, @1.5f, @2.0f, @2.2f, @3.0f] patternKey:@"x1"];
    [gm1n addPatterns:@[@3.0f, @13.5f, @1.0f, @3.0f, @3.0f, @4.0f] patternKey:@"x2"];
    [gm1n addPatterns:@[@2.0f, @11.0f, @3.5f, @2.0f, @3.0f, @2.0f] patternKey:@"x3"];
    [gm1n addPatterns:@[@4.0f, @12.0f, @2.0f, @1.0f, @2.0f, @1.0f] patternKey:@"x4"];
    [gm1n addPatterns:@[@1.0f, @10.0f, @5.0f, @2.0f, @1.0f, @1.0f] patternKey:@"x5"];
    [gm1n analyze];
    [gm1n print];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
