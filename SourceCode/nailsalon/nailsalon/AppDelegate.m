//
//  AppDelegate.m
//  NailSalon
//
//  Created by Alexandra Smau on 5/7/13.
//  Copyright (c) 2013 Newrosoft. All rights reserved.
//

#import "AppDelegate.h"
#import "MenuViewController.h"
#import "Defines.h"
#import <Chartboost/Chartboost.h>

@implementation AppDelegate
@synthesize nailsLocked, colorLocked, glossLocked, patternLocked, tipLocked, extrasLocked, backgroundLocked;
@synthesize fromLastPage;
@synthesize firstTime;
@synthesize store;

- (void)dealloc
{
    [_window release];
    [_navigationController release];
    [super dealloc];
}

#pragma mark - RevMob

- (void)showFullScreenAd
{
    if(nailsLocked == YES)
    {
        //[[RevMobAds session] showFullscreen];
    }
}

- (void)showPopupAd
{
    if(nailsLocked == YES)
    {
        //[[RevMobAds session] showPopup];
    }
}

- (void)revmobAdDidFailWithError:(NSError*)error
{
    NSLog(@"Ad failed with error: %@", error);
}

#pragma mark - Chartboost

- (void)showChartboostAd
{
 [Chartboost showInterstitial:CBLocationHomeScreen];
}

#pragma mark - Review

- (void)promptReview
{
//    BOOL hasReviewed = [[NSUserDefaults standardUserDefaults] boolForKey:@"hasreviewed"];
//    if(!hasReviewed)
//    {
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Love Making Nails?!"
//                                                        message:@"I rate You 5 out of 5, can you please rate me?"
//                                                       delegate:self
//                                              cancelButtonTitle:@"No Thanks"
//                                              otherButtonTitles:@"Sure!", nil];
//        alert.tag = 15;
//        [alert show];
//    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(alertView.tag == 10)
    {
        //        if(buttonIndex == 0)
        //        {
        //            NSLog(@"Chose not to unlock features");
        //        }
        //        else
        //        {
        //            NSLog(@"Chose to unlock features");
        //            [store productClick:nil];
        //        }
    }
    else if(alertView.tag == 15)
    {
        if(buttonIndex == 1)
        {
            
            if(([[[UIDevice currentDevice] systemVersion] compare:@"7.0" options:NSNumericSearch] != NSOrderedAscending))
            {
                [[UIApplication sharedApplication]openURL:[NSURL URLWithString:RATE_LINK_IOS7]];
            }
            else
            {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:RATE_LINK_IOS6]];
            }
        }
    }
}

#pragma mark - Locked

