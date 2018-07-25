//
//  AppDelegate.m
//  AUv3-Generator
//
//  Created by John Carlson on 6/10/18.
//  Copyright © 2018 John Carlson. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"

static dispatch_once_t onceToken;

@interface AppDelegate ()

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
}

- (void)applicationDidBecomeActive:(NSNotification *)aNotification {

    dispatch_once(&onceToken, ^{
        NSApplication *app = [NSApplication sharedApplication];
        app.mainWindow.delegate = (ViewController *)app.mainWindow.contentViewController;
    });
}


- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)sender {
    return YES;
}

@end
