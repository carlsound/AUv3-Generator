//
//  AUv3_GeneratorViewController.m
//  AUv3-GeneratorFramework
//
//  Created by John Carlson on 7/22/18.
//  Copyright © 2018 John Carlson. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "AUv3_Generator.h"
#import "AUv3_GeneratorViewController.h"

///////////////////////////////////////////

@interface AUv3_GeneratorViewController (){

    __weak IBOutlet NSTextField *frequencyLabel;
    __weak IBOutlet NSSlider *frequencySlider;
    
    AUParameter *cutoffParameter;
    AUParameterObserverToken parameterObserverToken;
}

- (IBAction)setFrequencyFromText:(id)sender;

- (IBAction)setFrequencyFromSlider:(id)sender;

@end

////////////////////////////////////////////

@implementation AUv3_GeneratorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.

    if (_audioUnit) {
        [self connectViewWithAU];
    }
}

/////////////////

- (void)dealloc {
    [self disconnectViewWithAU];
}

/////////////////

#pragma mark-
- (AUv3_Generator *)getAudioUnit {
    return _audioUnit;
}

- (void)setAudioUnit:(AUv3_Generator *)audioUnit {
    _audioUnit = audioUnit;
    dispatch_async(dispatch_get_main_queue(), ^{
        if ([self isViewLoaded]) {
            [self connectViewWithAU];
        }
    });
}

/////////////////

#pragma mark-
- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary<NSString *, id> *)change
                       context:(void *)context
{
    NSLog(@"FilterDemoViewControler allParameterValues key path changed: %s\n", keyPath.UTF8String);

    dispatch_async(dispatch_get_main_queue(), ^{

        frequencyLabel.stringValue = [cutoffParameter stringFromValue: nil];

        //[self updateFilterViewFrequencyAndMagnitudes];
    });
}

/////////////////

- (void)connectViewWithAU {
    AUParameterTree *paramTree = _audioUnit.parameterTree;

    if (paramTree) {
        cutoffParameter = [paramTree valueForKey: @"cutoff"];

        // prevent retain cycle in parameter observer
        //__weak FilterDemoViewController *weakSelf = self;
        __weak AUParameter *weakCutoffParameter = cutoffParameter;
        //
        parameterObserverToken = [paramTree tokenByAddingParameterObserver:^(AUParameterAddress address, AUValue value) {
            //__strong FilterDemoViewController *strongSelf = weakSelf;
            __strong AUParameter *strongCutoffParameter = weakCutoffParameter;
            //
            /*
            dispatch_async(dispatch_get_main_queue(), ^{
                if (address == strongCutoffParameter.address){
                    strongSelf->filterView.frequency = value;
                    strongSelf->frequencyLabel.stringValue = [strongCutoffParameter stringFromValue: nil];
                } else if (address == strongResonanceParameter.address) {
                    strongSelf->filterView.resonance = value;
                    strongSelf->resonanceLabel.stringValue = [strongResonanceParameter stringFromValue: nil];
                }

                [strongSelf updateFilterViewFrequencyAndMagnitudes];
            )};
             */
        }];

        frequencyLabel.stringValue = [cutoffParameter stringFromValue: nil];

        [_audioUnit addObserver:self forKeyPath:@"allParameterValues"
                        options:NSKeyValueObservingOptionNew
                        context:parameterObserverToken];
    } else {
        NSLog(@"paramTree is NULL!\n");
    }
}

/////////////////

- (void)disconnectViewWithAU {
    if (parameterObserverToken) {
        [_audioUnit.parameterTree removeParameterObserver:parameterObserverToken];
        [_audioUnit removeObserver:self forKeyPath:@"allParameterValues" context:parameterObserverToken];
        parameterObserverToken = 0;
    }
}

/////////////////

#pragma mark -
#pragma mark: <FilterViewDelegate>

/*
- (void) updateFilterViewFrequencyAndMagnitudes {
    if (!_audioUnit) return;

    NSArray *frequencies = [filterView frequencyDataForDrawing];
    NSArray *magnitudes  = [_audioUnit magnitudesForFrequencies:frequencies];

    [filterView setMagnitudes: magnitudes];
}
 */

/////////////////

/*
- (void)filterViewDataDidChange:(FilterView *)sender {
    [self updateFilterViewFrequencyAndMagnitudes];
}
 */

/////////////////

/*
- (void)filterViewDidChange:(FilterView *)sender frequency:(double)frequency {
    cutoffParameter.value = frequency;

    [self updateFilterViewFrequencyAndMagnitudes];
}
 */

/////////////////

/*
- (void)filterViewDidChange:(FilterView *)sender resonance:(double)resonance {
    resonanceParameter.value = resonance;

    [self updateFilterViewFrequencyAndMagnitudes];
}
 */

/////////////////

#pragma mark: Actions

- (IBAction)setCutoff:(id)sender {
}

- (IBAction)setFrequencyFromText:(id)sender {
}

- (IBAction)setFrequencyFromSlider:(id)sender {
}

- (IBAction) setCutoff:(id) sender {
    if (sender == frequencyLabel)
        cutoffParameter.value = frequencyLabel.floatValue;

    //[self updateFilterViewFrequencyAndMagnitudes];
}

/////////////////

- (IBAction)setCutoff:(id)sender {
}
@end