- (void)initializeLocked
{
    if([[NSUserDefaults standardUserDefaults] objectForKey:@"nailsLocked"] == nil)
    {
        nailsLocked = YES;
        [[NSUserDefaults standardUserDefaults] setObject:@"YES" forKey:@"nailsLocked"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    else if([[[NSUserDefaults standardUserDefaults] objectForKey:@"nailsLocked"] isEqualToString:@"YES"])
    {
        nailsLocked = YES;
    }
    else
    {
        nailsLocked = NO;
    }
    
    if([[NSUserDefaults standardUserDefaults] objectForKey:@"colorLocked"] == nil)
    {
        colorLocked = YES;
        [[NSUserDefaults standardUserDefaults] setObject:@"YES" forKey:@"colorLocked"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    else if([[[NSUserDefaults standardUserDefaults] objectForKey:@"colorLocked"] isEqualToString:@"YES"])
    {
        colorLocked = YES;
    }
    else
    {
        colorLocked = NO;
    }
    
    if([[NSUserDefaults standardUserDefaults] objectForKey:@"glossLocked"] == nil)
    {
        glossLocked = YES;
        [[NSUserDefaults standardUserDefaults] setObject:@"YES" forKey:@"glossLocked"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    else if([[[NSUserDefaults standardUserDefaults] objectForKey:@"glossLocked"] isEqualToString:@"YES"])
    {
        glossLocked = YES;
    }
    else
    {
        glossLocked = NO;
    }
    
    if([[NSUserDefaults standardUserDefaults] objectForKey:@"patternLocked"] == nil)
    {
        patternLocked = YES;
        [[NSUserDefaults standardUserDefaults] setObject:@"YES" forKey:@"patternLocked"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    else if([[[NSUserDefaults standardUserDefaults] objectForKey:@"patternLocked"] isEqualToString:@"YES"])
    {
        patternLocked = YES;
    }
    else
    {
        patternLocked = NO;
    }
    
    if([[NSUserDefaults standardUserDefaults] objectForKey:@"backgroundLocked"] == nil)
    {
        backgroundLocked = YES;
        [[NSUserDefaults standardUserDefaults] setObject:@"YES" forKey:@"backgroundLocked"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    else if([[[NSUserDefaults standardUserDefaults] objectForKey:@"backgroundLocked"] isEqualToString:@"YES"])
    {
        backgroundLocked = YES;
    }
    else
    {
        backgroundLocked = NO;
    }
    
    if([[NSUserDefaults standardUserDefaults] objectForKey:@"tipLocked"] == nil)
    {
        tipLocked = YES;
        [[NSUserDefaults standardUserDefaults] setObject:@"YES" forKey:@"tipLocked"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    else if([[[NSUserDefaults standardUserDefaults] objectForKey:@"tipLocked"] isEqualToString:@"YES"])
    {
        tipLocked = YES;
    }
    else
    {
        tipLocked = NO;
    }
    
    if([[NSUserDefaults standardUserDefaults] objectForKey:@"extrasLocked"] == nil)
    {
        extrasLocked = YES;
        [[NSUserDefaults standardUserDefaults] setObject:@"YES" forKey:@"extrasLocked"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    else if([[[NSUserDefaults standardUserDefaults] objectForKey:@"extrasLocked"] isEqualToString:@"YES"])
    {
        extrasLocked = YES;
    }
    else
    {
        extrasLocked = NO;
    }
    
    store = [[StoreViewController alloc] init];
}

#pragma mark - Sounds

- (void)prepareSoundEffects
{
    NSURL *soundPath = nil;
    NSError *setCategoryError = nil;
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryAmbient error:&setCategoryError];
    
    
    soundPath = [[NSURL alloc] initFileURLWithPath:[[NSBundle mainBundle] pathForResource:@"General_UIButtonSound_MS" ofType:@"caf"]];
    buttonTap = [[AVAudioPlayer alloc]initWithContentsOfURL:soundPath error:NULL];
    [buttonTap setDelegate:nil];
    [buttonTap prepareToPlay];
    
    soundPath = [[NSURL alloc] initFileURLWithPath:[[NSBundle mainBundle] pathForResource:@"Magic Wand Noise-SoundBible.com-375928671" ofType:@"mp3"]];
    initialSound = [[AVAudioPlayer alloc]initWithContentsOfURL:soundPath error:NULL];
    [initialSound setDelegate:nil];
    [initialSound prepareToPlay];
    
    soundPath = [[NSURL alloc] initFileURLWithPath:[[NSBundle mainBundle] pathForResource:@"magic-chime-06" ofType:@"mp3"]];
    sparkleSound = [[AVAudioPlayer alloc]initWithContentsOfURL:soundPath error:NULL];
    [sparkleSound setDelegate:nil];
    [sparkleSound prepareToPlay];
    
    soundPath = [[NSURL alloc] initFileURLWithPath:[[NSBundle mainBundle] pathForResource:@"CompletedDishMusic_CF" ofType:@"wav"]];
    finalSound = [[AVAudioPlayer alloc]initWithContentsOfURL:soundPath error:NULL];
    [finalSound setDelegate:nil];
    [finalSound prepareToPlay];
    
    soundPath = [[NSURL alloc] initFileURLWithPath:[[NSBundle mainBundle] pathForResource:@"BCrutchfield - Peaceful Video Game Loop" ofType:@"mp3"]];
    loopSong = [[AVAudioPlayer alloc]initWithContentsOfURL:soundPath error:NULL];
    [loopSong setDelegate:nil];
    [loopSong prepareToPlay];
    loopSong.numberOfLoops = -1;    
}

- (void)playSoundEffect:(NSInteger)sound
{
    if([[[NSUserDefaults standardUserDefaults] objectForKey:@"sounds"] isEqualToString:@"yes"])
    {
        if(sound == 1)
        {
            [buttonTap play];
        }
        else if(sound == 2)
        {
            [initialSound play];
        }
        else if(sound == 3)
        {
            [sparkleSound stop];
            [sparkleSound setCurrentTime:0.0];
            [sparkleSound play];
        }
        else if(sound == 4)
        {
            [finalSound setCurrentTime:0.0];
            [finalSound play];
        }
        else if(sound == 5)
        {
            [loopSong play];
        }
    }
}

- (void)stopSoundEffect:(NSInteger)sound
{
    if(sound == 4)
    {
        [finalSound stop];
    }
    else if(sound == 5)
    {
        [loopSong stop];
    }
}

#pragma mark - General

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [self initializeLocked];
    [self prepareSoundEffects];
    
    fromLastPage = YES;
    firstTime = YES;
    
    [RevMobAds startSessionWithAppID:REVMOB_ID];

    
    if(![[[NSUserDefaults standardUserDefaults] objectForKey:@"sounds"] isEqualToString:@"no"])
    {
        [[NSUserDefaults standardUserDefaults] setObject:@"yes" forKey:@"sounds"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
    if([[NSUserDefaults standardUserDefaults] objectForKey:@"timesFinished"] == nil)
    {
        [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"timesFinished"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationNone];
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    self.window.backgroundColor = [UIColor whiteColor];
    
    MenuViewController *menuViewController = [[MenuViewController alloc] init];
    
    self.navigationController = [[[UINavigationController alloc] initWithRootViewController:menuViewController] autorelease];
    self.navigationController.navigationBarHidden = YES;
    
    NSString *deviceType = [UIDevice currentDevice].systemVersion;
    int ios = [[[deviceType componentsSeparatedByString:@"."] objectAtIndex:0] intValue];
    
    [self.navigationController setNavigationBarHidden:YES];
    if(ios < 6)
        [self.window addSubview:self.navigationController.view];
    else
        [self.window setRootViewController:self.navigationController];
    
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    if(nailsLocked == YES)
        [[NSNotificationCenter defaultCenter] postNotificationName:@"circle" object:nil];
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    [Chartboost startWithAppId:CHARTBOOST_ID
                  appSignature:CHARTBOOST_SIGNATURE
                      delegate:self];
    
    [Chartboost showInterstitial:CBLocationHomeScreen];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (NSUInteger)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window
{
    return UIInterfaceOrientationMaskPortrait;
    //    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    //        return UIInterfaceOrientationMaskAll;
    //    else  /* iphone */
    //        return UIInterfaceOrientationMaskAllButUpsideDown;
}

@end
