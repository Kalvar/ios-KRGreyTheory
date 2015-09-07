//
//  KRGreyGM1N.m
//  GreyTheory
//
//  Created by Kalvar Lin on 2015/9/3.
//  Copyright (c) 2015年 Kalvar Lin. All rights reserved.
//

#import "KRGreyGM1N.h"

@implementation KRGreyGM1N (fixMaths)

-(float)invSqrt:(float)x
{
    float xhalf = 0.5f*x;
    int i = *(int*)&x; // get bits for floating VALUE
    i = 0x5f375a86- (i>>1); // gives initial guess y0
    x = *(float*)&i; // convert bits BACK to float
    x = x*(1.5f-xhalf*x*x); // Newton step, repeating increases accuracy
    return x;
}

// Solves that simultaneous equations
-(void)solveEquationsAtMatrixA:(NSArray *)_matrixA vectorB:(NSArray *)_vectorB
{
    @autoreleasepool
    {
        long int rows = [_matrixA count];
        long int cols = [[_matrixA firstObject] count];
        double buffer[ rows * cols ]; // x 直欄(rows) y 橫列(clos)
        int i         = 0;
        for( NSArray *_xRows in _matrixA )
        {
            for( NSNumber *_number in _xRows )
            {
                buffer[i] = [_number doubleValue];
                ++i;
            }
        }
        
        // array, x 欄(行) y 列
        la_object_t matrix = la_matrix_from_double_buffer(buffer, rows, cols, cols, LA_NO_HINT, LA_DEFAULT_ATTRIBUTES);
        
        NSLog(@"rows %li", la_matrix_rows(matrix));
        NSLog(@"cols %li", la_matrix_cols(matrix));
        
        long int bRows     = [_vectorB count];
        
        NSLog(@"cols : %li", bRows);
        
        long int bCols     = 1;
        double buffer2[ bRows * bCols ];
        la_object_t vector = la_matrix_from_double_buffer(buffer2, bRows, bCols, bCols, LA_NO_HINT, LA_DEFAULT_ATTRIBUTES);
        
        NSLog(@"vector %@", vector.description);
        
        //解出來的聯立解
        la_object_t solvedMatrix = la_solve(matrix, vector);
        
        NSLog(@"solvedMatrix %@", solvedMatrix.description);
        
        double solvedBuffer[ bRows * bCols ];
        
        //從Matrix物件 轉回 double[]
        la_status_t status = la_matrix_to_double_buffer(solvedBuffer, 1, solvedMatrix);
        
        NSLog(@"status : %li", status);
        
        if (status == LA_SUCCESS) {
            NSLog(@"success: a:%f, b2:%f, b3:%f, b4:%f, b5:%f", solvedBuffer[0], solvedBuffer[1], solvedBuffer[2], solvedBuffer[3], solvedBuffer[4]);
        }else{
            NSLog(@"Wrong");
        }
        
        
    }
}

@end

@implementation KRGreyGM1N

+(instancetype)sharedTheory
{
    static dispatch_once_t pred;
    static KRGreyGM1N *_object = nil;
    dispatch_once(&pred, ^
    {
        _object = [[KRGreyGM1N alloc] init];
    });
    return _object;
}

-(instancetype)init
{
    self = [super init];
    if( self )
    {
        _patterns = [NSMutableArray new];
        _keys     = [NSMutableArray new];
        _results  = [NSMutableDictionary new];
    }
    return self;
}

#pragma --mark Public Methods
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
                _zValue = -( ( 0.5f * _sum ) + ( 0.5f * [[_xPatterns objectAtIndex:(_xIndex - 1)] floatValue] ) );
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
        // T, 轉置矩陣
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
        
        
        /*
        // Test ...
        NSMutableArray *_vectorB = [NSMutableArray new];
        int i = -1;
        for( NSNumber *_n in [_patterns firstObject] )
        {
            ++i;
            if( i <= 0 ) continue;
            [_vectorB addObject:_n];
        }
        
        [self solveEquationsAtMatrixA:_allFactors vectorB:_vectorB];
        
        return;
        */
        
#error Waiting for implementing simultaneous equations of matrix.
        
        NSMutableArray *_rates = [NSMutableArray new];
        NSArray *_x1           = [_patterns firstObject];
        
        for( NSArray *_factors in _allFactors )
        {
            int _xIndex = _startIndex;
            float _sum  = 0.0f;
            for( NSNumber *_xValue in _factors )
            {
                NSNumber *_outputValue =[_x1 objectAtIndex:_xIndex];
                _sum += ( [_xValue floatValue] * [_outputValue floatValue] );
                
                NSLog(@"%f x %f", [_xValue floatValue], [_outputValue floatValue]);
                ++_xIndex;
            }
            [_rates addObject:[NSNumber numberWithFloat:_sum]];
            
            NSLog(@"%f\n\n", _sum);
        }
        
        
    }
    
}


-(void)print
{
    
}

#pragma --mark Getters


@end