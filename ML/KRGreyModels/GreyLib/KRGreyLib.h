//
//  KRGreyLib.h
//  GreyTheory
//
//  Created by Kalvar Lin on 2015/9/3.
//  Copyright (c) 2015年 Kalvar Lin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KRGrey+Definition.h"

@interface KRGreyLib : NSObject

+(instancetype)sharedLib;
-(instancetype)init;
-(NSArray *)ago:(NSArray *)_patterns;

@end

