//
//  KRMathLib.h
//
//  Created by Kalvar Lin on 2015/9/19.
//  Copyright (c) 2015年 Kalvar Lin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Accelerate/Accelerate.h>

@interface KRMathLib : NSObject

+(instancetype)sharedLib;
-(instancetype)init;

-(float)sqrt:(float)x;

@end

@interface KRMathLib (fixSort)

// If array included dictionaries that could use this method to against the key by sortting.
-(NSArray *)sortArray:(NSArray *)_array byKey:(NSString *)_byKey ascending:(BOOL)_ascending;
-(void)sortMutableArray:(NSMutableArray *)_mutableArray byKey:(NSString *)_byKey ascending:(BOOL)_ascending;

@end

@interface KRMathLib (fixMatrix)

-(NSMutableArray *)transposeMatrix:(NSArray *)_matrix;
-(NSMutableArray *)multiplyParentMatrix:(NSArray *)_parentMatrix childMatrix:(NSArray *)_childMatrix;
-(NSMutableArray *)multiplyParentMatrix:(NSArray *)_parentMatrix childVector:(NSArray *)_childVector;
-(NSMutableArray *)solveEquationsAtMatrix:(NSArray *)_matrix outputs:(NSArray *)_outputs;
-(NSMutableArray *)solveEquationsByParameterMethodAtMatrix:(NSArray *)_matrix outputs:(NSArray *)_outputs;
-(NSMutableArray *)gaussianEliminationAtMatrix:(NSMutableArray *)_matrix outputs:(NSArray *)_outputs;

@end