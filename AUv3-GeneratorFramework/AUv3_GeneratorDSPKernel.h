//
//  AUv3_GeneratorDSPKernel.h
//  AUv3-GeneratorFramework
//
//  Created by John Carlson on 12/17/18.
//  Copyright © 2018 John Carlson. All rights reserved.
//

#ifndef AUv3_GeneratorDSPKernel_h
#define AUv3_GeneratorDSPKernel_h

#import "DSPKernel.hpp"
#import <vector>

const double kTwoPi = 2.0 * M_PI;

enum {
    GeneratorParamFrequency = 0
};


/*
 AUv3_GeneratorDSPKernel
 Creates a tone signal.
 As a non-ObjC class, this is safe to use from render thread.
 */
class AUv3_GeneratorDSPKernel : public DSPKernel {
public:
    // MARK: Types
        
        void run(int n, float* outL, float* outR)
        {
            int framesRemaining = n;
            while (framesRemaining) {
                switch (stage) {
                    case stageOff :
                        NSLog(@"stageOff on playingNotes list!");
                        return;
                    case stageAttack : {
                        int framesThisTime = std::min(framesRemaining, envRampSamples);
                        for (int i = 0; i < framesThisTime; ++i) {
                            double x = envLevel * pow3(sin(oscPhase)); // cubing the sine adds 3rd harmonic.
                            *outL++ += ampL * x;
                            *outR++ += ampR * x;
                            envLevel += envSlope;
                            oscPhase += oscFreq;
                            if (oscPhase >= kTwoPi) oscPhase -= kTwoPi;
                        }
                        framesRemaining -= framesThisTime;
                        envRampSamples -= framesThisTime;
                        if (envRampSamples == 0) {
                            stage = stageSustain;
                        }
                        break;
                    }
                    case stageSustain : {
                        for (int i = 0; i < framesRemaining; ++i) {
                            double x = pow3(sin(oscPhase));
                            *outL++ += ampL * x;
                            *outR++ += ampR * x;
                            oscPhase += oscFreq;
                            if (oscPhase >= kTwoPi) oscPhase -= kTwoPi;
                        }
                        return;
                    }
                    case stageRelease : {
                        int framesThisTime = std::min(framesRemaining, envRampSamples);
                        for (int i = 0; i < framesThisTime; ++i) {
                            double x = envLevel * pow3(sin(oscPhase));
                            *outL++ += ampL * x;
                            *outR++ += ampR * x;
                            envLevel += envSlope;
                            oscPhase += oscFreq;
                        }
                        envRampSamples -= framesThisTime;
                        if (envRampSamples == 0) {
                            clear();
                            remove();
                        }
                        return;
                    }
                    default:
                        NSLog(@"bad stage on playingNotes list!");
                        return;
                }
            }
        }
    };
    
    
    // MARK: Member Functions
    
    AUv3_GeneratorDSPKernel() {
        noteStates.resize(128);
        for (NoteState& state : noteStates) {
            state.kernel = this;
        }
    }
    
    void init(int channelCount, double inSampleRate) {
        sampleRate = float(inSampleRate);
        
        frequencyScale = 2. * M_PI / sampleRate;
    }
    
    void reset() {
        for (NoteState& state : noteStates) {
            state.clear();
        }
        playingNotes = nullptr;
        playingNotesCount = 0;
        
    }
    
    void setParameter(AUParameterAddress address, AUValue value) {
        switch (address) {
            case GeneratorParamFrequency:
                //attack = clamp(value, 0.001f, 10.f);
                //attackSamples = sampleRate * attack;
                break;
        }
    }
    
    AUValue getParameter(AUParameterAddress address) {
        switch (address) {
            case InstrumentParamAttack:
                return attack;
                
            case InstrumentParamRelease:
                return release;
                
            default: return 0.0f;
        }
    }
    
    void startRamp(AUParameterAddress address, AUValue value, AUAudioFrameCount duration) /* override */ {
        // The attack and release parameters are not ramped.
        //setParameter(address, value);
    }
    
    void setBuffers(AudioBufferList* outBufferList) {
        outBufferListPtr = outBufferList;
    }

    
    void process(AUAudioFrameCount frameCount, AUAudioFrameCount bufferOffset) /* override */ {
        //float* outL = (float*)outBufferListPtr->mBuffers[0].mData + bufferOffset;
        //float* outR = (float*)outBufferListPtr->mBuffers[1].mData + bufferOffset;
        
        for (AUAudioFrameCount i = 0; i < frameCount; ++i) {
            //outL[i] *= .1f;
            //outR[i] *= .1f;
        }
    }
    
    // MARK: Member Variables
    
private:
    float sampleRate = 44100.0;
    double frequencyScale = 2. * M_PI / sampleRate;
    
    AudioBufferList* outBufferListPtr = nullptr;
    
public:
    int playingNotesCount = 0;
    
    // Parameters.
    float attack = .01f;
    float release = .1f;
    
    int attackSamples   = sampleRate * attack;
    int releaseSamples  = sampleRate * release;
    
};

#endif /* AUv3_GeneratorDSPKernel_h */
