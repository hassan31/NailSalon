//
//  AppDelegate.h
//  NailSalon
//
//  Created by Alexandra Smau on 5/7/13.
//  Copyright (c) 2013 Newrosoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <RevMobAds/RevMobAds.h>
#import "StoreViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    BOOL nailsLocked;
    BOOL colorLocked;
    BOOL glossLocked;
    BOOL patternLocked;
    BOOL tipLocked;
    BOOL extrasLocked;
    BOOL backgroundLocked;
    
    AVAudioPlayer *buttonTap;
    AVAudioPlayer *initialSound;
    AVAudioPlayer *finalSound;
    AVAudioPlayer *sparkleSound;
    AVAudioPlayer *loopSong;

    BOOL fromLastPage;
    BOOL firstTime;
    
    StoreViewController *store;

}

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UINavigationController *navigationController;
@property (nonatomic, retain) StoreViewController *store;

@property (nonatomic) BOOL fromLastPage;
@property (nonatomic) BOOL firstTime;

@property (nonatomic) BOOL nailsLocked;
@property (nonatomic) BOOL colorLocked;
@property (nonatomic) BOOL glossLocked;
@property (nonatomic) BOOL patternLocked;
@property (nonatomic) BOOL tipLocked;
@property (nonatomic) BOOL extrasLocked;
@property (nonatomic) BOOL backgroundLocked;

- (void)showFullScreenAd;
- (void)showPopupAd;
- (void)promptReview;
- (void)showChartboostAd;

- (void)playSoundEffect:(NSInteger)sound;
- (void)stopSoundEffect:(NSInteger)sound;


@end
