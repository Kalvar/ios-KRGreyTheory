//
//  NSMutableArray+KRMatrix.h
//  GreyTheory
//
//  Created by Kalvar Lin on 2015/9/19.
//  Copyright (c) 2015年 Kalvar Lin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KRMathLib.h"

@interface NSMutableArray (KRSort)

-(NSArray *)sortByKey:(NSString *)_byKey ascending:(BOOL)_ascending;
-(void)sortMeByKey:(NSString *)_byKey ascending:(BOOL)_ascending;

@end

@interface NSMutableArray (KRMatrix)

-(NSMutableArray *)transposeMatrix;
-(NSMutableArray *)multiplyMatrix:(NSArray *)_matrix;
-(NSMutableArray *)multiplyVector:(NSArray *)_vector;
-(NSMutableArray *)solveEquationsWithMatrix:(NSArray *)_outputs;
-(NSMutableArray *)solveEquationsWithVector:(NSArray *)_outputs;
-(NSMutableArray *)solveEquationsByParameterMethodWithMatrix:(NSArray *)_outputs;

@end
