ios-KRGreyTheory
=================

Machine Learning (マシンラーニング) in this project, it implemented the Grey Theory. This theory could use in big data analysis (データ分析), user behavior analysis (ユーザーの行動分析) and data mining (データマイニング) as well, especially find out what sub-factories impact on the real results via big data.

KRGreyTheory could apply in setting pre-processing of weights / biases of neural network.

#### Podfile

```ruby
platform :ios, '8.0'
pod "KRGreyTheory", "~> 1.2.0"
```

## How to use

#### Import KRGreyTheory
``` objective-c
#import "KRGreyTheory.h"
```

#### Using GM1N model
``` objective-c
KRGreyGM1N *gm1n = [[KRGreyTheory sharedTheory] useGM1N];
[gm1n addPatterns:@[@2.0f, @11.0f, @1.5f, @2.0f, @2.2f, @3.0f] patternKey:@"x1"];
[gm1n addPatterns:@[@3.0f, @13.5f, @1.0f, @3.0f, @3.0f, @4.0f] patternKey:@"x2"];
[gm1n addPatterns:@[@2.0f, @11.0f, @3.5f, @2.0f, @3.0f, @2.0f] patternKey:@"x3"];
[gm1n addPatterns:@[@4.0f, @12.0f, @2.0f, @1.0f, @2.0f, @1.0f] patternKey:@"x4"];
[gm1n addPatterns:@[@1.0f, @10.0f, @5.0f, @2.0f, @1.0f, @1.0f] patternKey:@"x5"];
[gm1n analyze];
[gm1n print];
```

#### Using GM0N model
``` objective-c
KRGreyGM0N *gm0n = [[KRGreyTheory sharedTheory] useGM0N];
[gm0n addPatterns:@[@1.0f, @1.0f, @1.0f, @1.0f, @1.0f, @1.0f] 	   patternKey:@"x1"];
[gm0n addPatterns:@[@0.75f, @1.22f, @0.2f, @1.0f, @1.0f, @1.0f]    patternKey:@"x2"];
[gm0n addPatterns:@[@0.5f, @1.0f, @0.7f, @0.66f, @1.0f, @0.5f]     patternKey:@"x3"];
[gm0n addPatterns:@[@1.0f, @1.09f, @0.4f, @0.33f, @0.66f, @0.25f]  patternKey:@"x4"];
[gm0n addPatterns:@[@0.25f, @0.99f, @1.0f, @0.66f, @0.33f, @0.25f] patternKey:@"x5"];
[gm0n analyze];
[gm0n print];
```

#### Using GM11 model
``` objective-c
KRGreyGM11 *gm11 = [[KRGreyTheory sharedTheory] useGM11];
[gm11 addPattern:@533.0f patternKey:@"x1"];
[gm11 addPattern:@665.0f patternKey:@"x2"];
[gm11 addPattern:@655.0f patternKey:@"x3"];
[gm11 addPattern:@740.0f patternKey:@"x4"];
[gm11 forecast]; // To forecast x5 that number
[gm11 print];
```

## Version

V1.2.0

## License

MIT.
