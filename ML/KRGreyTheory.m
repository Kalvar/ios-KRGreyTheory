//
//  KRGreyTheory.m
//  GreyTheory
//
//  Created by Kalvar Lin on 2015/9/3.
//  Copyright (c) 2015年 Kalvar Lin. All rights reserved.
//

#import "KRGreyTheory.h"

@implementation KRGreyTheory

+(instancetype)sharedTheory
{
    static dispatch_once_t pred;
    static KRGreyTheory *_object = nil;
    dispatch_once(&pred, ^{
        _object = [[KRGreyTheory alloc] init];
    });
    return _object;
}

-(instancetype)init
{
    self = [super init];
    if( self )
    {
        
    }
    return self;
}

#pragma --mark GM1N
-(KRGreyGM1N *)useGM1N
{
    return [KRGreyGM1N sharedTheory];
}

#pragma --mark GM0n
-(KRGreyGM0N *)useGM0N
{
    return [KRGreyGM0N sharedTheory];
}

#pragma --mark GM11
-(KRGreyGM11 *)useGM11
{
    return [KRGreyGM11 sharedTheory];
}

@end