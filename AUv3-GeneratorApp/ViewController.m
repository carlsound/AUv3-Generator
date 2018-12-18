//
//  ViewController.m
//  AUv3-Generator
//
//  Created by John Carlson on 6/10/18.
//  Copyright © 2018 John Carlson. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"

#import "AUv3_GeneratorFramework.h"
#import <CoreAudioKit/AUViewController.h>
#import "AUv3_GeneratorViewController.h"

/////////////////////////////////////////////////////

#define kMinHertz 20.0f
#define kMaxHertz 20000.0f

/////////////////////////////////////////////////////

@interface ViewController () {

    AUv3_GeneratorViewController *auV3ViewController;

    AUParameter *frequencyParameter;

    AUParameterObserverToken parameterObserverToken;
}

@property (weak) IBOutlet NSView *containerView;

@end

//////////////////////////////////////////////////////

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.

    // Do any additional setup after loading the view.
    [self embedPlugInView];

    AudioComponentDescription desc;
    /*  Supply the correct AudioComponentDescription based on your AudioUnit type, manufacturer and creator.

        You need to supply matching settings in the AUAppExtension info.plist under:

        NSExtension
            NSExtensionAttributes
                AudioComponents
                    Item 0
                        type
                        subtype
                        manufacturer

         If you do not do this step, your AudioUnit will not work!!!
     */
    // MARK: AudioComponentDescription Important!
    // Ensure that you update the AudioComponentDescription for your AudioUnit type, manufacturer and creator type.
    desc.componentType = 'augn';
    desc.componentSubType = 'gnr8';
    desc.componentManufacturer = 'CRLS';
    desc.componentFlags = 0;
    desc.componentFlagsMask = 0;

    [AUAudioUnit registerSubclass: AUv3_Generator .class
           asComponentDescription: desc
                             name: @"Generator: Local AUv3"
                          version: UINT32_MAX];

    //playEngine = [[SimplePlayEngine alloc] initWithComponentType: desc.componentType componentsFoundCallback: nil];
    //[playEngine selectAudioUnitWithComponentDescription2:desc completionHandler:^{
       // [self connectParametersToControls];
    //}];

    //[cutoffSlider sendActionOn:NSLeftMouseDraggedMask | NSLeftMouseDownMask];
    //[resonanceSlider sendActionOn:NSLeftMouseDraggedMask | NSLeftMouseDownMask];

    //[self populatePresetMenu];
}


- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}

////////////////////////

#pragma mark -

- (void)embedPlugInView {
    NSURL *builtInPlugInURL = [[NSBundle mainBundle] builtInPlugInsURL];
    NSURL *pluginURL = [builtInPlugInURL URLByAppendingPathComponent: @"AUv3_GeneratorAppExtension.appex"];
    NSBundle *appExtensionBundle = [NSBundle bundleWithURL: pluginURL];

    auV3ViewController = [[AUv3_GeneratorViewController alloc] initWithNibName: @"AUv3_GeneratorViewController" bundle: appExtensionBundle];

    NSView *view = auV3ViewController.view;
    view.frame = _containerView.bounds;

    [_containerView addSubview: view];

    view.translatesAutoresizingMaskIntoConstraints = NO;

    NSArray *constraints = [NSLayoutConstraint constraintsWithVisualFormat: @"H:|-[view]-|"
                                                                   options:0 metrics:nil
                                                                     views:NSDictionaryOfVariableBindings(view)];
    [_containerView addConstraints: constraints];

    constraints = [NSLayoutConstraint constraintsWithVisualFormat: @"V:|-[view]-|"
                                                          options:0 metrics:nil
                                                            views:NSDictionaryOfVariableBindings(view)];
    [_containerView addConstraints: constraints];
}

////////////////////////

-(void) connectParametersToControls {
    //AUParameterTree *parameterTree = playEngine.testAudioUnit.parameterTree;

   // auV3ViewController.audioUnit = (AUv3_Generator *)playEngine.testAudioUnit;
    //frequencyParameter = [parameterTree valueForKey: @"cutoff"];

    //__weak ViewController *weakSelf = self;
    //parameterObserverToken = [parameterTree tokenByAddingParameterObserver:^(AUParameterAddress address, AUValue value) {
        //dispatch_async(dispatch_get_main_queue(), ^{
            //__strong ViewController *strongSelf = weakSelf;

            //if (address == frequencyParameter.address)
                //[strongSelf updateCutoff];
        //});
    //}];

    //[self updateCutoff];
    //[self updateResonance];
}

/////////////////////////

#pragma mark-
#pragma mark: <NSWindowDelegate>

- (void)windowWillClose:(NSNotification *)notification {
    // Main applicaiton window closing, we're done
   // [playEngine stopPlaying];
    //[playEngine.testAudioUnit.parameterTree removeParameterObserver:parameterObserverToken];

    //playEngine = nil;
    auV3ViewController = nil;
}

//////////////////////////

#pragma mark-

static double logValueForNumber(double number) {
    return log(number)/log(2);
}

//////////////////////////

static double frequencyValueForSliderLocation(double location) {
    double value = powf(2, location); // (this gives us 2^0->2^9)
    value = (value - 1) / 511;        // (normalize based on rage of 2^9-1)

    // map to frequency range
    value *= (kMaxHertz - kMinHertz);

    return value + kMinHertz;
}

//////////////////////////

-(void) updateCutoff {
    //cutoffTextField.stringValue = [frequencyParameter stringFromValue:nil];

    double cutoffValue = frequencyParameter.value;

    // normalize the value from 0-1
    double normalizedValue = ((cutoffValue - kMinHertz) / (kMaxHertz - kMinHertz));

    // map to 2^0 - 2^9 (slider range)
    normalizedValue = (normalizedValue * 511.0) + 1;

    //double location = logValueForNumber(normalizedValue);
    //cutoffSlider.doubleValue = location;
}

//////////////////////////

#pragma mark-
#pragma mark: Actions


//////////////////////////

@end
