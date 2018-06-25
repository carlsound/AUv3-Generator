//
//  AUv3-Generator.h
//  AUv3-GeneratorFramework
//
//  Created by John Carlson on 6/10/18.
//  Copyright © 2018 John Carlson. All rights reserved.
//

#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>
#import <CoreAudioKit/CoreAudioKit.h>

@interface AUv3_Generator : AUAudioUnit

////////////////////////////////

#pragma mark - AUv3_Generator : AUAudioUnit instatiation

+ (void)instantiateWithComponentDescription:(AudioComponentDescription)componentDescription options:(AudioComponentInstantiationOptions)options completionHandler:(void (^)(AUAudioUnit *audioUnit, NSError *error))completionHandler;

#pragma mark - AUv3_Generator : AUAudioUnit initialization

- (AUAudioUnit *)createAudioUnitWithComponentDescription:(AudioComponentDescription)desc error:(NSError * _Nullable *)error;

- (void)requestViewControllerWithCompletionHandler:(void (^)(AUViewControllerBase *viewController))completionHandler;

////////////////////////////////

#pragma mark - AUAudioUnit (AUAudioUnitImplementation)

- (AUInternalRenderBlock)internalRenderBlock;

+ (void)registerSubclass:(Class)cls asComponentDescription:(AudioComponentDescription)componentDescription name:(NSString *)name version:(UInt32)version;

- (BOOL)shouldChangeToFormat:(AVAudioFormat *)format forBus:(AUAudioUnitBus *)bus;

- (void)setRenderResourcesAllocated:(BOOL)flag;

////////////////////////////////

#pragma mark - AUAudioUnit Querying Descriptive Properties
//@property componentDescription;
//@property component;
//@property componentName;
//@property componentVersion;
//@property audioUnitName;
//@property manufacturerName;

///////////////////////////////

#pragma mark - AUAudioUnit Managing Render Resources
- (BOOL)allocateRenderResourcesAndReturnError:(NSError * _Nullable *)outError;

- (void)deallocateRenderResources;

- (void)reset;

@property(readonly, atomic) BOOL renderResourcesAllocated;

//////////////////////////////

#pragma mark - AUAudioUnit Querying Buses
@property(readonly, atomic) AUAudioUnitBusArray *inputBusses;
@property(readonly, atomic) AUAudioUnitBusArray *outputBusses;

//////////////////////////////

#pragma mark - AUAudioUnit Managing Render Cycle
@property(readonly, atomic) AURenderBlock renderBlock;
@property(readonly, atomic) AUScheduleParameterBlock scheduleParameterBlock;
@property(atomic) AUAudioFrameCount maximumFramesToRender;

- (NSInteger)tokenByAddingRenderObserver:(AURenderObserver)observer;

- (void)removeRenderObserver:(NSInteger)token;

/////////////////////////////

#pragma mark - AUAudioUnit Instance Properties
@property(readonly, copy, atomic) NSString *audioUnitShortName;
@property(copy, atomic) NSArray<NSNumber *> *channelMap;
@property(nonatomic, readonly) NSTimeInterval deviceInputLatency;
@property(nonatomic, readonly) NSTimeInterval deviceOutputLatency;
@property(nonatomic, readonly, getter=isRunning) BOOL running;
@property(atomic) NSInteger MIDIOutputBufferSizeHint;
@property(copy, atomic) AUMIDIOutputEventBlock MIDIOutputEventBlock;
@property(readonly, copy, atomic) NSArray<NSString *> *MIDIOutputNames;
@property(readonly, atomic) BOOL providesUserInterface;
@property(readonly, atomic) BOOL supportsMPE;

/////////////////////////////

#pragma mark - AUAudioUnit Input/Output Units
@property(nonatomic, readonly) BOOL canPerformInput;
@property(nonatomic, readonly) BOOL canPerformOutput;
@property(nonatomic, getter=isInputEnabled) BOOL inputEnabled;
@property(nonatomic, getter=isOutputEnabled) BOOL outputEnabled;
@property(nonatomic, copy) AUInputHandler inputHandler;
@property(nonatomic, copy) AURenderPullInputBlock outputProvider;
@property(nonatomic, readonly) AudioObjectID deviceID;

- (BOOL)setDeviceID:(AudioObjectID)deviceID error:(NSError * _Nullable *)outError;

- (BOOL)startHardwareAndReturnError:(NSError * _Nullable *)outError;

- (void)stopHardware;

/////////////////////////////

#pragma mark - AUAudioUnit Channel Capabilities
@property(readonly, copy, atomic) NSArray<NSNumber *> *channelCapabilities;

/////////////////////////////

#pragma mark - AUAudioUnit Host Callbacks
@property(copy, atomic) AUHostMusicalContextBlock musicalContextBlock;
@property(copy, atomic) AUHostTransportStateBlock transportStateBlock;
@property(copy, atomic) NSString *contextName;

/////////////////////////////

#pragma mark - AUAudioUnit Querying Parameters
@property(readonly, atomic) AUParameterTree *parameterTree;
@property(readonly, atomic) BOOL allParameterValues;
- (NSArray<NSNumber *> *)parametersForOverviewWithCount:(NSInteger)count;

/////////////////////////////

#pragma mark - AUAudioUnit Managing MIDI Events
@property(readonly, getter=isMusicDeviceOrEffect, atomic) BOOL musicDeviceOrEffect;
@property(readonly, atomic) NSInteger virtualMIDICableCount;
@property(readonly, atomic) AUScheduleMIDIEventBlock scheduleMIDIEventBlock;

/////////////////////////////

#pragma mark - AUAudioUnit Optimizing Performance
@property(readonly, atomic) NSTimeInterval latency;
@property(readonly, atomic) NSTimeInterval tailTime;
@property(atomic) NSInteger renderQuality;
@property(atomic) BOOL shouldBypassEffect;
@property(readonly, atomic) BOOL canProcessInPlace;
@property(getter=isRenderingOffline, atomic) BOOL renderingOffline;

@end
