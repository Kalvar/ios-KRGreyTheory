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

-(void)gm1n
{
    KRGreyGM1N *gm1n = [[KRGreyTheory sharedTheory] useGM1N];
    [gm1n addOutputs:@[@2.0f, @11.0f, @1.5f, @2.0f, @2.2f, @3.0f] patternKey:@"x1"];
    [gm1n addPatterns:@[@3.0f, @13.5f, @1.0f, @3.0f, @3.0f, @4.0f] patternKey:@"x2"];
    [gm1n addPatterns:@[@2.0f, @11.0f, @3.5f, @2.0f, @3.0f, @2.0f] patternKey:@"x3"];
    [gm1n addPatterns:@[@4.0f, @12.0f, @2.0f, @1.0f, @2.0f, @1.0f] patternKey:@"x4"];
    [gm1n addPatterns:@[@1.0f, @10.0f, @5.0f, @2.0f, @1.0f, @1.0f] patternKey:@"x5"];
    [gm1n analyze];
    [gm1n print];
}

-(void)gm0n
{
    KRGreyGM0N *gm0n = [[KRGreyTheory sharedTheory] useGM0N];
    [gm0n addOutputs:@[@1.0f, @1.0f, @1.0f, @1.0f, @1.0f, @1.0f] patternKey:@"x1"];
    [gm0n addPatterns:@[@0.75f, @1.22f, @0.2f, @1.0f, @1.0f, @1.0f] patternKey:@"x2"];
    [gm0n addPatterns:@[@0.5f, @1.0f, @0.7f, @0.66f, @1.0f, @0.5f] patternKey:@"x3"];
    [gm0n addPatterns:@[@1.0f, @1.09f, @0.4f, @0.33f, @0.66f, @0.25f] patternKey:@"x4"];
    [gm0n addPatterns:@[@0.25f, @0.99f, @1.0f, @0.66f, @0.33f, @0.25f] patternKey:@"x5"];
    [gm0n analyze];
    [gm0n print];
}

-(void)gm11
{
    KRGreyGM11 *gm11 = [[KRGreyTheory sharedTheory] useGM11];
    [gm11 addPattern:@533.0f patternKey:@"x1"];
    [gm11 addPattern:@665.0f patternKey:@"x2"];
    [gm11 addPattern:@655.0f patternKey:@"x3"];
    [gm11 addPattern:@740.0f patternKey:@"x4"];
    [gm11 forecast]; // To forecast x5 that number
    [gm11 print];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Using GM1N model
    [self gm1n];
    
    // Using GM0N model
    [self gm0n];
    
    // Using GM11 model
    // 實際上能用 Grey Theory 來分析 Patterns 對 Neural Network 的初始權重設定範圍和設定初始權重值 / 偏權值
    [self gm11];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
