//
//  AUv3-Generator.h
//  AUv3-GeneratorFramework
//
//  Created by John Carlson on 6/10/18.
//  Copyright © 2018 John Carlson. All rights reserved.
//

//
//  http://subfurther.com/blog/2017/04/28/brain-dump-v3-audio-units/
//  RingModulator
//  Created by Chris Adamson on 4/18/17.
//

#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>
#import <CoreAudioKit/CoreAudioKit.h>

//////////////////////////////////

#pragma mark - AUv3_Generator : AUAudioUnit parameterTree

extern const AudioUnitParameterID frequencyParam;

//////////////////////////////////

#pragma mark - AUv3_Generator : AUAudioUnit main interface

@interface AUv3_Generator : AUAudioUnit

//////////////////////////////////

#pragma mark - AUv3_Generator : AUAudioUnit main properties

@property (atomic, readwrite) AUParameterTree * _Nullable parameterTree;
// need these for actual filtering
//@property AUAudioUnitBus * _Nullable inputBus;
@property AUAudioUnitBus * _Nullable outputBus;
//@property AUAudioUnitBusArray * _Nullable inputBusArray;
@property AUAudioUnitBusArray * _Nullable outputBusArray;

//@property AUValue frequency;

////////////////////////////////

#pragma mark - AUv3_Generator : AUAudioUnit instatiation

//+ (void)instantiateWithComponentDescription:(AudioComponentDescription)componentDescription options:(AudioComponentInstantiationOptions)options completionHandler:(void (^_Nullable)(AUAudioUnit  * _Nullable audioUnit,   NSError * _Nullable error))completionHandler;

#pragma mark - AUv3_Generator : AUAudioUnit initialization

//- (AUAudioUnit *_Nullable)createAudioUnitWithComponentDescription:(AudioComponentDescription)desc error:(NSError * _Nullable)error;

//- (void)requestViewControllerWithCompletionHandler:(void (^_Nullable)(AUViewControllerBase * _Nullable viewController))completionHandler;

///////////////////////////////

#pragma mark - AUAudioUnit Managing Render Resources
- (BOOL)allocateRenderResourcesAndReturnError:(NSError *_Nullable* _Nullable)outError;

- (void)deallocateRenderResources;

//- (void)reset;

//@property(readonly, atomic) BOOL renderResourcesAllocated;

////////////////////////////////

#pragma mark - AUAudioUnit (AUAudioUnitImplementation)

//- (AUInternalRenderBlock _Nonnull )internalRenderBlock;

//+ (void)registerSubclass:(Class _Nullable )cls asComponentDescription:(AudioComponentDescription)componentDescription name:(NSString *_Nullable)name versi_Nullableon:(UInt32)version;

//- (BOOL)shouldChangeToFormat:(AVAudioFormat * _Nullable)format forBus:(AUAudioUnitBus * _Nullable)bus;

//- (void)setRenderResourcesAllocated:(BOOL)flag;

////////////////////////////////

#pragma mark - AUAudioUnit Querying Descriptive Properties
//@property componentDescription;
//@property component;
//@property componentName;
//@property componentVersion;
//@property audioUnitName;
//@property manufacturerName;

//////////////////////////////

#pragma mark - AUAudioUnit Querying Buses
//@property(readonly, atomic) AUAudioUnitBusArray *inputBusses;
//@property(readonly, atomic) AUAudioUnitBusArray *outputBusses;

//////////////////////////////

#pragma mark - AUAudioUnit Managing Render Cycle
//@property(readonly, atomic) AURenderBlock renderBlock;
//@property(readonly, atomic) AUScheduleParameterBlock scheduleParameterBlock;
//@property(atomic) AUAudioFrameCount maximumFramesToRender;

//- (NSInteger)tokenByAddingRenderObserver:(AURenderObserver)observer;

//- (void)removeRenderObserver:(NSInteger)token;

/////////////////////////////

#pragma mark - AUAudioUnit Instance Properties
//@property(readonly, copy, atomic) NSString * _Nullable audioUnitShortName;
//@property(copy, atomic) NSArray<NSNumber *> * _Nullable channelMap;
//@property(nonatomic, readonly) NSTimeInterval deviceInputLatency;
//@property(nonatomic, readonly) NSTimeInterval deviceOutputLatency;
//@property(nonatomic, readonly, getter=isRunning) BOOL running;
//@property(atomic) NSInteger MIDIOutputBufferSizeHint;
//@property(copy, atomic) AUMIDIOutputEventBlock _Nullable MIDIOutputEventBlock;
//@property(readonly, copy, atomic) NSArray<NSString *> * _Nullable MIDIOutputNames;
//@property(readonly, atomic) BOOL providesUserInterface;
//@property(readonly, atomic) BOOL supportsMPE;

/////////////////////////////

#pragma mark - AUAudioUnit Input/Output Units
//@property(nonatomic, readonly) BOOL canPerformInput;
//@property(nonatomic, readonly) BOOL canPerformOutput;
//@property(nonatomic, getter=isInputEnabled) BOOL inputEnabled;
//@property(nonatomic, getter=isOutputEnabled) BOOL outputEnabled;
//@property(nonatomic, copy) AUInputHandler inputHandler;
//@property(nonatomic, copy) AURenderPullInputBlock outputProvider;
//@property(nonatomic, readonly) AudioObjectID deviceID;

//- (BOOL)setDeviceID:(AudioObjectID)deviceID error:(NSError * _Nullable *)outError;

//- (BOOL)startHardwareAndReturnError:(NSError * _Nullable *)outError;

//- (void)stopHardware;

/////////////////////////////

#pragma mark - AUAudioUnit Channel Capabilities
//@property(readonly, copy, atomic) NSArray<NSNumber *> * _Nullable channelCapabilities;

/////////////////////////////

#pragma mark - AUAudioUnit Host Callbacks
//@property(copy, atomic) AUHostMusicalContextBlock _Nullable musicalContextBlock;
//@property(copy, atomic) AUHostTransportStateBlock _Nullable transportStateBlock;
//@property(copy, atomic) NSString * _Nullable contextName;

/////////////////////////////

#pragma mark - AUAudioUnit Querying Parameters
//@property(readonly, atomic) AUParameterTree * _Nullable parameterTree;
//@property(readonly, atomic) BOOL allParameterValues;
//- (NSArray<NSNumber *> *)parametersForOverviewWithCount:(NSInteger)count;

/////////////////////////////

#pragma mark - AUAudioUnit Managing MIDI Events
//@property(readonly, getter=isMusicDeviceOrEffect, atomic) BOOL musicDeviceOrEffect;
//@property(readonly, atomic) NSInteger virtualMIDICableCount;
//@property(readonly, atomic) AUScheduleMIDIEventBlock _Nullable scheduleMIDIEventBlock;

/////////////////////////////

#pragma mark - AUAudioUnit Optimizing Performance
//@property(readonly, atomic) NSTimeInterval latency;
//@property(readonly, atomic) NSTimeInterval tailTime;
//@property(atomic) NSInteger renderQuality;
//@property(atomic) BOOL shouldBypassEffect;
//@property(readonly, atomic) BOOL canProcessInPlace;
//@property(getter=isRenderingOffline, atomic) BOOL renderingOffline;

@end
