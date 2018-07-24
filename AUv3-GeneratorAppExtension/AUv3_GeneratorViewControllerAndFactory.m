//
//  AUv3_GeneratorAppExtensionAudioUnit.m
//  AUv3-GeneratorAppExtension
//
//  Created by John Carlson on 6/10/18.
//  Copyright © 2018 John Carlson. All rights reserved.
//

#import <AUv3_GeneratorFramework/AUv3_GeneratorFramework.h>
#import "AUv3_GeneratorViewControllerAndFactory.h"

//#import <AudioToolbox/AudioToolbox.h>
//#import <AVFoundation/AVFoundation.h>

@implementation AUv3_GeneratorViewController (AUAudioUnitFactory)

- (AUv3_Generator *) createAudioUnitWithComponentDescription:(AudioComponentDescription) desc error:(NSError **)error {
    self.audioUnit = [[AUv3_Generator alloc] initWithComponentDescription:desc error:error];
    return self.audioUnit;
}

@end
