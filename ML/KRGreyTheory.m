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
    dispatch_once(&pred, ^
    {
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


@end