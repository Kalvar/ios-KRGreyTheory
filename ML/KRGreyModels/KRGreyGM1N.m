//
//  KRGreyGM1N.m
//  GreyTheory
//
//  Created by Kalvar Lin on 2015/9/3.
//  Copyright (c) 2015年 Kalvar Lin. All rights reserved.
//

#import "KRGreyGM1N.h"
#import "NSMutableArray+KRMatrix.h"

@implementation KRGreyGM1N (fixFactories)

-(NSString *)_makeEquationNameByNumber:(NSInteger)_number
{
    return [NSString stringWithFormat:@"%@%li", _kKRGreyGm1nEquationFactoryPrefixName, _number];
}

@end

@implementation KRGreyGM1N

+(instancetype)sharedTheory
{
    static dispatch_once_t pred;
    static KRGreyGM1N *_object = nil;
    dispatch_once(&pred, ^{
        _object = [[KRGreyGM1N alloc] init];
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
                _zValue = -( ( 0.5f * _sum ) + ( 0.5f * [[_xAgo objectAtIndex:(_xIndex - 1)] floatValue] ) );
                [_zBoxes addObject:[NSNumber numberWithFloat:_zValue]];
            }
            ++_xIndex;
        }
        [_agoBoxes addObject:_xAgo];
        ++_patternIndex;
    }
    
    NSInteger _zCount = [_zBoxes count];
    if( _zCount > 1 )
    {
        // Deeply dimension
        NSInteger _xDimension       = [_agoBoxes count];
        int _startIndex             = 1;
        // 轉置矩陣
        NSMutableArray *_allFactors = [NSMutableArray new];
        for( int _i = 0; _i < _zCount; ++_i )
        {
            NSMutableArray *_xT = [NSMutableArray new];
            [_xT addObject:[_zBoxes objectAtIndex:_i]];
            // Start from x(1) to (n)
            for( int _k = _startIndex; _k < _xDimension; ++_k )
            {
                // Hence, that _i needs to +1 to start in (1) to (n)
                [_xT addObject:[[_agoBoxes objectAtIndex:_k] objectAtIndex:_i+1]];
            }
            [_allFactors addObject:_xT];
        }
        
        // Refactoring that x1 to be an output vector by following the Grey Theory GM(1, N) formula
        NSMutableArray *_vectors = [NSMutableArray new];
        int i = -1;
        for( NSNumber *_n in [_patterns firstObject] )
        {
            ++i;
            if( i <= 0 ) continue;
            [_vectors addObject:_n];
        }
        
        NSMutableArray *_solvedEquations = [_allFactors solveEquationsWithVector:_vectors];
        //NSLog(@"_solvedEquations : %@", _solvedEquations);
        
        // Formate to sub NSDictionary that Key / Value modes into results array
        // Desc sorting the abs() equation values first, they named b(2) to b(n), but ignore the result (a) factory in this loop
        NSMutableArray *_sorts     = [NSMutableArray new];
        NSMutableArray *_sandboxes = [NSMutableArray new]; // Puts result (a) into here
        NSInteger _count           = [_solvedEquations count];
        for( NSInteger _i=0; _i<_count; _i++ )
        {
            CGFloat _equationValue            = fabsf([[_solvedEquations objectAtIndex:_i] floatValue]);
            NSMutableDictionary *_factoryInfo = [NSMutableDictionary new];
            NSString *_equationName           = ( _i > 0 ) ? [self _makeEquationNameByNumber:(_i + 1)] : kKRGreyGm1nEquatioinResultName;
            [_factoryInfo setObject:_equationName forKey:kKRGreyGm1nEquationName];
            [_factoryInfo setObject:[NSNumber numberWithFloat:_equationValue] forKey:kKRGreyGm1nEquationAbsValue];
            [_factoryInfo setObject:[NSNumber numberWithInteger:_i] forKey:kKRGreyGm1nEquationPatternIndex];
            [_factoryInfo setObject:@0 forKey:kKRGreyGm1nEquationRanking];
            if( _i > 0 )
            {
                [_sorts addObject:_factoryInfo];
            }
            else
            {
                [_sandboxes addObject:_factoryInfo];
            }
        }
        
        // Sortting by _sorts and without _sandboxes
        [_analyzedResults addObjectsFromArray:[_sorts sortByKey:kKRGreyGm1nEquationAbsValue ascending:NO]];
        
        // Retrieving "a"
        [_analyzedResults insertObject:[_sandboxes firstObject] atIndex:0];
        
        // Reset the ranking for all factories
        NSInteger _ranking = 0;
        for( NSMutableDictionary *_factoryInfo in _analyzedResults )
        {
            // Ranking number means the influence degree
            [_factoryInfo setValue:[NSNumber numberWithInteger:_ranking] forKey:kKRGreyGm1nEquationRanking];
            // Reset to pattern key-name that already customized by user
            NSInteger _patternIndex         = [[_factoryInfo objectForKey:kKRGreyGm1nEquationPatternIndex] integerValue];
            NSString *_originalEquationName = [_keys objectAtIndex:_patternIndex];
            [_factoryInfo setValue:_originalEquationName forKey:kKRGreyGm1nEquationName];
            
            // To setup mappingResults dictionary to quickly search
            [_mappingResults setObject:[_factoryInfo copy] forKey:_originalEquationName];
            
            // To setup influenceDegrees
            if( _ranking > 0 )
            {
                [_influenceDegrees addObject:_originalEquationName];
            }
            
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