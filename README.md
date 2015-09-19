ios-KRGreyTheory
=================

Machine Learning (マシンラーニング) in this project, it implemented the Grey Theory. This theory could use in big data analysis (データ分析), user behavior analysis (ユーザーの行動分析) and data mining (データマイニング) as well, especially find out what sub-factories impact on the real results via big data.

#### Podfile

```ruby
platform :ios, '8.0'
pod "KRGreyTheory", "~> 1.0.0"
```

## How to use

``` objective-c
#import "KRGreyTheory.h"

// Using GM1N model
KRGreyGM1N *gm1n = [[KRGreyTheory sharedTheory] useGM1N];
[gm1n addPatterns:@[@2.0f, @11.0f, @1.5f, @2.0f, @2.2f, @3.0f] patternKey:@"x1"];
[gm1n addPatterns:@[@3.0f, @13.5f, @1.0f, @3.0f, @3.0f, @4.0f] patternKey:@"x2"];
[gm1n addPatterns:@[@2.0f, @11.0f, @3.5f, @2.0f, @3.0f, @2.0f] patternKey:@"x3"];
[gm1n addPatterns:@[@4.0f, @12.0f, @2.0f, @1.0f, @2.0f, @1.0f] patternKey:@"x4"];
[gm1n addPatterns:@[@1.0f, @10.0f, @5.0f, @2.0f, @1.0f, @1.0f] patternKey:@"x5"];
[gm1n analyze];
[gm1n print];

```

## Version

V1.0.0

## License

MIT.
