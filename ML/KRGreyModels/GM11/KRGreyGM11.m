//
//  KRGreyGM11.m
//  GreyTheory
//
//  Created by Kalvar Lin on 2015/9/3.
//  Copyright (c) 2015年 Kalvar Lin. All rights reserved.
//

#import "KRGreyGM11.h"
#import "NSMutableArray+KRMatrix.h"

@implementation KRGreyGM11

+(instancetype)sharedTheory
{
    static dispatch_once_t pred;
    static KRGreyGM11 *_object = nil;
    dispatch_once(&pred, ^{
        _object = [[KRGreyGM11 alloc] init];
    });
    return _object;
}

-(instancetype)init
{
    self = [super init];
    if( self )
    {
        _patterns         = [NSMutableArray new];
        _keys             = [NSMutableArray new];
        _forecastResults  = [NSMutableDictionary new];
    }
    return self;
}

#pragma --mark Public Methods
-(void)addPattern:(NSNumber *)_somePattern patternKey:(NSString *)_patternKey
{
    [_patterns addObject:[_somePattern copy]];
    [_keys addObject:[_patternKey copy]];
}

-(void)forecast
{
    NSArray *_ago      = [[KRGreyLib sharedLib] ago:@[_patterns]];
    NSArray *_zBoxes   = [[_ago lastObject] copy]; // GM11 的 Z 是負生成，得於後續處理加入負號
    _ago               = nil;
    NSInteger _zCount  = [_zBoxes count];
    if( _zCount > 1 )
    {
        // Building B matrix ( 含 Z 生成參數的 AGO 轉置矩陣 )
        NSMutableArray *_allFactors = [NSMutableArray new];
        for( int _i = 0; _i < _zCount; ++_i )
        {
            NSMutableArray *_xT  = [NSMutableArray new];
            NSNumber *_negativeZ = [NSNumber numberWithFloat:-( [[_zBoxes objectAtIndex:_i] floatValue] )];
            [_xT addObject:_negativeZ];
            [_xT addObject:[NSNumber numberWithFloat:1.0f]];
            [_allFactors addObject:_xT];
        }
        
        // Building Y matrix ( 原生含 Patterns[1] 以後的轉置矩陣 )
        NSMutableArray *_vectors = [NSMutableArray new];
        int i = -1;
        for( NSNumber *_n in _patterns )
        {
            ++i;
            if( i <= 0 ) continue;
            [_vectors addObject:_n];
        }
        
        NSMutableArray *_solvedEquations = [_allFactors solveEquationsWithVector:_vectors];
        //NSMutableArray *_solvedEquations = [_allFactors solveEquationsByParameterMethodWithMatrix:_vectors];
        //NSLog(@"_solvedEquations : %@", _solvedEquations);
        
        // 代入預測公式, 用現在的值去推測下一個值
        __block float _sumError    = 0.0f;
        float _x1                  = [[_patterns firstObject] floatValue];
        float _alpha               = [[_solvedEquations firstObject] floatValue];
        float _bValue              = [[_solvedEquations lastObject] floatValue];
        __block NSInteger _total   = [_patterns count];
        __block NSInteger _k       = 1;
        [_patterns enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop)
        {
            float _forecastValue = ( 1 - powf(M_E, _alpha) ) * ( _x1 + ( _bValue / fabs(_alpha) ) ) * powf(M_E, fabs(_alpha) * _k);
            // 同時算每筆預測誤差 (最後一筆不可計算)
            NSMutableDictionary *_factoryInfo = [NSMutableDictionary new];
            if( _k < _total )
            {
                float _originalValue = [[_patterns objectAtIndex:_k] floatValue];
                float _errorRate     = fabsf( (_originalValue - _forecastValue) / _originalValue );
                _sumError           += _errorRate;
                [_factoryInfo setObject:[NSNumber numberWithInteger:_k] forKey:kKRGreyGm11K];
                [_factoryInfo setObject:[NSNumber numberWithFloat:_originalValue] forKey:kKRGreyGm11OriginalValue];
                [_factoryInfo setObject:[NSNumber numberWithFloat:_forecastValue] forKey:kKRGreyGm11ForecastValue];
                [_factoryInfo setObject:[NSNumber numberWithFloat:_errorRate] forKey:kKRGreyGm11ErrorRate];
                
                [_forecastResults setObject:_factoryInfo forKey:[_keys objectAtIndex:_k]];
            }
            else
            {
                // 計算平均殘差
                float _averageError = _sumError / (_total - 1);
                [_factoryInfo setObject:[NSNumber numberWithInteger:_k] forKey:kKRGreyGm11K];
                [_factoryInfo setObject:[NSNumber numberWithFloat:_forecastValue] forKey:kKRGreyGm11ForecastValue];
                [_factoryInfo setObject:[NSNumber numberWithFloat:_averageError] forKey:kKRGreyGm11AverageErrorRate];
                
                [_forecastResults setObject:_factoryInfo forKey:kKRGreyGm11ForecastResult];
            }
            ++_k;
        }];
    }
}

-(void)clean
{
    [_patterns removeAllObjects];
    [_keys removeAllObjects];
    [_forecastResults removeAllObjects];
}

-(void)print
{
    NSLog(@"forecastResults : %@", [_forecastResults description]);
}


@end
