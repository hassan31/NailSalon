//
//  MenuViewController.m
//  NailSalon
//
//  Created by Alexandra Smau on 5/7/13.
//  Copyright (c) 2013 Newrosoft. All rights reserved.
//

#import "MenuViewController.h"
#import "NailDecorateViewController.h"
#import "AppDelegate.h"
#import "MoreViewController.h"
#import "AlbumViewController.h"
#import "PrivacyPolicy.h"
#import <Chartboost/Chartboost.h>

@implementation MenuViewController

- (id)init
{
    if([[UIScreen mainScreen] bounds].size.height == 568)
        self = [super initWithNibName:@"MenuViewController-5" bundle:[NSBundle mainBundle]];
    else
        self = [super init];
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(startAnimating) name:@"circle" object:nil];
    if([(AppDelegate*)[[UIApplication sharedApplication] delegate] fromLastPage] == YES)
    {
        [(AppDelegate*)[[UIApplication sharedApplication] delegate] showFullScreenAd];
        [(AppDelegate*)[[UIApplication sharedApplication] delegate] showChartboostAd];
        
        ((AppDelegate*)[[UIApplication sharedApplication] delegate]).fromLastPage = NO;
    }
    
    if([(AppDelegate*)[[UIApplication sharedApplication] delegate] nailsLocked] == NO)
    {
        //storeButton.hidden = YES;
        //restoreButton.hidden = YES;
    }
    
    if([(AppDelegate*)[[UIApplication sharedApplication] delegate] firstTime] == YES)
    {
        [(AppDelegate*)[[UIApplication sharedApplication] delegate] playSoundEffect:2];
        //        stars = [[Star alloc] initWithFrame:[UIScreen mainScreen].bounds];
        //        [self.view addSubview:stars];
        //        [stars decayOverTime:2.0];
        
        ((AppDelegate*)[[UIApplication sharedApplication] delegate]).firstTime = NO;
    }
    
    CABasicAnimation *rotation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    rotation.fromValue = [NSNumber numberWithFloat:0];
    rotation.toValue = [NSNumber numberWithFloat:(2*M_PI)];
    rotation.duration = 2.5; // Speed
    rotation.repeatCount = HUGE_VALF; // Repeat forever. Can be a finite number.
    [unlockSparkle.layer addAnimation:rotation forKey:@"Spin"];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)startAnimating
{
    CABasicAnimation *rotation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    rotation.fromValue = [NSNumber numberWithFloat:0];
    rotation.toValue = [NSNumber numberWithFloat:(2*M_PI)];
    rotation.duration = 2.5; // Speed
    rotation.repeatCount = HUGE_VALF; // Repeat forever. Can be a finite number.
    [unlockSparkle.layer addAnimation:rotation forKey:@"Spin"];
}

#pragma mark - IBAction

- (IBAction)play:(id)sender
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    [(AppDelegate*)[[UIApplication sharedApplication] delegate] playSoundEffect:1];
    NailDecorateViewController *nail = [[NailDecorateViewController alloc] init];
    [self.navigationController pushViewController:nail animated:YES];
    [nail release];
}

- (IBAction)PrivacyPolicy:(id)sender
{
    [(AppDelegate*)[[UIApplication sharedApplication] delegate] playSoundEffect:1];
    PrivacyPolicy *privacy = [[PrivacyPolicy alloc] init];
    [self presentViewController:privacy animated:YES completion:nil];
}

- (IBAction)storeClick:(id)sender
{
    if([((AppDelegate *)[[UIApplication sharedApplication] delegate]) nailsLocked] == YES)
    {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(14 + 2  + 56 , 6, 56, 48)];
        button.tag = 6;
        
        [((AppDelegate *)[[UIApplication sharedApplication] delegate]).store productClick:button];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"You've already purchased everything!" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
        [alert release];
    }
}

- (IBAction)moreClick:(id)sender
{
    [(AppDelegate*)[[UIApplication sharedApplication] delegate] playSoundEffect:1];
    [Chartboost showMoreApps:CBLocationDefault];
    
//    //Parental Control
//    nr1 = arc4random() % 5 + 4;
//    nr2 = arc4random() % 5 + 4;
//    
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:[NSString stringWithFormat:@"%d x %d = ?", nr1, nr2] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:@"Cancel", nil];
//    alert.tag = 13;
//    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
//    [alert textFieldAtIndex:0].keyboardType = UIKeyboardTypeNumberPad;
//    [alert show];
//    [alert release];
}

- (IBAction)photoAlbum:(id)sender
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [(AppDelegate*)[[UIApplication sharedApplication] delegate] playSoundEffect:1];
    AlbumViewController *album = [[AlbumViewController alloc] init];
    [self.navigationController pushViewController:album animated:YES];
    [album release];
}

- (IBAction)restoreClick:(id)sender
{
    [((AppDelegate *)[[UIApplication sharedApplication] delegate]).store restoreTransactions:nil];
}

#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 0)
    {
        if([[alertView textFieldAtIndex:0].text isEqualToString:[NSString stringWithFormat:@"%d", nr1 * nr2]])
        {
            [Chartboost showMoreApps:CBLocationDefault];
//            [[NSNotificationCenter defaultCenter] removeObserver:self];
//            
//            MoreViewController *moreScreen = [[MoreViewController alloc] init];
//            [UIView transitionWithView:self.navigationController.view duration:1.0 options:UIViewAnimationOptionTransitionCurlDown animations:^
//             {
//                 [self.navigationController pushViewController:moreScreen animated:NO];
//             } completion:nil];
//            
//            [moreScreen release];
        }
    }
}

@end
