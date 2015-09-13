//
//  ViewController.m
//  GreyTheory
//
//  Created by Kalvar Lin on 2015/9/3.
//  Copyright (c) 2015年 Kalvar Lin. All rights reserved.
//

#import "ViewController.h"
#import "KRGreyGM1N.h"

@interface ViewController ()

@end

@implementation ViewController

#define eps 1e-10
#define maxn 110
double equ[maxn][maxn], ans[maxn];
int n;

bool Gauss()
{
    for( int i = 0; i < n; i ++ )
    {
        int pos = i;
        double res = fabs(equ[i][i]);
        for( int j = i + 1; j < n; j ++ )
        {
            if( fabs(equ[j][i]) > res )
            {
                pos = j, res = fabs(equ[j][i]);
            }
        }
        
        if( res < eps )
        {
            return false;
        }
        
        if( pos != i )
        {
            double _swapValue = 0.0f;
            for( int j = i; j<= n; j ++ )
            {
                //swap(equ[i][j], equ[pos][j]);
                _swapValue  = equ[i][j];
                equ[i][j]   = equ[pos][j];
                equ[pos][j] = _swapValue;
            }
        }
        
        for( int j = i + 1; j < n; j ++ )
        {
            res = equ[j][i] / equ[i][i];
            for( int k = i; k <= n; k ++ )
            {
                equ[j][k] -= res * equ[i][k];
            }
        }
    }
    
    for( int i = n - 1; i >= 0; i -- )
    {
        ans[i] = equ[i][n];
        for( int j = n - 1; j > i; j -- )
        {
            ans[i] -= equ[i][j] * ans[j];
        }
        ans[i] /= equ[i][i];
    }
    return true;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    KRGreyGM1N *gm1n = [KRGreyGM1N sharedTheory];
    [gm1n addPatterns:@[@2.0f, @11.0f, @1.5f, @2.0f, @2.2f, @3.0f] patternKey:@"x1"];
    [gm1n addPatterns:@[@3.0f, @13.5f, @1.0f, @3.0f, @3.0f, @4.0f] patternKey:@"x2"];
    [gm1n addPatterns:@[@2.0f, @11.0f, @3.5f, @2.0f, @3.0f, @2.0f] patternKey:@"x3"];
    [gm1n addPatterns:@[@4.0f, @12.0f, @2.0f, @1.0f, @2.0f, @1.0f] patternKey:@"x4"];
    [gm1n addPatterns:@[@1.0f, @10.0f, @5.0f, @2.0f, @1.0f, @1.0f] patternKey:@"x5"];
    [gm1n analyze];
    [gm1n print];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end

