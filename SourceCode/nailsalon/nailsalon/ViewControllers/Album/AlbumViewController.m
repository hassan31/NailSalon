//
//  AlbumViewController.m
//  NailSalon
//
//  Created by Alexandra Smau on 5/10/13.
//  Copyright (c) 2013 Newrosoft. All rights reserved.
//

#import "AlbumViewController.h"
#import "NailFinalViewController.h"
#import "AppDelegate.h"

@implementation AlbumViewController

- (id)init
{
    if([[UIScreen mainScreen] bounds].size.height == 568)
        self = [super initWithNibName:@"AlbumViewController-5" bundle:[NSBundle mainBundle]];
    else
        self = [super init];
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if([[NSUserDefaults standardUserDefaults] objectForKey:@"alex_fairies"] != nil)
    {
        alex_fairies = [NSKeyedUnarchiver unarchiveObjectWithData:[[NSUserDefaults standardUserDefaults] objectForKey:@"alex_fairies"]];
        [alex_fairies retain];
    }
    else
        alex_fairies = [[NSMutableArray alloc] init];
    
    scroll.scrollEnabled = YES;
    scroll.contentSize = CGSizeMake([alex_fairies count] * [[UIScreen mainScreen] bounds].size.width, scroll.frame.size.height);
    scroll.alwaysBounceHorizontal = YES;
    scroll.bounces = YES;
    scroll.pagingEnabled = YES;
    
    int j = 0;
    for(int i = [alex_fairies count] - 1; i >= 0; i--)
    {
        UIImageView *paper = [[UIImageView alloc] initWithFrame:CGRectMake(j * [[UIScreen mainScreen] bounds].size.width + 20, 71, 280, 409)];
        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
            paper.frame = CGRectMake(j * [[UIScreen mainScreen] bounds].size.width + 20, 115, 728, 911);
        else if([UIScreen mainScreen].bounds.size.height == 568)
            paper.frame = CGRectMake(j * [[UIScreen mainScreen] bounds].size.width + 13, 78, 295, 492);
        
        paper.image = [UIImage imageNamed:@"photo.png"];
        [scroll addSubview:paper];
        [paper release];
        
        UIButton *imgView = [[UIButton alloc] initWithFrame:CGRectMake(j * [[UIScreen mainScreen] bounds].size.width, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height)];
        
        UIImage *img = [[UIImage alloc] initWithContentsOfFile:[[alex_fairies objectAtIndex:i] objectForKey:@"path"]];
        [imgView setBackgroundImage:img forState:UIControlStateNormal];
        [imgView addTarget:self action:@selector(goToFinal:) forControlEvents:UIControlEventTouchUpInside];
        imgView.tag = i;
        [scroll addSubview:imgView];
        [imgView release];
        
        j++;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //set initial frames
    if([UIScreen mainScreen].bounds.size.height == 480)
    {
        arrowLeft.frame = CGRectMake(10, 228, 49, 24);
        arrowRight.frame = CGRectMake(262, 228, 49, 24);
    }
    else if([UIScreen mainScreen].bounds.size.height == 568)
    {
        arrowLeft.frame = CGRectMake(10, 272, 49, 24);
        arrowRight.frame = CGRectMake(262, 272, 49, 24);
    }
    else if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        arrowLeft.frame = CGRectMake(20, 482, 120, 59);
        arrowRight.frame = CGRectMake(628, 482, 120, 59);
    }
    arrowLeft.alpha = 1.0;
    arrowRight.alpha = 1.0;
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    //animate arrows
    [UIView animateWithDuration:0.7 delay:0.0 options:UIViewAnimationOptionRepeat | UIViewAnimationOptionCurveLinear |UIViewAnimationOptionAutoreverse animations:^
     {
         arrowLeft.frame = CGRectMake(arrowLeft.frame.origin.x - 4, arrowLeft.frame.origin.y - 2, arrowLeft.frame.size.width + 8, arrowLeft.frame.size.height + 4);
         arrowRight.frame = CGRectMake(arrowRight.frame.origin.x - 4, arrowRight.frame.origin.y - 2, arrowRight.frame.size.width + 8, arrowRight.frame.size.height + 4);
     } completion:nil];
    
    //remove after 4 seconds
    [self performSelector:@selector(arrowsDissappear) withObject:nil afterDelay:3.5];
}

- (void)arrowsDissappear
{
    [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^
     {
         arrowLeft.alpha = 0;
         arrowRight.alpha = 0;
     }
     completion:nil];
}

