//
//  KRGreyGM1N.h
//  GreyTheory
//
//  Created by Kalvar Lin on 2015/9/3.
//  Copyright (c) 2015年 Kalvar Lin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KRGreyLib.h"

@interface KRGreyGM1N : NSObject

@property (nonatomic, strong) NSMutableArray *patterns;
@property (nonatomic, strong) NSMutableArray *keys;
@property (nonatomic, strong) NSMutableArray *analyzedResults;
@property (nonatomic, strong) NSMutableArray *influenceDegrees;
@property (nonatomic, strong) NSMutableDictionary *mappingResults; // This will map analyzedResults and pattern-keys

+(instancetype)sharedTheory;
-(instancetype)init;

-(void)addOutputs:(NSArray *)_someOutputs patternKey:(NSString *)_patternKey;
-(void)addPatterns:(NSArray *)_somePatterns patternKey:(NSString *)_patternKey;
-(void)analyze;
-(void)clean;
-(void)print;

@end

