//
//  KRGreyTheory.h
//  GreyTheory
//
//  Created by Kalvar Lin on 2015/9/3.
//  Copyright (c) 2015年 Kalvar Lin. All rights reserved.
//

#import "KRGreyGM1N.h"

@interface KRGreyTheory : NSObject

+(instancetype)sharedTheory;
-(instancetype)init;

-(KRGreyGM1N *)useGM1N;

@end