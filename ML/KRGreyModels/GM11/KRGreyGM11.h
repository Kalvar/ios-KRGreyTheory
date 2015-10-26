//
//  KRGreyGM11.h
//  GreyTheory
//
//  Created by Kalvar Lin on 2015/9/3.
//  Copyright (c) 2015年 Kalvar Lin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KRGreyLib.h"

@interface KRGreyGM11 : NSObject

@property (nonatomic, strong) NSMutableArray *patterns;
@property (nonatomic, strong) NSMutableArray *keys;
@property (nonatomic, strong) NSMutableDictionary *forecastResults;

+(instancetype)sharedTheory;
-(instancetype)init;

-(void)addPattern:(NSNumber *)_somePattern patternKey:(NSString *)_patternKey;
-(void)forecast;
-(void)clean;
-(void)print;

@end

