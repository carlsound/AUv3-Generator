//
//  AUv3_GeneratorViewController.h
//  AUv3-GeneratorFramework
//
//  Created by John Carlson on 7/22/18.
//  Copyright © 2018 John Carlson. All rights reserved.
//

#ifndef AUv3_GeneratorViewController_h
#define AUv3_GeneratorViewController_h

#import <CoreAudioKit/CoreAudioKit.h>

@class AUv3_Generator;

@interface AUv3_GeneratorViewController : AUViewController

@property (nonatomic)AUv3_Generator *audioUnit;

@end

#endif /* AUv3_GeneratorViewController_h */
