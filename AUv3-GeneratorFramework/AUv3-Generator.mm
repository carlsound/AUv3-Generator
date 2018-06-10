//
//  AUv3-Generator.m
//  AUv3-GeneratorFramework
//
//  Created by John Carlson on 6/10/18.
//  Copyright © 2018 John Carlson. All rights reserved.
//

#import "AUv3-Generator.h"

@implementation AUv3_Generator

//////////////////////////////////

#pragma mark - AUv3_Generator : AUAudioUnit instatiation

+ (void)instantiateWithComponentDescription:(AudioComponentDescription)componentDescription options:(AudioComponentInstantiationOptions)options completionHandler:(void (^)(AUAudioUnit *audioUnit, NSError *error))completionHandler{
    
}

#pragma mark - AUv3_Generator : AUAudioUnit initialization

- (AUAudioUnit *)createAudioUnitWithComponentDescription:(AudioComponentDescription)desc error:(NSError * _Nullable *)error{
    
}

- (void)requestViewControllerWithCompletionHandler:(void (^)(AUViewControllerBase *viewController))completionHandler{
    
}

///////////////////////////////////

#pragma mark - AUAudioUnit (AUAudioUnitImplementation)

- (AUInternalRenderBlock)internalRenderBlock {
    
}

+ (void)registerSubclass:(Class)cls asComponentDescription:(AudioComponentDescription)componentDescription name:(NSString *)name version:(UInt32)version{
    
}

- (BOOL)shouldChangeToFormat:(AVAudioFormat *)format forBus:(AUAudioUnitBus *)bus{
    
}

- (void)setRenderResourcesAllocated:(BOOL)flag{
    
}

//////////////////////////////////////

#pragma mark - AUAudioUnit Managing Render Resources
- (BOOL)allocateRenderResourcesAndReturnError:(NSError * _Nullable *)outError{
    
}

- (void)deallocateRenderResources{
    
}

- (void)reset{
    
}

///////////////////////////////////////

#pragma mark - AUAudioUnit Managing Render Cycle

- (NSInteger)tokenByAddingRenderObserver:(AURenderObserver)observer{
    
}

- (void)removeRenderObserver:(NSInteger)token{
    
}

///////////////////////////////////////

#pragma mark - AUAudioUnit Input/Output Units

- (BOOL)setDeviceID:(AudioObjectID)deviceID error:(NSError * _Nullable *)outError{
    
}

- (BOOL)startHardwareAndReturnError:(NSError * _Nullable *)outError{
    
}

- (void)stopHardware{
    
}

/////////////////////////////

#pragma mark - AUAudioUnit Querying Parameters

- (NSArray<NSNumber *> *)parametersForOverviewWithCount:(NSInteger)count{
    
}

//////////////////////////////

@end