- (IBAction)backClick:(id)sender
{
    [((AppDelegate *)[[UIApplication sharedApplication] delegate]) playSoundEffect:1];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)goToFinal:(UIButton*)sender
{
    int nail1ColorNr;
    int nail1GlossNr;
    int nail1PatternNr;
    int nail1TipNr;
    int nail2ColorNr;
    int nail2GlossNr;
    int nail2PatternNr;
    int nail2TipNr;
    int nail3ColorNr;
    int nail3GlossNr;
    int nail3PatternNr;
    int nail3TipNr;
    int nail4ColorNr;
    int nail4GlossNr;
    int nail4PatternNr;
    int nail4TipNr;
    int nail5ColorNr;
    int nail5GlossNr;
    int nail5PatternNr;
    int nail5TipNr;
    int hand;
    int background;
    
    NSMutableArray *extras1Array;
    NSMutableArray *extras2Array;
    NSMutableArray *extras3Array;
    NSMutableArray *extras4Array;
    NSMutableArray *extras5Array;
    
    for(int i = 0; i < [alex_fairies count]; i++)
    {
        if(sender.tag == i)
        {
            nail1ColorNr = [[[alex_fairies objectAtIndex:i] objectForKey:@"nail1ColorNr"] intValue];
            nail1GlossNr = [[[alex_fairies objectAtIndex:i] objectForKey:@"nail1GlossNr"] intValue];
            nail1PatternNr = [[[alex_fairies objectAtIndex:i] objectForKey:@"nail1PatternNr"] intValue];
            nail1TipNr = [[[alex_fairies objectAtIndex:i] objectForKey:@"nail1TipNr"] intValue];
            nail2ColorNr = [[[alex_fairies objectAtIndex:i] objectForKey:@"nail2ColorNr"] intValue];
            nail2GlossNr = [[[alex_fairies objectAtIndex:i] objectForKey:@"nail2GlossNr"] intValue];
            nail2PatternNr = [[[alex_fairies objectAtIndex:i] objectForKey:@"nail2PatternNr"] intValue];
            nail2TipNr = [[[alex_fairies objectAtIndex:i] objectForKey:@"nail2TipNr"] intValue];
            nail3ColorNr = [[[alex_fairies objectAtIndex:i] objectForKey:@"nail3ColorNr"] intValue];
            nail3GlossNr = [[[alex_fairies objectAtIndex:i] objectForKey:@"nail3GlossNr"] intValue];
            nail3PatternNr = [[[alex_fairies objectAtIndex:i] objectForKey:@"nail3PatternNr"] intValue];
            nail3TipNr = [[[alex_fairies objectAtIndex:i] objectForKey:@"nail3TipNr"] intValue];
            nail4ColorNr = [[[alex_fairies objectAtIndex:i] objectForKey:@"nail4ColorNr"] intValue];
            nail4GlossNr = [[[alex_fairies objectAtIndex:i] objectForKey:@"nail4GlossNr"] intValue];
            nail4PatternNr = [[[alex_fairies objectAtIndex:i] objectForKey:@"nail4PatternNr"] intValue];
            nail4TipNr = [[[alex_fairies objectAtIndex:i] objectForKey:@"nail4TipNr"] intValue];
            nail5ColorNr = [[[alex_fairies objectAtIndex:i] objectForKey:@"nail5ColorNr"] intValue];
            nail5GlossNr = [[[alex_fairies objectAtIndex:i] objectForKey:@"nail5GlossNr"] intValue];
            nail5PatternNr = [[[alex_fairies objectAtIndex:i] objectForKey:@"nail5PatternNr"] intValue];
            nail5TipNr = [[[alex_fairies objectAtIndex:i] objectForKey:@"nail5TipNr"] intValue];
            background = [[[alex_fairies objectAtIndex:i] objectForKey:@"background"] intValue];
            hand = [[[alex_fairies objectAtIndex:i] objectForKey:@"hand"] intValue];
            extras1Array = [[alex_fairies objectAtIndex:i] objectForKey:@"extras1Array"];
            extras2Array = [[alex_fairies objectAtIndex:i] objectForKey:@"extras2Array"];
            extras3Array = [[alex_fairies objectAtIndex:i] objectForKey:@"extras3Array"];
            extras4Array = [[alex_fairies objectAtIndex:i] objectForKey:@"extras4Array"];
            extras5Array = [[alex_fairies objectAtIndex:i] objectForKey:@"extras5Array"];
        }
    }
    
    [((AppDelegate*)[[UIApplication sharedApplication] delegate]) playSoundEffect:1];
    NailFinalViewController *nailFinal = [[NailFinalViewController alloc] init];
    nailFinal.fromFridge = YES;
    nailFinal.nail1ColorNr = nail1ColorNr;
    nailFinal.nail1GlossNr = nail1GlossNr;
    nailFinal.nail1PatternNr = nail1PatternNr;
    nailFinal.nail1TipNr = nail1TipNr;
    nailFinal.nail2ColorNr = nail2ColorNr;
    nailFinal.nail2GlossNr = nail2GlossNr;
    nailFinal.nail2PatternNr = nail2PatternNr;
    nailFinal.nail2TipNr = nail2TipNr;
    nailFinal.nail3ColorNr = nail3ColorNr;
    nailFinal.nail3GlossNr = nail3GlossNr;
    nailFinal.nail3PatternNr = nail3PatternNr;
    nailFinal.nail3TipNr = nail3TipNr;
    nailFinal.nail4ColorNr = nail4ColorNr;
    nailFinal.nail4GlossNr = nail4GlossNr;
    nailFinal.nail4PatternNr = nail4PatternNr;
    nailFinal.nail4TipNr = nail4TipNr;
    nailFinal.nail5ColorNr = nail5ColorNr;
    nailFinal.nail5GlossNr = nail5GlossNr;
    nailFinal.nail5PatternNr = nail5PatternNr;
    nailFinal.nail5TipNr = nail5TipNr;
    nailFinal.hand = hand;
    nailFinal.background = background;
    nailFinal.extras1Array = extras1Array;
    nailFinal.extras2Array = extras2Array;
    nailFinal.extras3Array = extras3Array;
    nailFinal.extras4Array = extras4Array;
    nailFinal.extras5Array = extras5Array;
    [self.navigationController pushViewController:nailFinal animated:YES];
    [nailFinal release];
}

#pragma mark - Dealloc

- (void)dealloc
{
    [scroll release];
    [arrowLeft release];
    [arrowRight release];
    [alex_fairies release];
    
    [super dealloc];
}


@end
