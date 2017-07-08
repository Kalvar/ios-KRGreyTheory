//
//  KRGreyGM0N.m
//  GreyTheory
//
//  Created by Kalvar Lin on 2015/9/3.
//  Copyright (c) 2015年 Kalvar Lin. All rights reserved.
//

#import "KRGreyGM0N.h"
#import "NSMutableArray+KRMatrix.h"

@implementation KRGreyGM0N (fixFactories)

-(NSString *)_makeEquationNameByNumber:(NSInteger)_number
{
    return [NSString stringWithFormat:@"%@%li", _kKRGreyGmEquationFactoryPrefixName, _number];
}

@end

@implementation KRGreyGM0N

+(instancetype)sharedTheory
{
    static dispatch_once_t pred;
    static KRGreyGM0N *_object = nil;
    dispatch_once(&pred, ^{
        _object = [[KRGreyGM0N alloc] init];
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
        _analyzedResults  = [[NSMutableArray alloc] initWithCapacity:0];
        _influenceDegrees = [NSMutableArray new];
        _mappingResults   = [NSMutableDictionary new];
    }
    return self;
}

#pragma --mark Public Methods
// The outputs are the results of all patterns
-(void)addOutputs:(NSArray *)_someOutputs patternKey:(NSString *)_patternKey
{
    [_patterns insertObject:[_someOutputs copy] atIndex:0];
    [_keys addObject:[_patternKey copy]];
}

-(void)addPatterns:(NSArray *)_somePatterns patternKey:(NSString *)_patternKey
{
    [_patterns addObject:[_somePatterns copy]];
    [_keys addObject:[_patternKey copy]];
}

-(void)analyze
{
    NSArray *_ago      = [[KRGreyLib sharedLib] ago:_patterns];
    NSArray *_agoBoxes = [[_ago firstObject] copy];
    NSArray *_zBoxes   = [[_ago lastObject] copy];
    _ago               = nil;
    NSInteger _zCount  = [_zBoxes count];
    if( _zCount > 1 )
    {
        // 依公式取出要用的 x2[1] 以後的 AGO matrixes，並且轉置矩陣
        NSInteger _xDimension       = [_agoBoxes count];
        int _startIndex             = 1;
        NSMutableArray *_allFactors = [NSMutableArray new];
        for( int _i = 0; _i < _zCount; ++_i )
        {
            NSMutableArray *_xT = [NSMutableArray new];
            // Start from x(2)[1] to x(n)[m]
            for( int _k = _startIndex; _k < _xDimension; ++_k )
            {
                // Hence, that _i needs to +1 to start in (1) to (n)
                [_xT addObject:[[_agoBoxes objectAtIndex:_k] objectAtIndex:_i+1]];
            }
            [_allFactors addObject:_xT];
        }
        
        NSMutableArray *_solvedEquations = [_allFactors solveEquationsWithVector:_zBoxes];
        //NSLog(@"_solvedEquations : %@", _solvedEquations);
        
        // Desc sorting the abs() equation values
        NSMutableArray *_sorts = [NSMutableArray new];
        NSInteger _count       = [_solvedEquations count];
        for( NSInteger _i=0; _i<_count; _i++ )
        {
            CGFloat _equationValue            = fabsf([[_solvedEquations objectAtIndex:_i] floatValue]);
            NSMutableDictionary *_factoryInfo = [NSMutableDictionary new];
            NSString *_equationName           = [self _makeEquationNameByNumber:(_i + 2)];
            [_factoryInfo setObject:_equationName forKey:kKRGreyGmEquationName];
            [_factoryInfo setObject:[NSNumber numberWithFloat:_equationValue] forKey:kKRGreyGmEquationAbsValue];
            [_factoryInfo setObject:[NSNumber numberWithInteger:(_i + 1)] forKey:kKRGreyGmEquationPatternIndex];
            [_factoryInfo setObject:@0 forKey:kKRGreyGmEquationRanking];
            [_sorts addObject:_factoryInfo];
        }
        
        // Asc sortting by _sorts
        [_analyzedResults addObjectsFromArray:[_sorts sortByKey:kKRGreyGmEquationAbsValue ascending:NO]];
        
        // Reset the ranking for all factories
        NSInteger _ranking = 0;
        for( NSMutableDictionary *_factoryInfo in _analyzedResults )
        {
            // Ranking number means the influence degree
            [_factoryInfo setValue:[NSNumber numberWithInteger:_ranking] forKey:kKRGreyGmEquationRanking];
            // Reset to pattern key-name that already customized by user
            NSInteger _patternIndex         = [[_factoryInfo objectForKey:kKRGreyGmEquationPatternIndex] integerValue];
            NSString *_originalEquationName = [_keys objectAtIndex:_patternIndex];
            [_factoryInfo setValue:_originalEquationName forKey:kKRGreyGmEquationName];
            
            // To setup mappingResults dictionary to quickly search
            [_mappingResults setObject:[_factoryInfo copy] forKey:_originalEquationName];
            
            // To setup influenceDegrees (排列影響因子的程度)
            [_influenceDegrees addObject:_originalEquationName];
            
            ++_ranking;
        }
        
    }
    
}

-(void)clean
{
    [_patterns removeAllObjects];
    [_keys removeAllObjects];
    [_analyzedResults removeAllObjects];
    [_influenceDegrees removeAllObjects];
    [_mappingResults removeAllObjects];
}

-(void)print
{
    NSLog(@"influenceDegrees : %@", [_influenceDegrees componentsJoinedByString:@" > "]);
    NSLog(@"analyzedResults : %@", [_analyzedResults description]);
    NSLog(@"mappingResults : %@", [_mappingResults description]);
}


@end
