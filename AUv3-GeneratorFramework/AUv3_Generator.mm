//
//  AUv3-Generator.m
//  AUv3-GeneratorFramework
//
//  Created by John Carlson on 6/10/18.
//  Copyright © 2018 John Carlson. All rights reserved.
//

#import "AUv3_Generator.h"

#include "maximilian.h"

//////////////////////////////////

#pragma mark - AUv3_Generator : AUAudioUnit parameterTree ID

const AudioUnitParameterID frequencyParam = 0;

//////////////////////////////////

@implementation AUv3_Generator

//////////////////////////////////

#pragma mark - AUv3_Generator : AUAudioUnit parameterTree synthesis

@synthesize parameterTree = _parameterTree;

//////////////////////////////////

//AUAudioUnitBus *_inputBus; // was BufferedInputBus in sample code
//AudioStreamBasicDescription asbd; // local copy of the asbd that block can capture

UInt64 totalFrames = 0;
AUValue frequency = 750;
AudioBufferList renderABL;

maxiOsc *oscillator;
maxiSettings *oscillatorSettings;

//////////////////////////////////

#pragma mark - AUv3_Generator : AUAudioUnit instatiation
/*
+ (void)instantiateWithComponentDescription:
        (AudioComponentDescription)componentDescription options:
        (AudioComponentInstantiationOptions)options completionHandler:
        (void (^)(AUAudioUnit *audioUnit, NSError *error))completionHandler
{
    
}
 */

- (instancetype)initWithComponentDescription:
        (AudioComponentDescription)componentDescription options:
        (AudioComponentInstantiationOptions)options error:
        (NSError **)outError {
    self = [super initWithComponentDescription:componentDescription
            options:options error:outError];
    
    if (self == nil) {
        return nil;
    }
    
    
    // @invalidname: Initialize a default format for the busses.
    AVAudioFormat *defaultFormat = [[AVAudioFormat alloc] initStandardFormatWithSampleRate:44100.0 channels:2];
    
    oscillatorSettings->sampleRate = 44100.0;
    
    /*
    asbd = *defaultFormat.streamDescription;
    
    NSLog (@"^^^^ defaultFormat.streamDescription:\n"\
           "mBitsPerChannel: %u,\n"\
           "mBytesPerFrame: %u,\n"\
           "mBytesPerPacket: %u,\n"\
           "mChannelsPerFrame: %u,\n"\
           "mFormatID: %u, \n"\
           "mFormatFlags: 0x%x,\n"\
           "mFramesPerPacket: %u,\n"\
           "mSampleRate: %f\n",
           (unsigned int) asbd.mBitsPerChannel,
           (unsigned int) asbd.mBytesPerFrame,
           (unsigned int) asbd.mBytesPerPacket,
           (unsigned int) asbd.mChannelsPerFrame,
           (unsigned int) asbd.mFormatID,
           (unsigned int) asbd.mFormatFlags,
           (unsigned int) asbd.mFramesPerPacket,
           asbd.mSampleRate
           );
    NSLog (@"This %@ kAudioFormatFlagsNativeFloatPacked (%u)",
           asbd.mFormatFlags == kAudioFormatFlagsNativeFloatPacked ? @"is" : @"is not",
           kAudioFormatFlagsNativeFloatPacked);
    */
    
    // Create parameter objects.
    AUParameter *param1 = [AUParameterTree createParameterWithIdentifier:@"frequency" name:@"Frequency" address:frequencyParam min:15 max:40 unit:kAudioUnitParameterUnit_Hertz unitName:nil flags:0 valueStrings:nil dependentParameters:nil];
    
    // Initialize the parameter values.
    param1.value = 22;
    
    // Create the parameter tree.
    _parameterTree = [AUParameterTree createTreeWithChildren:@[ param1 ]];
    
    // Create the input and output busses (AUAudioUnitBus).
    // @invalidname
    //_inputBus = [[AUAudioUnitBus alloc] initWithFormat:defaultFormat error:nil];
    _outputBus = [[AUAudioUnitBus alloc] initWithFormat:defaultFormat error:nil];
    
    // Create the input and output bus arrays (AUAudioUnitBusArray).
    // @invalidname
    //_inputBusArray  = [[AUAudioUnitBusArray alloc] initWithAudioUnit:self busType:AUAudioUnitBusTypeInput busses: @[_inputBus]];
    _outputBusArray = [[AUAudioUnitBusArray alloc] initWithAudioUnit:self busType:AUAudioUnitBusTypeOutput busses: @[_outputBus]];
    
    
    // implementorValueObserver is called when a parameter changes value.
    _parameterTree.implementorValueObserver = ^(AUParameter *param, AUValue value) {
        switch (param.address) {
            case frequencyParam:
                frequency = value;
                break;
            default:
                break;
        }
    };
    
    // implementorValueProvider is called when the value needs to be refreshed.
    _parameterTree.implementorValueProvider = ^(AUParameter *param) {
        switch (param.address) {
            case frequencyParam:
                return frequency; // TODO: is this capturing self?
            default:
                return (AUValue) 0.0;
        }
    };
    
    
    // A function to provide string representations of parameter values.
    _parameterTree.implementorStringFromValueCallback = ^(AUParameter *param, const AUValue *__nullable valuePtr) {
        AUValue value = valuePtr == nil ? param.value : *valuePtr;
        
        switch (param.address) {
            case frequencyParam:
                return [NSString stringWithFormat:@"%.0f", value];
            default:
                return @"?";
        }
    };
    
    self.maximumFramesToRender = 512;
    
    return self;
}

