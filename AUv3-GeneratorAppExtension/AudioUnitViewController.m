//
//  AudioUnitViewController.m
//  AUv3-GeneratorAppExtension
//
//  Created by John Carlson on 6/10/18.
//  Copyright © 2018 John Carlson. All rights reserved.
//

#import "AudioUnitViewController.h"
#import "AUv3_GeneratorAppExtensionAudioUnit.h"

@interface AudioUnitViewController ()

@end

@implementation AudioUnitViewController {
    AUAudioUnit *audioUnit;
}

- (void) viewDidLoad {
    [super viewDidLoad];
    
    if (!audioUnit) {
        return;
    }
    
    // Get the parameter tree and add observers for any parameters that the UI needs to keep in sync with the AudioUnit
}

- (AUAudioUnit *)createAudioUnitWithComponentDescription:(AudioComponentDescription)desc error:(NSError **)error {
    audioUnit = [[AUv3_GeneratorAppExtensionAudioUnit alloc] initWithComponentDescription:desc error:error];
    
    return audioUnit;
}

@end
