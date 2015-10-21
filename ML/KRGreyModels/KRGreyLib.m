//
//  KRGreyLib.m
//  GreyTheory
//
//  Created by Kalvar Lin on 2015/9/3.
//  Copyright (c) 2015年 Kalvar Lin. All rights reserved.
//

#import "KRGreyLib.h"
#import "NSMutableArray+KRMatrix.h"

@implementation KRGreyLib

+(instancetype)sharedLib
{
    static dispatch_once_t pred;
    static KRGreyLib *_object = nil;
    dispatch_once(&pred, ^{
        _object = [[KRGreyLib alloc] init];
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

// Creates AGO via patterns
-(NSArray *)ago:(NSArray *)_patterns
{
    NSMutableArray *_agoBoxes = [NSMutableArray new];
    NSMutableArray *_zBoxes   = [NSMutableArray new];
    int _patternIndex         = 0;
    // x1 is the output, x2 ~ xn are the inputs.
    for( NSArray *_xPatterns in _patterns )
    {
        NSMutableArray *_xAgo = [NSMutableArray new];
        float _sum            = 0.0f;
        float _zValue         = 0.0f;
        int _xIndex           = 0;
        for( NSNumber *_x in _xPatterns )
        {
            _sum += [_x floatValue];
            [_xAgo addObject:[NSNumber numberWithFloat:_sum]];
            // Only first pattern need to calculate the Z value.
            if( _patternIndex == 0 && _xIndex > 0 )
            {
                _zValue = ( 0.5f * _sum ) + ( 0.5f * [[_xAgo objectAtIndex:(_xIndex - 1)] floatValue] );
                [_zBoxes addObject:[NSNumber numberWithFloat:_zValue]];
            }
            ++_xIndex;
        }
        [_agoBoxes addObject:_xAgo];
        ++_patternIndex;
    }
    return @[_agoBoxes, _zBoxes];
}

@end