//
//  NSMutableArray+KRMatrix.m
//  GreyTheory
//
//  Created by Kalvar Lin on 2015/9/19.
//  Copyright (c) 2015年 Kalvar Lin. All rights reserved.
//

#import "NSMutableArray+KRMatrix.h"

@implementation NSMutableArray (KRSort)

-(NSArray *)sortByKey:(NSString *)_byKey ascending:(BOOL)_ascending
{
    return [[KRMathLib sharedLib] sortArray:self byKey:_byKey ascending:_ascending];
}

-(void)sortMeByKey:(NSString *)_byKey ascending:(BOOL)_ascending
{
    [[KRMathLib sharedLib] sortMutableArray:self byKey:_byKey ascending:_ascending];
    //[self sortUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:_byKey ascending:_ascending]]];
}

@end

@implementation NSMutableArray (KRMatrix)

-(NSMutableArray *)transposeMatrix
{
    return [[KRMathLib sharedLib] transposeMatrix:self];
}

-(NSMutableArray *)multiplyMatrix:(NSArray *)_matrix
{
    return [[KRMathLib sharedLib] multiplyParentMatrix:self childMatrix:_matrix];
}

-(NSMutableArray *)multiplyVector:(NSArray *)_vector
{
    return [[KRMathLib sharedLib] multiplyParentMatrix:self childVector:_vector];
}

-(double)sumMatrix:(NSArray *)_matrix
{
    return [[KRMathLib sharedLib] sumMatrix:self anotherMatrix:_matrix];
}

-(NSArray *)multiplyByNumber:(double)_number
{
    return [[KRMathLib sharedLib] multiplyMatrix:self byNumber:_number];
}

-(NSArray *)plusMatrix:(NSArray *)_matrix
{
    return [[KRMathLib sharedLib] plusMatrix:self anotherMatrix:_matrix];
}

-(NSMutableArray *)solveEquationsWithMatrix:(NSArray *)_outputs
{
    return [[KRMathLib sharedLib] solveEquationsAtMatrix:self outputs:_outputs];
}

-(NSMutableArray *)solveEquationsWithVector:(NSArray *)_outputs
{
    return [[KRMathLib sharedLib] solveEquationsAtMatrix:self outputs:@[_outputs]];
}

-(NSMutableArray *)solveEquationsByParameterMethodWithMatrix:(NSArray *)_outputs
{
    return [[KRMathLib sharedLib] solveEquationsByParameterMethodAtMatrix:self outputs:_outputs];
}

@end