////////////////////////////////

-(void)dealloc {
    // Deallocate resources as required.
}

////////////////////////////////

#pragma mark - AUAudioUnit Overrides

// If an audio unit has input, an audio unit's audio input connection points.
// Subclassers must override this property getter and should return the same object every time.
// See sample code.
/*
- (AUAudioUnitBusArray *)inputBusses {
    NSLog (@"MyAudioUnit inputBusses called");
    return _inputBusArray;
}
 */

// An audio unit's audio output connection points.
// Subclassers must override this property getter and should return the same object every time.
// See sample code.
- (AUAudioUnitBusArray *)outputBusses {
    NSLog (@"MyAudioUnit outputBusses called");
    return _outputBusArray;
}

////////////////////////////////

#pragma mark - AUv3_Generator : AUAudioUnit initialization

/*
- (AUAudioUnit *)createAudioUnitWithComponentDescription:
        (AudioComponentDescription)desc error:
        (NSError ** _Nullable *)
        error
{
    
}
 */

/*
- (void)requestViewControllerWithCompletionHandler:
        (void (^)(AUViewControllerBase *viewController))
        completionHandler
{
    
}
 */

///////////////////////////////////

#pragma mark - AUAudioUnit Managing Render Resources
/*
 - (BOOL)allocateRenderResourcesAndReturnError:
 (NSError * _Nullable *)outError
 {
 if (![super allocateRenderResourcesAndReturnError:outError])
 {
 return NO;
 }
 
 if (self.outputBus.format.channelCount != _inputBus.bus.format.channelCount)
 {
 if (outError)
 {
 *outError = [NSError errorWithDomain:NSOSStatusErrorDomain code:kAudioUnitErr_FailedInitialization userInfo:nil];
 }
 // Notify superclass that initialization was not successful
 self.renderResourcesAllocated = NO;
 
 return NO;
 }
 
 _inputBus.allocateRenderResources(self.maximumFramesToRender);
 
 _kernel.init(self.outputBus.format.channelCount, self.outputBus.format.sampleRate);
 _kernel.reset();
 
 return YES;
 }
 */


// Allocate resources required to render.
// Subclassers should call the superclass implementation.
- (BOOL)allocateRenderResourcesAndReturnError:(NSError **)outError {
    if (![super allocateRenderResourcesAndReturnError:outError]) {
        return NO;
    }
    
    // Validate that the bus formats are compatible.
    // Allocate your resources.
    renderABL.mNumberBuffers = 2; // this is actually needed
    
    totalFrames = 0;
    
    return YES;
}


// Deallocate resources allocated in allocateRenderResourcesAndReturnError:
// Subclassers should call the superclass implementation.
- (void)deallocateRenderResources {
    // Deallocate your resources.
    [super deallocateRenderResources];
}


/*
 - (void)reset
 {
 
 }
 */

///////////////////////////////////

#pragma mark - AUAudioUnit (AUAudioUnitImplementation)

/*
- (AUInternalRenderBlock)internalRenderBlock
{
 */
    /*
		Capture in locals to avoid ObjC member lookups. If "self" is captured in
        render, we're doing it wrong.
	*/
    // Specify captured objects are mutable.
    //__block FilterDSPKernel *state = &_kernel;
    //__block BufferedInputBus *input = &_inputBus;

    /*
    return ^AUAudioUnitStatus
    (
            AudioUnitRenderActionFlags *actionFlags,
            const AudioTimeStamp       *timestamp,
            AVAudioFrameCount           frameCount,
            NSInteger                   outputBusNumber,
            AudioBufferList            *outputData,
            const AURenderEvent        *realtimeEventListHead,
            AURenderPullInputBlock      pullInputBlock
    )
    {
        AudioUnitRenderActionFlags pullFlags = 0;

        AUAudioUnitStatus err = input->pullInput(&pullFlags, timestamp, frameCount, 0, pullInputBlock);

        if (err != 0) { return err; }

        AudioBufferList *inAudioBufferList = input->mutableAudioBufferList;
        */

        /*
         Important:
             If the caller passed non-null output pointers (outputData->mBuffers[x].mData), use those.

             If the caller passed null output buffer pointers, process in memory owned by the Audio Unit
             and modify the (outputData->mBuffers[x].mData) pointers to point to this owned memory.
             The Audio Unit is responsible for preserving the validity of this memory until the next call to render,
             or deallocateRenderResources is called.

             If your algorithm cannot process in-place, you will need to preallocate an output buffer
             and use it here.

             See the description of the canProcessInPlace property.
         */

        /*
        // If passed null output buffer pointers, process in-place in the input buffer.
        AudioBufferList *outAudioBufferList = outputData;
        if (outAudioBufferList->mBuffers[0].mData == nullptr) {
            for (UInt32 i = 0; i < outAudioBufferList->mNumberBuffers; ++i) {
                outAudioBufferList->mBuffers[i].mData = inAudioBufferList->mBuffers[i].mData;
            }
        }

        state->setBuffers(inAudioBufferList, outAudioBufferList);
        state->processWithEvents(timestamp, frameCount, realtimeEventListHead);

        return noErr;
    };
}
*/

