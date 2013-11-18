//
//  ViewController.m
//  sound
//
//  Created by Gabriel Massana on 11/13/13.
//  Copyright (c) 2013 Gabriel Massana. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong)AVAudioPlayer *player;
@property (nonatomic, strong)AVAudioPlayer *appSoundPlayer;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];


    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    
    NSError *setCategoryError = nil;
    
    //Checking if other audio is playing
    BOOL otherAudioIsPlaying = [audioSession isOtherAudioPlaying];
    
    if (otherAudioIsPlaying)
    {
        [audioSession setCategory: AVAudioSessionCategoryAmbient error: &setCategoryError];
    }
    else
    {
        [audioSession setCategory: AVAudioSessionCategorySoloAmbient error: &setCategoryError];
    }
    
    if (setCategoryError) { /* handle the error condition */ }
    
    NSError *activationError = nil;
    [audioSession setActive:YES error:&activationError];
    
    if (activationError) { /* handle the error condition */ }
    
    NSString *soundFilePath = [[NSBundle mainBundle] pathForResource:@"sound" ofType:@"caf"];
    
    NSURL *newURL = [[NSURL alloc] initFileURLWithPath: soundFilePath];
	NSURL *soundFileURL = newURL;
    
    // Instantiates the AVAudioPlayer object, initializing it with the sound
	self.player = [[AVAudioPlayer alloc] initWithContentsOfURL: soundFileURL error: NULL];
    
	self.appSoundPlayer = self.player;
    
    [self.appSoundPlayer prepareToPlay];
	[self.appSoundPlayer setVolume: 1.0];
	[self.appSoundPlayer setDelegate: self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)action:(id)sender
{
        [self sound];
}

- (void) sound
{
    [self.appSoundPlayer play];
}

@end