// Block which subclassers must provide to implement rendering.
- (AUInternalRenderBlock)internalRenderBlock {
    // Capture in locals to avoid Obj-C member lookups. If "self" is captured in render, we're doing it wrong. See sample code.

    AUValue *frequencyCapture = &frequency;
    //AudioStreamBasicDescription *asbdCapture = &asbd;
    __block UInt64 *totalFramesCapture = &totalFrames;
    AudioBufferList *renderAudioBufferList = &renderABL;

    return ^AUAudioUnitStatus(AudioUnitRenderActionFlags *actionFlags, const AudioTimeStamp *timestamp, AVAudioFrameCount frameCount, NSInteger outputBusNumber, AudioBufferList *outputData, const AURenderEvent *realtimeEventListHead, AURenderPullInputBlock pullInputBlock) {
    
        // Do event handling and signal processing here.

        // cheat: use logged asbd's format from above (float + packed + noninterleaved)
        /*
        if (asbdCapture->mFormatID != kAudioFormatLinearPCM || asbdCapture->mFormatFlags != 0x29 || asbdCapture->mChannelsPerFrame != 2) {
            return -999;
        }
         */

        // pull in samples to filter
        //pullInputBlock(actionFlags, timestamp, frameCount, 0, renderABLCapture);

        // copy samples from ABL, apply filter, write to outputData
        //size_t sampleSize = sizeof(Float32);
        
        for (int frame = 0; frame < frameCount; frame++) {
            *totalFramesCapture += 1;
            
            int length = outputData->mBuffers[0].mDataByteSize;
            float tempMonoBuffer[length];
            double freq = (double) *frequencyCapture;
            
            for(int sample = 0; sample < length; sample++){
                
                tempMonoBuffer[sample] = oscillator->sinewave(freq);
                
                for (int renderBuf = 0; renderBuf < renderAudioBufferList->mNumberBuffers; renderBuf++) {
                    
                    memcpy(outputData->mBuffers[renderBuf].mData,
                           tempMonoBuffer,
                           length);
                
            }
                
                //Float32 *sample = renderABLCapture->mBuffers[renderBuf].mData + (frame * asbdCapture->mBytesPerFrame);
                
                
                // apply modulation
                //Float32 time = totalFrames / asbdCapture->mSampleRate;
                //*sample = *sample * fabs(sinf(M_PI * 2 * time * *frequencyCapture));

                /*
                 memcpy(outputData->mBuffers[renderBuf].mData + (frame * asbdCapture->mBytesPerFrame),
                        sample,
                        sampleSize);
                 */
            }
        }

        return noErr;
    };
}

/*
+ (void)registerSubclass:
        (Class)cls asComponentDescription:
        (AudioComponentDescription)componentDescription
                    name:(NSString *)name version:
        (UInt32)version
{
    
}
 */

/*
- (BOOL)shouldChangeToFormat:
        (AVAudioFormat *)format forBus:
        (AUAudioUnitBus *)bus
{
    
}
 */

/*
- (void)setRenderResourcesAllocated:
        (BOOL)flag{
    
}
 */

//////////////////////////////////////

#pragma mark - AUAudioUnit Managing Render Cycle
/*
- (NSInteger)tokenByAddingRenderObserver:(AURenderObserver)observer
{
    _inputBus.deallocateRenderResources();

    [super deallocateRenderResources];
}
 */

/*
- (void)removeRenderObserver:(NSInteger)token{
    
}
 */

///////////////////////////////////////

#pragma mark - AUAudioUnit Input/Output Units

/*
- (BOOL)setDeviceID:
        (AudioObjectID)deviceID error:
        (NSError * _Nullable *)outError
{
    
}

- (BOOL)startHardwareAndReturnError:
        (NSError * _Nullable *)outError
{
    
}

- (void)stopHardware
{
    
}
 */

/////////////////////////////

#pragma mark - AUAudioUnit Querying Parameters
/*
- (NSArray<NSNumber *> *)parametersForOverviewWithCount:
        (NSInteger)count
{
    
}
 */

//////////////////////////////

@end
