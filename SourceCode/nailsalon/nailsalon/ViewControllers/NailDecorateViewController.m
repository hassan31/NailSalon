//
//  NailDecorateViewController.m
//  NailSalon
//
//  Created by Alexandra Smau on 5/7/13.
//  Copyright (c) 2013 Newrosoft. All rights reserved.
//

#import "NailDecorateViewController.h"
#import "NailFinalViewController.h"
#import "AppDelegate.h"
#import <QuartzCore/QuartzCore.h>

#import "ICMMenuViewCotrnoller.h"

@implementation NailDecorateViewController

- (id)init
{
    if([[UIScreen mainScreen] bounds].size.height == 568)
        self = [super initWithNibName:@"NailDecorateViewController-5" bundle:[NSBundle mainBundle]];
    else
        self = [super init];
    
    return self;
}

- (void)gobackToMainVC:(NSNotification *)notification {
    
    NSDictionary *dict = [notification userInfo];
    
    UIImage *render_image = (UIImage *)[dict valueForKey:@"render_image"];
    
    singleTip.image = render_image;
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(gobackToMainVC:) name:@"gobackToMainVC" object:nil];
    
    isImageSelectedFromGallery = false;
    
    nailSelected = 0;
    nail1ColorNr = 1;
    nail2ColorNr = 1;
    nail3ColorNr = 1;
    nail4ColorNr = 1;
    nail5ColorNr = 1;
    hand = 1;
    background = 1;
    
    if([((AppDelegate *)[[UIApplication sharedApplication] delegate]) nailsLocked] == NO)
    {
        [unlockSparkle1 removeFromSuperview];
        [unlockSparkle2 removeFromSuperview];
        [unlockEv1 removeFromSuperview];
        [unlockEv2 removeFromSuperview];
    }
    
    CGAffineTransform transform = CGAffineTransformMakeRotation(-0.26);
    nail1View.transform = transform;

    transform = CGAffineTransformMakeRotation(-0.12);
    nail2View.transform = transform;
    
    transform = CGAffineTransformMakeRotation(+0.9);
    nail5View.transform = transform;
    
    greyImgView.layer.cornerRadius = 8;

    extras1Array = [[NSMutableArray alloc] init];
    extras2Array = [[NSMutableArray alloc] init];
    extras3Array = [[NSMutableArray alloc] init];
    extras4Array = [[NSMutableArray alloc] init];
    extras5Array = [[NSMutableArray alloc] init];
    extras6Array = [[NSMutableArray alloc] init];
    
    changes1 = [[NSMutableArray alloc] init];
    changes2 = [[NSMutableArray alloc] init];
    changes3 = [[NSMutableArray alloc] init];
    changes4 = [[NSMutableArray alloc] init];
    changes5 = [[NSMutableArray alloc] init];
    changes6 = [[NSMutableArray alloc] init];

    [self addMaskToHoleView];
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        menuScroll.contentSize = CGSizeMake(885, menuScroll.frame.size.height);
        
    } else {
        
        menuScroll.contentSize = CGSizeMake(490, menuScroll.frame.size.height);
        
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [(AppDelegate*)[[UIApplication sharedApplication] delegate] playSoundEffect:5];
    lastAccessory = -1;
    
    if([((AppDelegate *)[[UIApplication sharedApplication] delegate]) nailsLocked] == YES)
    {
        CABasicAnimation *rotation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
        rotation.fromValue = [NSNumber numberWithFloat:0];
        rotation.toValue = [NSNumber numberWithFloat:(2*M_PI)];
        rotation.duration = 0.8; // Speed
        rotation.repeatCount = HUGE_VALF; // Repeat forever. Can be a finite number.
        [unlockSparkle1.layer addAnimation:rotation forKey:@"Spin"];
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadScroll) name:@"update" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(startAnimating) name:@"circle" object:nil];
    [((AppDelegate *)[[UIApplication sharedApplication] delegate]) showPopupAd];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
}

#pragma mark - IBAction

- (void)cancelClick:(UIButton*)sender
{
    if(sender.tag == 0)
    {
        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
            singleColor.image = [UIImage imageNamed:@"nailC1@2x.png"];
        else
            singleColor.image = [UIImage imageNamed:@"nailC1.png"];
        
        if(nailSelected == 1)
        {
            nail1ColorNr = 1;
            if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
                nail1Color.image = [UIImage imageNamed:[NSString stringWithFormat:@"smallnailC%d@2x.png", nail1ColorNr]];
            else
                nail1Color.image = [UIImage imageNamed:[NSString stringWithFormat:@"smallnailC%d.png", nail1ColorNr]];
            
            NSMutableDictionary *md2 = [[NSMutableDictionary alloc] init];
            [md2 setObject:@"color" forKey:@"type"];
            [md2 setObject:@"1" forKey:@"pic_nr"];
            [changes1 addObject:md2];
            [md2 release];
        }
        else if(nailSelected == 2)
        {
            nail2ColorNr = 1;
            if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
                nail2Color.image = [UIImage imageNamed:[NSString stringWithFormat:@"smallnailC%d@2x.png", nail2ColorNr]];
            else
                nail2Color.image = [UIImage imageNamed:[NSString stringWithFormat:@"smallnailC%d.png", nail2ColorNr]];
            
            NSMutableDictionary *md2 = [[NSMutableDictionary alloc] init];
            [md2 setObject:@"color" forKey:@"type"];
            [md2 setObject:@"1" forKey:@"pic_nr"];
            [changes2 addObject:md2];
            [md2 release];
        }
        else if(nailSelected == 3)
        {
            nail3ColorNr = 1;
            if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
                nail3Color.image = [UIImage imageNamed:[NSString stringWithFormat:@"smallnailC%d@2x.png", nail3ColorNr]];
            else
                nail3Color.image = [UIImage imageNamed:[NSString stringWithFormat:@"smallnailC%d.png", nail3ColorNr]];
            
            NSMutableDictionary *md2 = [[NSMutableDictionary alloc] init];
            [md2 setObject:@"color" forKey:@"type"];
            [md2 setObject:@"1" forKey:@"pic_nr"];
            [changes3 addObject:md2];
            [md2 release];
        }
        else if(nailSelected == 4)
        {
            nail4ColorNr = 1;
            if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
                nail4Color.image = [UIImage imageNamed:[NSString stringWithFormat:@"smallnailC%d@2x.png", nail4ColorNr]];
            else
                nail4Color.image = [UIImage imageNamed:[NSString stringWithFormat:@"smallnailC%d.png", nail4ColorNr]];
            
            NSMutableDictionary *md2 = [[NSMutableDictionary alloc] init];
            [md2 setObject:@"color" forKey:@"type"];
            [md2 setObject:@"1" forKey:@"pic_nr"];
            [changes4 addObject:md2];
            [md2 release];
        }
        else if(nailSelected == 5)
        {
            nail5ColorNr = 1;
            if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
                nail5Color.image = [UIImage imageNamed:[NSString stringWithFormat:@"smallnailC%d@2x.png", nail5ColorNr]];
            else
                nail5Color.image = [UIImage imageNamed:[NSString stringWithFormat:@"smallnailC%d.png", nail5ColorNr]];
            
            NSMutableDictionary *md2 = [[NSMutableDictionary alloc] init];
            [md2 setObject:@"color" forKey:@"type"];
            [md2 setObject:@"1" forKey:@"pic_nr"];
            [changes5 addObject:md2];
            [md2 release];
        }
    }
    else if(sender.tag == 1)
    {
        singleGloss.image = nil;
        
        if(nailSelected == 1)
        {
            nail1GlossNr = 0;
            if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
                nail1Gloss.image = [UIImage imageNamed:[NSString stringWithFormat:@"smallnailG%d@2x.png", nail1GlossNr]];
            else
                nail1Gloss.image = [UIImage imageNamed:[NSString stringWithFormat:@"smallnailG%d.png", nail1GlossNr]];
            
            NSMutableDictionary *md1 = [[NSMutableDictionary alloc] initWithDictionary:[changes1 lastObject]];
            
            if(!([[md1 objectForKey:@"type"] isEqualToString:@"gloss"] && [[md1 objectForKey:@"pic_nr"] isEqualToString:@"0"]))
            {
                NSMutableDictionary *md2 = [[NSMutableDictionary alloc] init];
                [md2 setObject:@"gloss" forKey:@"type"];
                [md2 setObject:@"0" forKey:@"pic_nr"];
                [changes1 addObject:md2];
                [md2 release];
            }
        }
        else if(nailSelected == 2)
        {
            nail2GlossNr = 0;
            if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
                nail2Gloss.image = [UIImage imageNamed:[NSString stringWithFormat:@"smallnailG%d@2x.png", nail2GlossNr]];
            else
                nail2Gloss.image = [UIImage imageNamed:[NSString stringWithFormat:@"smallnailG%d.png", nail2GlossNr]];
            
            NSMutableDictionary *md1 = [[NSMutableDictionary alloc] initWithDictionary:[changes2 lastObject]];
            
            if(!([[md1 objectForKey:@"type"] isEqualToString:@"gloss"] && [[md1 objectForKey:@"pic_nr"] isEqualToString:@"0"]))
            {
                NSMutableDictionary *md2 = [[NSMutableDictionary alloc] init];
                [md2 setObject:@"gloss" forKey:@"type"];
                [md2 setObject:@"0" forKey:@"pic_nr"];
                [changes2 addObject:md2];
                [md2 release];
            }
        }
        else if(nailSelected == 3)
        {
            nail3GlossNr = 0;
            if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
                nail3Gloss.image = [UIImage imageNamed:[NSString stringWithFormat:@"smallnailG%d@2x.png", nail3GlossNr]];
            else
                nail3Gloss.image = [UIImage imageNamed:[NSString stringWithFormat:@"smallnailG%d.png", nail3GlossNr]];
            
            NSMutableDictionary *md1 = [[NSMutableDictionary alloc] initWithDictionary:[changes3 lastObject]];
            
            if(!([[md1 objectForKey:@"type"] isEqualToString:@"gloss"] && [[md1 objectForKey:@"pic_nr"] isEqualToString:@"0"]))
            {
                NSMutableDictionary *md2 = [[NSMutableDictionary alloc] init];
                [md2 setObject:@"gloss" forKey:@"type"];
                [md2 setObject:@"0" forKey:@"pic_nr"];
                [changes3 addObject:md2];
                [md2 release];
            }
        }
        else if(nailSelected == 4)
        {
            nail4GlossNr = 0;
            if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
                nail4Gloss.image = [UIImage imageNamed:[NSString stringWithFormat:@"smallnailG%d@2x.png", nail4GlossNr]];
            else
                nail4Gloss.image = [UIImage imageNamed:[NSString stringWithFormat:@"smallnailG%d.png", nail4GlossNr]];
            
            NSMutableDictionary *md1 = [[NSMutableDictionary alloc] initWithDictionary:[changes4 lastObject]];
            
            if(!([[md1 objectForKey:@"type"] isEqualToString:@"gloss"] && [[md1 objectForKey:@"pic_nr"] isEqualToString:@"0"]))
            {
                NSMutableDictionary *md2 = [[NSMutableDictionary alloc] init];
                [md2 setObject:@"gloss" forKey:@"type"];
                [md2 setObject:@"0" forKey:@"pic_nr"];
                [changes4 addObject:md2];
                [md2 release];
            }
        }
        else if(nailSelected == 5)
        {
            nail5GlossNr = 0;
            if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
                nail5Gloss.image = [UIImage imageNamed:[NSString stringWithFormat:@"smallnailG%d@2x.png", nail5GlossNr]];
            else
                nail5Gloss.image = [UIImage imageNamed:[NSString stringWithFormat:@"smallnailG%d.png", nail5GlossNr]];
            
            NSMutableDictionary *md1 = [[NSMutableDictionary alloc] initWithDictionary:[changes5 lastObject]];
            
            if(!([[md1 objectForKey:@"type"] isEqualToString:@"gloss"] && [[md1 objectForKey:@"pic_nr"] isEqualToString:@"0"]))
            {
                NSMutableDictionary *md2 = [[NSMutableDictionary alloc] init];
                [md2 setObject:@"gloss" forKey:@"type"];
                [md2 setObject:@"0" forKey:@"pic_nr"];
                [changes5 addObject:md2];
                [md2 release];
            }
        }
    }
    else if(sender.tag == 2)
    {
        singlePattern.image = nil;
        
        if(nailSelected == 1)
        {
            nail1PatternNr = 0;
            if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
                nail1Pattern.image = [UIImage imageNamed:[NSString stringWithFormat:@"smallnailP%d@2x.png",nail1PatternNr]];
            else
                nail1Pattern.image = [UIImage imageNamed:[NSString stringWithFormat:@"smallnailP%d.png",nail1PatternNr]];
            
            NSMutableDictionary *md2 = [[NSMutableDictionary alloc] init];
            [md2 setObject:@"pattern" forKey:@"type"];
            [md2 setObject:@"0" forKey:@"pic_nr"];
            [changes1 addObject:md2];
            [md2 release];
        }
        else if(nailSelected == 2)
        {
            nail2PatternNr = 0;
            if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
                nail2Pattern.image = [UIImage imageNamed:[NSString stringWithFormat:@"smallnailP%d@2x.png",nail2PatternNr]];
            else
                nail2Pattern.image = [UIImage imageNamed:[NSString stringWithFormat:@"smallnailP%d.png", nail2PatternNr]];
            
            NSMutableDictionary *md2 = [[NSMutableDictionary alloc] init];
            [md2 setObject:@"pattern" forKey:@"type"];
            [md2 setObject:@"0" forKey:@"pic_nr"];
            [changes2 addObject:md2];
            [md2 release];
        }
        else if(nailSelected == 3)
        {
            nail3PatternNr = 0;
            if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
                nail3Pattern.image = [UIImage imageNamed:[NSString stringWithFormat:@"smallnailP%d@2x.png",nail3PatternNr]];
            else
                nail3Pattern.image = [UIImage imageNamed:[NSString stringWithFormat:@"smallnailP%d.png", nail3PatternNr]];
            
            NSMutableDictionary *md2 = [[NSMutableDictionary alloc] init];
            [md2 setObject:@"pattern" forKey:@"type"];
            [md2 setObject:@"0" forKey:@"pic_nr"];
            [changes3 addObject:md2];
            [md2 release];
        }
        else if(nailSelected == 4)
        {
            nail4PatternNr = 0;
            if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
                nail4Pattern.image = [UIImage imageNamed:[NSString stringWithFormat:@"smallnailP%d@2x.png",nail4PatternNr]];
            else
                nail4Pattern.image = [UIImage imageNamed:[NSString stringWithFormat:@"smallnailP%d.png", nail4PatternNr]];
            
            NSMutableDictionary *md2 = [[NSMutableDictionary alloc] init];
            [md2 setObject:@"pattern" forKey:@"type"];
            [md2 setObject:@"0" forKey:@"pic_nr"];
            [changes4 addObject:md2];
            [md2 release];
        }
        else if(nailSelected == 5)
        {
            nail5PatternNr = 0;
            if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
                nail5Pattern.image = [UIImage imageNamed:[NSString stringWithFormat:@"smallnailP%d@2x.png",nail5PatternNr]];
            else
                nail5Pattern.image = [UIImage imageNamed:[NSString stringWithFormat:@"smallnailP%d.png", nail5PatternNr]];
            
            NSMutableDictionary *md2 = [[NSMutableDictionary alloc] init];
            [md2 setObject:@"pattern" forKey:@"type"];
            [md2 setObject:@"0" forKey:@"pic_nr"];
            [changes5 addObject:md2];
            [md2 release];
        }
    }
    else if(sender.tag == 3)
    {
        singleTip.image = nil;
        
        if(nailSelected == 1)
        {
            nail1TipNr = 0;
            if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
                nail1Tip.image = [UIImage imageNamed:[NSString stringWithFormat:@"smallnailT%d@2x.png",nail1TipNr]];
            else
                nail1Tip.image = [UIImage imageNamed:[NSString stringWithFormat:@"smallnailT%d.png",nail1TipNr]];
            
            NSMutableDictionary *md2 = [[NSMutableDictionary alloc] init];
            [md2 setObject:@"tip" forKey:@"type"];
            [md2 setObject:@"0" forKey:@"pic_nr"];
            [changes1 addObject:md2];
            [md2 release];

        }
        else if(nailSelected == 2)
        {
            nail2TipNr = 0;
            if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
                nail2Tip.image = [UIImage imageNamed:[NSString stringWithFormat:@"smallnailT%d@2x.png",nail2TipNr]];
            else
                nail2Tip.image = [UIImage imageNamed:[NSString stringWithFormat:@"smallnailT%d.png", nail2TipNr]];
            
            NSMutableDictionary *md2 = [[NSMutableDictionary alloc] init];
            [md2 setObject:@"tip" forKey:@"type"];
            [md2 setObject:@"0" forKey:@"pic_nr"];
            [changes2 addObject:md2];
            [md2 release];
        }
        else if(nailSelected == 3)
        {
            nail3TipNr = 0;
            if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
                nail3Tip.image = [UIImage imageNamed:[NSString stringWithFormat:@"smallnailT%d@2x.png",nail3TipNr]];
            else
                nail3Tip.image = [UIImage imageNamed:[NSString stringWithFormat:@"smallnailT%d.png", nail3TipNr]];
            
            NSMutableDictionary *md2 = [[NSMutableDictionary alloc] init];
            [md2 setObject:@"tip" forKey:@"type"];
            [md2 setObject:@"0" forKey:@"pic_nr"];
            [changes3 addObject:md2];
            [md2 release];
        }
        else if(nailSelected == 4)
        {
            nail4TipNr = 0;
            if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
                nail4Tip.image = [UIImage imageNamed:[NSString stringWithFormat:@"smallnailT%d@2x.png",nail4TipNr]];
            else
                nail4Tip.image = [UIImage imageNamed:[NSString stringWithFormat:@"smallnailT%d.png", nail4TipNr]];
            
            NSMutableDictionary *md2 = [[NSMutableDictionary alloc] init];
            [md2 setObject:@"tip" forKey:@"type"];
            [md2 setObject:@"0" forKey:@"pic_nr"];
            [changes4 addObject:md2];
            [md2 release];
        }
        else if(nailSelected == 5)
        {
            nail5TipNr = 0;
            if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
                nail5Tip.image = [UIImage imageNamed:[NSString stringWithFormat:@"smallnailT%d@2x.png",nail5TipNr]];
            else
                nail5Tip.image = [UIImage imageNamed:[NSString stringWithFormat:@"smallnailT%d.png", nail5TipNr]];
            
            NSMutableDictionary *md2 = [[NSMutableDictionary alloc] init];
            [md2 setObject:@"tip" forKey:@"type"];
            [md2 setObject:@"0" forKey:@"pic_nr"];
            [changes5 addObject:md2];
            [md2 release];
        }
    }
    else if(sender.tag == 4)
    {
        if(nailSelected == 1)
        {
            int index = -1;
            for(int i = [changes1 count] - 1; i >= 0 ; i--)
            {
                
                NSMutableDictionary *md = [changes1 objectAtIndex:i];
                
                if([[md objectForKey:@"type"] isEqualToString:@"extras"])
                {
                    for(UIView *view in [singleTip subviews])
                    {
                        if(view.tag > 0 && view.tag == [extras1Array count])
                        {
                            [view removeFromSuperview];
                        }
                    }
                    [extras1Array removeLastObject];
                    index = i;
                    break;
                }
            }
            if(index != -1)
                [changes1 removeObjectAtIndex:index];
        }
        else if(nailSelected == 2)
        {
            int index = -1;
            for(int i = [changes2 count] - 1; i >= 0 ; i--)
            {
                NSMutableDictionary *md = [changes2 objectAtIndex:i];
                
                if([[md objectForKey:@"type"] isEqualToString:@"extras"])
                {
                    for(UIView *view in [singleTip subviews])
                    {
                        if(view.tag > 0 && view.tag == [extras2Array count])
                        {
                            [view removeFromSuperview];
                        }
                    }
                    [extras2Array removeLastObject];
                    index = i;
                    break;
                }
            }
            if(index != -1)
                [changes2 removeObjectAtIndex:index];
        }
        else if(nailSelected == 3)
        {
            int index = -1;
            for(int i = [changes3 count] - 1; i >= 0 ; i--)
            {
                NSMutableDictionary *md = [changes3 objectAtIndex:i];
                
                if([[md objectForKey:@"type"] isEqualToString:@"extras"])
                {
                    for(UIView *view in [singleTip subviews])
                    {
                        if(view.tag > 0 && view.tag == [extras3Array count])
                        {
                            [view removeFromSuperview];
                        }
                    }
                    [extras3Array removeLastObject];
                    index = i;
                    break;
                }
            }
            if(index != -1)
                [changes3 removeObjectAtIndex:index];
        }
        else if(nailSelected == 4)
        {
            int index = -1;
            for(int i = [changes4 count] - 1; i >= 0 ; i--)
            {
                NSMutableDictionary *md = [changes4 objectAtIndex:i];
                
                if([[md objectForKey:@"type"] isEqualToString:@"extras"])
                {
                    for(UIView *view in [singleTip subviews])
                    {
                        if(view.tag > 0 && view.tag == [extras4Array count])
                        {
                            [view removeFromSuperview];
                        }
                    }
                    [extras4Array removeLastObject];
                    index = i;
                    break;
                }
            }
            if(index != -1)
                [changes4 removeObjectAtIndex:index];
        }
        else if(nailSelected == 5)
        {
            int index = -1;
            for(int i = [changes5 count] - 1; i >= 0 ; i--)
            {
                NSMutableDictionary *md = [changes5 objectAtIndex:i];
                
                if([[md objectForKey:@"type"] isEqualToString:@"extras"])
                {
                    for(UIView *view in [singleTip subviews])
                    {
                        if(view.tag > 0 && view.tag == [extras5Array count])
                        {
                            [view removeFromSuperview];
                        }
                    }
                    [extras5Array removeLastObject];
                    index = i;
                    break;
                }
            }
            if(index != -1)
                [changes5 removeObjectAtIndex:index];
        }
    }
    else if(sender.tag == 5)
    {
        hand = 1;
        handImgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"hand%d.png", hand]];
        fingerImgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"finger%d.png", hand]];
        
        if(nailSelected == 1)
        {
            NSMutableDictionary *md2 = [[NSMutableDictionary alloc] init];
            [md2 setObject:@"hand" forKey:@"type"];
            [md2 setObject:[NSString stringWithFormat:@"%d", hand] forKey:@"pic_nr"];
            [changes1 addObject:md2];
            [md2 release];
        }
        else if(nailSelected == 2)
        {
            NSMutableDictionary *md2 = [[NSMutableDictionary alloc] init];
            [md2 setObject:@"hand" forKey:@"type"];
            [md2 setObject:[NSString stringWithFormat:@"%d", hand] forKey:@"pic_nr"];
            [changes2 addObject:md2];
            [md2 release];
        }
        else if(nailSelected == 3)
        {
            NSMutableDictionary *md2 = [[NSMutableDictionary alloc] init];
            [md2 setObject:@"hand" forKey:@"type"];
            [md2 setObject:[NSString stringWithFormat:@"%d", hand] forKey:@"pic_nr"];
            [changes3 addObject:md2];
            [md2 release];
        }
        else if(nailSelected == 4)
        {
            NSMutableDictionary *md2 = [[NSMutableDictionary alloc] init];
            [md2 setObject:@"hand" forKey:@"type"];
            [md2 setObject:[NSString stringWithFormat:@"%d", hand] forKey:@"pic_nr"];
            [changes4 addObject:md2];
            [md2 release];
        }
        if(nailSelected == 5)
        {
            NSMutableDictionary *md2 = [[NSMutableDictionary alloc] init];
            [md2 setObject:@"hand" forKey:@"type"];
            [md2 setObject:[NSString stringWithFormat:@"%d", hand] forKey:@"pic_nr"];
            [changes5 addObject:md2];
            [md2 release];
        }
    }
    else if(sender.tag == 6)
    {
        background = 1;
        
        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        {
            backgroundImgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d~ipad.png", background]];
            background2ImgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d~ipad.png", background]];
        }
        else if([UIScreen mainScreen].bounds.size.height == 568)
        {
            backgroundImgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d_568.png", background]];
            background2ImgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d_568.png", background]];
        }
        else
        {
            backgroundImgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d.png", background]];
            background2ImgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d.png", background]];
        }

        if(nailSelected == 1)
        {
            NSMutableDictionary *md2 = [[NSMutableDictionary alloc] init];
            [md2 setObject:@"background" forKey:@"type"];
            [md2 setObject:[NSString stringWithFormat:@"%d", background] forKey:@"pic_nr"];
            [changes1 addObject:md2];
            [md2 release];
        }
        else if(nailSelected == 2)
        {
            NSMutableDictionary *md2 = [[NSMutableDictionary alloc] init];
            [md2 setObject:@"background" forKey:@"type"];
            [md2 setObject:[NSString stringWithFormat:@"%d", background] forKey:@"pic_nr"];
            [changes2 addObject:md2];
            [md2 release];
        }
        else if(nailSelected == 3)
        {
            NSMutableDictionary *md2 = [[NSMutableDictionary alloc] init];
            [md2 setObject:@"background" forKey:@"type"];
            [md2 setObject:[NSString stringWithFormat:@"%d", background] forKey:@"pic_nr"];
            [changes3 addObject:md2];
            [md2 release];
        }
        else if(nailSelected == 4)
        {
            NSMutableDictionary *md2 = [[NSMutableDictionary alloc] init];
            [md2 setObject:@"background" forKey:@"type"];
            [md2 setObject:[NSString stringWithFormat:@"%d", background] forKey:@"pic_nr"];
            [changes4 addObject:md2];
            [md2 release];
        }
        else if(nailSelected == 5)
        {
            NSMutableDictionary *md2 = [[NSMutableDictionary alloc] init];
            [md2 setObject:@"background" forKey:@"type"];
            [md2 setObject:[NSString stringWithFormat:@"%d", background] forKey:@"pic_nr"];
            [changes5 addObject:md2];
            [md2 release];
        }
    }
}

- (IBAction)menuChosen:(UIButton*)sender
{
    for(UIView *view in [secondScroll subviews])
        [view removeFromSuperview];
    
    [secondScroll setContentOffset:CGPointMake(0, 0)];
    secondScroll.frame = CGRectMake(secondScroll.frame.size.width, secondScroll.frame.origin.y, secondScroll.frame.size.width, secondScroll.frame.size.height);
    greyImgView.frame = secondScroll.frame;
    
    [(AppDelegate*)[[UIApplication sharedApplication] delegate] playSoundEffect:1];
    
    if(lastAccessory != sender.tag)
    {
        [sender setSelected:YES];
        
        for(UIButton *b in [menuScroll subviews])
        {
            if(b.tag != sender.tag)
                [b setSelected:NO];
        }
        
        secondScroll.hidden = NO;
        greyImgView.hidden = NO;
        scrollViewColorPicker.hidden = NO;
    }
    else
    {
        for(UIButton *b in [menuScroll subviews])
            [b setSelected:NO];
        
        secondScroll.hidden = YES;
        scrollViewColorPicker.hidden = YES;
        greyImgView.hidden = YES;
        
        lastAccessory = -1;
        return;
    }
    
    lastAccessory = sender.tag;

    if (sender.tag == 7) {
        
        [UIView animateWithDuration:0.7 animations:^{
            
            scrollViewColorPicker.frame = CGRectMake(0, scrollViewColorPicker.frame.origin.y, scrollViewColorPicker.frame.size.width, scrollViewColorPicker.frame.size.height);
            greyImgView.frame = scrollViewColorPicker.frame;

        }];
        
    } else {
        
        secondScroll.hidden = false;
        scrollViewColorPicker.hidden = true;
        
        if(sender.tag == 0)
        {
            for(int i = 0; i <= 20; i++)
            {
                if(i == 0)
                {
                    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(5 + 2 * i + 50 * i, 3, 50, 50)];
                    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
                        button.frame = CGRectMake(15 + 2 * i + 80 * i, 1, 65, 100);
                    
                    [button setImage:[UIImage imageNamed:@"cancel.png"] forState:UIControlStateNormal];
                    button.tag = sender.tag;
                    [button addTarget:self action:@selector(cancelClick:) forControlEvents:UIControlEventTouchUpInside];
                    [secondScroll addSubview:button];
                    [button release];
                }
                else
                {
                    if(i > 6 && [((AppDelegate *)[[UIApplication sharedApplication] delegate]) colorLocked] == YES)
                    {
                        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(5 + 2 * i + 50 * i, 3, 50, 50)];
                        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
                            button.frame = CGRectMake(15 + 2 * i + 80 * i, 1, 65, 100);
                        
                        button.tag = 1;
                        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
                            [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"smallnailC%d@2x.png", i]] forState:UIControlStateNormal];
                        else
                            [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"smallnailC%d.png", i]] forState:UIControlStateNormal];
                        [button addTarget:((AppDelegate *)[[UIApplication sharedApplication] delegate]).store action:@selector(productClick:) forControlEvents:UIControlEventTouchUpInside];
                        
                        UIImageView *locked = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 20, 25)];
                        locked.image = [UIImage imageNamed:@"lockSmall.png"];
                        [button addSubview:locked];
                        [locked release];
                        
                        
                        [secondScroll addSubview:button];
                        [button release];
                    }
                    else
                    {
                        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(5 + 2 * i + 50 * i, 3, 50, 50)];
                        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
                            button.frame = CGRectMake(15 + 2 * i + 80 * i, 1, 65, 100);
                        
                        button.tag = i;
                        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
                            [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"smallnailC%d@2x.png", i]] forState:UIControlStateNormal];
                        else
                            [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"smallnailC%d.png", i]] forState:UIControlStateNormal];
                        [button addTarget:self action:@selector(colorChosen:) forControlEvents:UIControlEventTouchUpInside];
                        [secondScroll addSubview:button];
                        [button release];
                    }
                }
            }
            if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
                secondScroll.contentSize = CGSizeMake(80 * 21 + 15 + 2 * 22 + 15, secondScroll.frame.size.height);
            else
                secondScroll.contentSize = CGSizeMake(50 * 21 + 5 + 2 * 22 + 5, secondScroll.frame.size.height);
            
        }
        else if(sender.tag == 1)
        {
            for(int i = 0; i <= 20; i++)
            {
                if(i == 0)
                {
                    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(5 + 2 * i + 50 * i, 3, 50, 50)];
                    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
                        button.frame = CGRectMake(15 + 2 * i + 80 * i, 1, 65, 100);
                    
                    [button setImage:[UIImage imageNamed:@"cancel.png"] forState:UIControlStateNormal];
                    button.tag = sender.tag;
                    [button addTarget:self action:@selector(cancelClick:) forControlEvents:UIControlEventTouchUpInside];
                    [secondScroll addSubview:button];
                    [button release];
                }
                else
                {
                    if(i > 6 && [((AppDelegate *)[[UIApplication sharedApplication] delegate]) glossLocked] == YES)
                    {
                        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(5 + 2 * i + 50 * i, 3, 50, 50)];
                        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
                            button.frame = CGRectMake(15 + 2 * i + 80 * i, 1, 65, 100);
                        
                        button.tag = 3;
                        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
                            [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"smallnailG%d@2x.png", i]] forState:UIControlStateNormal];
                        else
                            [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"smallnailG%d.png", i]] forState:UIControlStateNormal];
                        [button addTarget:((AppDelegate *)[[UIApplication sharedApplication] delegate]).store action:@selector(productClick:) forControlEvents:UIControlEventTouchUpInside];
                        
                        UIImageView *locked = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 20, 25)];
                        locked.image = [UIImage imageNamed:@"lockSmall.png"];
                        [button addSubview:locked];
                        [locked release];
                        
                        
                        [secondScroll addSubview:button];
                        [button release];
                    }
                    else
                    {
                        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(5 + 2 * i + 50 * i, 3, 50, 50)];
                        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
                            button.frame = CGRectMake(15 + 2 * i + 80 * i, 1, 65, 100);
                        
                        button.tag = i;
                        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
                            [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"smallnailG%d@2x.png", i]] forState:UIControlStateNormal];
                        else
                            [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"smallnailG%d.png", i]] forState:UIControlStateNormal];
                        [button addTarget:self action:@selector(glossChosen:) forControlEvents:UIControlEventTouchUpInside];
                        [secondScroll addSubview:button];
                        [button release];
                    }
                }
            }
            if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
                secondScroll.contentSize = CGSizeMake(80 * 21 + 15 + 2 * 22 + 15, secondScroll.frame.size.height);
            else
                secondScroll.contentSize = CGSizeMake(50 * 21 + 5 + 2 * 22 + 5, secondScroll.frame.size.height);
            
        }
        else if(sender.tag == 2)
        {
            for(int i = 0; i <= 20; i++)
            {
                if(i == 0)
                {
                    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(5 + 2 * i + 50 * i, 3, 50, 50)];
                    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
                        button.frame = CGRectMake(15 + 2 * i + 80 * i, 1, 65, 100);
                    
                    [button setImage:[UIImage imageNamed:@"cancel.png"] forState:UIControlStateNormal];
                    button.tag = sender.tag;
                    [button addTarget:self action:@selector(cancelClick:) forControlEvents:UIControlEventTouchUpInside];
                    [secondScroll addSubview:button];
                    [button release];
                }
                else
                {
                    if(i > 6 && [((AppDelegate *)[[UIApplication sharedApplication] delegate]) patternLocked] == YES)
                    {
                        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(5 + 2 * i + 50 * i, 3, 50, 50)];
                        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
                            button.frame = CGRectMake(15 + 2 * i + 80 * i, 1, 65, 100);
                        
                        button.tag = 4;
                        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
                            [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"smallnailP%d@2x.png", i]] forState:UIControlStateNormal];
                        else
                            [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"smallnailP%d.png", i]] forState:UIControlStateNormal];
                        [button addTarget:((AppDelegate *)[[UIApplication sharedApplication] delegate]).store action:@selector(productClick:) forControlEvents:UIControlEventTouchUpInside];
                        
                        UIImageView *locked = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 20, 25)];
                        locked.image = [UIImage imageNamed:@"lockSmall.png"];
                        [button addSubview:locked];
                        [locked release];
                        
                        
                        [secondScroll addSubview:button];
                        [button release];
                    }
                    else
                    {
                        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(5 + 2 * i + 50 * i, 3, 50, 50)];
                        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
                            button.frame = CGRectMake(15 + 2 * i + 80 * i, 1, 65, 100);
                        
                        button.tag = i;
                        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
                            [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"smallnailP%d@2x.png", i]] forState:UIControlStateNormal];
                        else
                            [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"smallnailP%d.png", i]] forState:UIControlStateNormal];
                        [button addTarget:self action:@selector(patternChosen:) forControlEvents:UIControlEventTouchUpInside];
                        [secondScroll addSubview:button];
                        [button release];
                    }
                }
            }
            if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
                secondScroll.contentSize = CGSizeMake(80 * 21 + 15 + 2 * 22 + 15, secondScroll.frame.size.height);
            else
                secondScroll.contentSize = CGSizeMake(50 * 21 + 5 + 2 * 22 + 5, secondScroll.frame.size.height);
            
        }
        else if(sender.tag == 3)
        {
            for(int i = 0; i <= 20; i++)
            {
                if(i == 0)
                {
                    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(5 + 2 * i + 50 * i, 3, 50, 50)];
                    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
                        button.frame = CGRectMake(15 + 2 * i + 80 * i, 1, 65, 100);
                    
                    [button setImage:[UIImage imageNamed:@"cancel.png"] forState:UIControlStateNormal];
                    button.tag = sender.tag;
                    [button addTarget:self action:@selector(cancelClick:) forControlEvents:UIControlEventTouchUpInside];
                    [secondScroll addSubview:button];
                    [button release];
                }
                else
                {
                    if(i > 6 && [((AppDelegate *)[[UIApplication sharedApplication] delegate]) tipLocked] == YES)
                    {
                        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(5 + 2 * i + 50 * i, 3, 50, 50)];
                        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
                            button.frame = CGRectMake(15 + 2 * i + 80 * i, 1, 65, 100);
                        
                        button.tag = 5;
                        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
                            [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"smallnailT%d@2x.png", i]] forState:UIControlStateNormal];
                        else
                            [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"smallnailT%d.png", i]] forState:UIControlStateNormal];
                        [button addTarget:((AppDelegate *)[[UIApplication sharedApplication] delegate]).store action:@selector(productClick:) forControlEvents:UIControlEventTouchUpInside];
                        
                        UIImageView *locked = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 20, 25)];
                        locked.image = [UIImage imageNamed:@"lockSmall.png"];
                        [button addSubview:locked];
                        [locked release];
                        
                        
                        [secondScroll addSubview:button];
                        [button release];
                    }
                    else
                    {
                        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(5 + 2 * i + 50 * i, 3, 50, 50)];
                        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
                            button.frame = CGRectMake(15 + 2 * i + 80 * i, 1, 65, 100);
                        
                        button.tag = i;
                        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
                            [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"smallnailT%d@2x.png", i]] forState:UIControlStateNormal];
                        else
                            [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"smallnailT%d.png", i]] forState:UIControlStateNormal];
                        [button addTarget:self action:@selector(tipChosen:) forControlEvents:UIControlEventTouchUpInside];
                        [secondScroll addSubview:button];
                        [button release];
                    }
                }
            }
            if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
                secondScroll.contentSize = CGSizeMake(80 * 21 + 15 + 2 * 22 + 15, secondScroll.frame.size.height);
            else
                secondScroll.contentSize = CGSizeMake(50 * 21 + 5 + 2 * 22 + 5, secondScroll.frame.size.height);
            
        }
        else if(sender.tag == 4)
        {
            for(int i = 0; i <= 21; i++)
            {
                if(i == 0)
                {
                    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(5 + 5 * i + 50 * i, 3, 50, 50)];
                    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
                        button.frame = CGRectMake(15 + 2 * i + 80 * i, 1, 65, 100);
                    
                    [button setImage:[UIImage imageNamed:@"cancel.png"] forState:UIControlStateNormal];
                    button.tag = sender.tag;
                    [button addTarget:self action:@selector(cancelClick:) forControlEvents:UIControlEventTouchUpInside];
                    [secondScroll addSubview:button];
                    [button release];
                }
                else
                {
                    if(i > 6 && [((AppDelegate *)[[UIApplication sharedApplication] delegate]) extrasLocked] == YES)
                    {
                        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(15 + 5 * i + 50 * i, 13, 30, 30)];
                        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
                            button.frame = CGRectMake(15 + 2 * i + 80 * i, 23, 65, 65);
                        
                        button.tag = 2;
                        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
                            [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"x%d@2x.png", i]] forState:UIControlStateNormal];
                        else
                            [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"x%d.png", i]] forState:UIControlStateNormal];
                        [button addTarget:((AppDelegate *)[[UIApplication sharedApplication] delegate]).store action:@selector(productClick:) forControlEvents:UIControlEventTouchUpInside];
                        
                        UIImageView *locked = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 20, 25)];
                        locked.image = [UIImage imageNamed:@"lockSmall.png"];
                        [button addSubview:locked];
                        [locked release];
                        
                        [secondScroll addSubview:button];
                        [button release];
                    }
                    else
                    {
                        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(15 + 5 * i + 50 * i, 13, 30, 30)];
                        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
                            button.frame = CGRectMake(15 + 2 * i + 80 * i, 23, 65, 65);
                        
                        button.tag = i;
                        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
                            [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"x%d@2x.png", i]] forState:UIControlStateNormal];
                        else
                            [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"x%d.png", i]] forState:UIControlStateNormal];
                        [button addTarget:self action:@selector(extrasChosen:) forControlEvents:UIControlEventTouchUpInside];
                        [secondScroll addSubview:button];
                        [button release];
                    }
                }
            }
            if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
                secondScroll.contentSize = CGSizeMake(80 * 22 + 15 + 2 * 23 + 15, secondScroll.frame.size.height);
            else
                secondScroll.contentSize = CGSizeMake(50 * 22 + 15 + 5 * 23, secondScroll.frame.size.height);
        }
        else if(sender.tag == 5)
        {
            for(int i = 0; i <= 4; i++)
            {
                if(i == 0)
                {
                    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(5 + 2 * i + 50 * i, 3, 50, 50)];
                    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
                        button.frame = CGRectMake(15 + 2 * i + 80 * i, 1, 80, 100);
                    
                    [button setImage:[UIImage imageNamed:@"cancel.png"] forState:UIControlStateNormal];
                    button.tag = sender.tag;
                    [button addTarget:self action:@selector(cancelClick:) forControlEvents:UIControlEventTouchUpInside];
                    [secondScroll addSubview:button];
                    [button release];
                }
                else
                {
                    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(5 + 2 * i + 50 * i, 3, 50, 50)];
                    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
                        button.frame = CGRectMake(15 + 2 * i + 80 * i, 1, 80, 100);
                    
                    button.tag = i;
                    [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"hand%d.png", i]] forState:UIControlStateNormal];
                    [button addTarget:self action:@selector(handChosen:) forControlEvents:UIControlEventTouchUpInside];
                    [secondScroll addSubview:button];
                    [button release];
                }
            }
            if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
                secondScroll.contentSize = CGSizeMake(90 * 5 + 15 + 2 * 6 + 15, secondScroll.frame.size.height);
            else
                secondScroll.contentSize = CGSizeMake(50 * 5 + 5 + 2 * 6 + 5, secondScroll.frame.size.height);
        }
        else if(sender.tag == 6)
        {
            for(int i = 0; i <= 10; i++)
            {
                if(i == 0)
                {
                    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(5 + 2 * i + 50 * i, 3, 50, 50)];
                    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
                        button.frame = CGRectMake(15 + 2 * i + 80 * i, 1, 65, 100);
                    
                    [button setImage:[UIImage imageNamed:@"cancel.png"] forState:UIControlStateNormal];
                    button.tag = sender.tag;
                    [button addTarget:self action:@selector(cancelClick:) forControlEvents:UIControlEventTouchUpInside];
                    [secondScroll addSubview:button];
                    [button release];
                }
                else
                {
                    if(i > 3 && [((AppDelegate *)[[UIApplication sharedApplication] delegate]) backgroundLocked] == YES)
                    {
                        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(5 + 2 * i + 50 * i, 3, 40, 50)];
                        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
                            button.frame = CGRectMake(15 + 2 * i + 90 * i, 1, 80, 100);
                        
                        button.tag = 0;
                        [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%d.png", i]] forState:UIControlStateNormal];
                        [button addTarget:((AppDelegate *)[[UIApplication sharedApplication] delegate]).store action:@selector(productClick:) forControlEvents:UIControlEventTouchUpInside];
                        
                        UIImageView *locked = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 20, 25)];
                        locked.image = [UIImage imageNamed:@"lockSmall.png"];
                        [button addSubview:locked];
                        [locked release];
                        
                        
                        [secondScroll addSubview:button];
                        [button release];
                    }
                    else
                    {
                        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(5 + 2 * i + 50 * i, 3, 40, 50)];
                        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
                            button.frame = CGRectMake(15 + 2 * i + 90 * i, 1, 80, 100);
                        
                        button.tag = i;
                        [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%d.png", i]] forState:UIControlStateNormal];
                        [button addTarget:self action:@selector(backgroundChosen:) forControlEvents:UIControlEventTouchUpInside];
                        [secondScroll addSubview:button];
                        [button release];
                    }
                }
            }
            if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
                secondScroll.contentSize = CGSizeMake(90 * 11 + 15 + 2 * 12 + 15, secondScroll.frame.size.height);
            else
                secondScroll.contentSize = CGSizeMake(50 * 11 + 5 + 2 * 12 + 5, secondScroll.frame.size.height);
        }
        
        [UIView animateWithDuration:0.7 animations:^{
            secondScroll.frame = CGRectMake(0, secondScroll.frame.origin.y, secondScroll.frame.size.width, secondScroll.frame.size.height);
            greyImgView.frame = secondScroll.frame;
        }];
        
    }
    
}

- (void)colorChosen:(UIButton*)sender
{
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        singleColor.image = [UIImage imageNamed:[NSString stringWithFormat:@"nailC%d@2x.png", sender.tag]];
    else
        singleColor.image = [UIImage imageNamed:[NSString stringWithFormat:@"nailC%d.png", sender.tag]];

    
    if(nailSelected == 1)
    {
        nail1ColorNr = sender.tag;
        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
            nail1Color.image = [UIImage imageNamed:[NSString stringWithFormat:@"smallnailC%d@2x.png", nail1ColorNr]];
        else
            nail1Color.image = [UIImage imageNamed:[NSString stringWithFormat:@"smallnailC%d.png", nail1ColorNr]];
        
        if(nail1GlossNr != 0)
        {
            nail1GlossNr = sender.tag;
            if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
            {
                nail1Gloss.image = [UIImage imageNamed:[NSString stringWithFormat:@"smallnailG%d@2x.png", nail1GlossNr]];
                singleGloss.image = [UIImage imageNamed:[NSString stringWithFormat:@"nailG%d@2x.png", sender.tag]];
            }
            else
            {
                nail1Gloss.image = [UIImage imageNamed:[NSString stringWithFormat:@"smallnailG%d.png", nail1GlossNr]];
                singleGloss.image = [UIImage imageNamed:[NSString stringWithFormat:@"nailG%d.png", sender.tag]];
            }
        }
        
        NSMutableDictionary *md2 = [[NSMutableDictionary alloc] init];
        [md2 setObject:@"color" forKey:@"type"];
        [md2 setObject:[NSString stringWithFormat:@"%d", sender.tag] forKey:@"pic_nr"];
        [changes1 addObject:md2];
        [md2 release];
    }
    else if(nailSelected == 2)
    {
        nail2ColorNr = sender.tag;
        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
            nail2Color.image = [UIImage imageNamed:[NSString stringWithFormat:@"smallnailC%d@2x.png", nail2ColorNr]];
        else
            nail2Color.image = [UIImage imageNamed:[NSString stringWithFormat:@"smallnailC%d.png", nail2ColorNr]];
        
        if(nail2GlossNr != 0)
        {
            nail2GlossNr = sender.tag;
            if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
            {
                nail2Gloss.image = [UIImage imageNamed:[NSString stringWithFormat:@"smallnailG%d@2x.png", nail2GlossNr]];
                singleGloss.image = [UIImage imageNamed:[NSString stringWithFormat:@"nailG%d@2x.png", sender.tag]];
            }
            else
            {
                nail2Gloss.image = [UIImage imageNamed:[NSString stringWithFormat:@"smallnailG%d.png", nail2GlossNr]];
                singleGloss.image = [UIImage imageNamed:[NSString stringWithFormat:@"nailG%d.png", sender.tag]];
            }
        }
        
        NSMutableDictionary *md2 = [[NSMutableDictionary alloc] init];
        [md2 setObject:@"color" forKey:@"type"];
        [md2 setObject:[NSString stringWithFormat:@"%d", sender.tag] forKey:@"pic_nr"];
        [changes2 addObject:md2];
        [md2 release];

    }
    else if(nailSelected == 3)
    {
        nail3ColorNr = sender.tag;
        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
            nail3Color.image = [UIImage imageNamed:[NSString stringWithFormat:@"smallnailC%d@2x.png", nail3ColorNr]];
        else
            nail3Color.image = [UIImage imageNamed:[NSString stringWithFormat:@"smallnailC%d.png", nail3ColorNr]];
        
        if(nail3GlossNr != 0)
        {
            nail3GlossNr = sender.tag;
            if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
            {
                nail3Gloss.image = [UIImage imageNamed:[NSString stringWithFormat:@"smallnailG%d@2x.png", nail3GlossNr]];
                singleGloss.image = [UIImage imageNamed:[NSString stringWithFormat:@"nailG%d@2x.png", sender.tag]];
            }
            else
            {
                nail3Gloss.image = [UIImage imageNamed:[NSString stringWithFormat:@"smallnailG%d.png", nail3GlossNr]];
                singleGloss.image = [UIImage imageNamed:[NSString stringWithFormat:@"nailG%d.png", sender.tag]];
            }
        }
        
        NSMutableDictionary *md2 = [[NSMutableDictionary alloc] init];
        [md2 setObject:@"color" forKey:@"type"];
        [md2 setObject:[NSString stringWithFormat:@"%d", sender.tag] forKey:@"pic_nr"];
        [changes3 addObject:md2];
        [md2 release];
    }
    else if(nailSelected == 4)
    {
        nail4ColorNr = sender.tag;
        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
            nail4Color.image = [UIImage imageNamed:[NSString stringWithFormat:@"smallnailC%d@2x.png", nail4ColorNr]];
        else
            nail4Color.image = [UIImage imageNamed:[NSString stringWithFormat:@"smallnailC%d.png", nail4ColorNr]];
        
        if(nail4GlossNr != 0)
        {
            nail4GlossNr = sender.tag;
            if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
            {
                nail4Gloss.image = [UIImage imageNamed:[NSString stringWithFormat:@"smallnailG%d@2x.png", nail4GlossNr]];
                singleGloss.image = [UIImage imageNamed:[NSString stringWithFormat:@"nailG%d@2x.png", sender.tag]];
            }
            else
            {
                nail4Gloss.image = [UIImage imageNamed:[NSString stringWithFormat:@"smallnailG%d.png", nail4GlossNr]];
                singleGloss.image = [UIImage imageNamed:[NSString stringWithFormat:@"nailG%d.png", sender.tag]];
            }
        }
        
        NSMutableDictionary *md2 = [[NSMutableDictionary alloc] init];
        [md2 setObject:@"color" forKey:@"type"];
        [md2 setObject:[NSString stringWithFormat:@"%d", sender.tag] forKey:@"pic_nr"];
        [changes4 addObject:md2];
        [md2 release];
    }
    else if(nailSelected == 5)
    {
        nail5ColorNr = sender.tag;
        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
            nail5Color.image = [UIImage imageNamed:[NSString stringWithFormat:@"smallnailC%d@2x.png", nail5ColorNr]];
        else
            nail5Color.image = [UIImage imageNamed:[NSString stringWithFormat:@"smallnailC%d.png", nail5ColorNr]];
        
        if(nail5GlossNr != 0)
        {
            nail5GlossNr = sender.tag;
            if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
            {
                nail5Gloss.image = [UIImage imageNamed:[NSString stringWithFormat:@"smallnailG%d@2x.png", nail5GlossNr]];
                singleGloss.image = [UIImage imageNamed:[NSString stringWithFormat:@"nailG%d@2x.png", sender.tag]];
            }
            else
            {
                nail5Gloss.image = [UIImage imageNamed:[NSString stringWithFormat:@"smallnailG%d.png", nail5GlossNr]];
                singleGloss.image = [UIImage imageNamed:[NSString stringWithFormat:@"nailG%d.png", sender.tag]];
            }
        }
        
        NSMutableDictionary *md2 = [[NSMutableDictionary alloc] init];
        [md2 setObject:@"color" forKey:@"type"];
        [md2 setObject:[NSString stringWithFormat:@"%d", sender.tag] forKey:@"pic_nr"];
        [changes5 addObject:md2];
        [md2 release];
    }
}

- (void)glossChosen:(UIButton*)sender
{
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        singleGloss.image = [UIImage imageNamed:[NSString stringWithFormat:@"nailG%d@2x.png", sender.tag]];
        singleColor.image = [UIImage imageNamed:[NSString stringWithFormat:@"nailC%d@2x.png", sender.tag]];
    }
    else
    {
        singleGloss.image = [UIImage imageNamed:[NSString stringWithFormat:@"nailG%d.png", sender.tag]];
        singleColor.image = [UIImage imageNamed:[NSString stringWithFormat:@"nailC%d.png", sender.tag]];
    }
    
    if(nailSelected == 1)
    {
        nail1GlossNr = sender.tag;
        nail1ColorNr = sender.tag;
        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        {
            nail1Color.image = [UIImage imageNamed:[NSString stringWithFormat:@"smallnailC%d@2x.png", nail1ColorNr]];
            nail1Gloss.image = [UIImage imageNamed:[NSString stringWithFormat:@"smallnailG%d@2x.png", nail1GlossNr]];
        }
        else
        {
            nail1Color.image = [UIImage imageNamed:[NSString stringWithFormat:@"smallnailC%d.png", nail1ColorNr]];
            nail1Gloss.image = [UIImage imageNamed:[NSString stringWithFormat:@"smallnailG%d.png", nail1GlossNr]];
        }
        
        NSMutableDictionary *md2 = [[NSMutableDictionary alloc] init];
        [md2 setObject:@"gloss" forKey:@"type"];
        [md2 setObject:[NSString stringWithFormat:@"%d", sender.tag] forKey:@"pic_nr"];
        [changes1 addObject:md2];
        [md2 release];
    }
    else if(nailSelected == 2)
    {
        nail2GlossNr = sender.tag;
        nail2ColorNr = sender.tag;
        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        {
            nail2Color.image = [UIImage imageNamed:[NSString stringWithFormat:@"smallnailC%d@2x.png", nail2ColorNr]];
            nail2Gloss.image = [UIImage imageNamed:[NSString stringWithFormat:@"smallnailG%d@2x.png", nail2GlossNr]];
        }
        else
        {
            nail2Color.image = [UIImage imageNamed:[NSString stringWithFormat:@"smallnailC%d.png", nail2ColorNr]];
            nail2Gloss.image = [UIImage imageNamed:[NSString stringWithFormat:@"smallnailG%d.png", nail2GlossNr]];
        }
        
        NSMutableDictionary *md2 = [[NSMutableDictionary alloc] init];
        [md2 setObject:@"gloss" forKey:@"type"];
        [md2 setObject:[NSString stringWithFormat:@"%d", sender.tag] forKey:@"pic_nr"];
        [changes2 addObject:md2];
        [md2 release];
    }
    else if(nailSelected == 3)
    {
        nail3GlossNr = sender.tag;
        nail3ColorNr = sender.tag;
        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        {
            nail3Color.image = [UIImage imageNamed:[NSString stringWithFormat:@"smallnailC%d@2x.png", nail3ColorNr]];
            nail3Gloss.image = [UIImage imageNamed:[NSString stringWithFormat:@"smallnailG%d@2x.png", nail3GlossNr]];
        }
        else
        {
            nail3Color.image = [UIImage imageNamed:[NSString stringWithFormat:@"smallnailC%d.png", nail3ColorNr]];
            nail3Gloss.image = [UIImage imageNamed:[NSString stringWithFormat:@"smallnailG%d.png", nail3GlossNr]];
        }
        
        NSMutableDictionary *md2 = [[NSMutableDictionary alloc] init];
        [md2 setObject:@"gloss" forKey:@"type"];
        [md2 setObject:[NSString stringWithFormat:@"%d", sender.tag] forKey:@"pic_nr"];
        [changes3 addObject:md2];
        [md2 release];
    }
    else if(nailSelected == 4)
    {
        nail4GlossNr = sender.tag;
        nail4ColorNr = sender.tag;
        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        {
            nail4Color.image = [UIImage imageNamed:[NSString stringWithFormat:@"smallnailC%d@2x.png", nail4ColorNr]];
            nail4Gloss.image = [UIImage imageNamed:[NSString stringWithFormat:@"smallnailG%d@2x.png", nail4GlossNr]];
        }
        else
        {
            nail4Color.image = [UIImage imageNamed:[NSString stringWithFormat:@"smallnailC%d.png", nail4ColorNr]];
            nail4Gloss.image = [UIImage imageNamed:[NSString stringWithFormat:@"smallnailG%d.png", nail4GlossNr]];
        }
        
        NSMutableDictionary *md2 = [[NSMutableDictionary alloc] init];
        [md2 setObject:@"gloss" forKey:@"type"];
        [md2 setObject:[NSString stringWithFormat:@"%d", sender.tag] forKey:@"pic_nr"];
        [changes4 addObject:md2];
        [md2 release];
    }
    else if(nailSelected == 5)
    {
        nail5GlossNr = sender.tag;
        nail5ColorNr = sender.tag;
        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        {
            nail5Color.image = [UIImage imageNamed:[NSString stringWithFormat:@"smallnailC%d@2x.png", nail5ColorNr]];
            nail5Gloss.image = [UIImage imageNamed:[NSString stringWithFormat:@"smallnailG%d@2x.png", nail5GlossNr]];
        }
        else
        {
            nail5Color.image = [UIImage imageNamed:[NSString stringWithFormat:@"smallnailC%d.png", nail5ColorNr]];
            nail5Gloss.image = [UIImage imageNamed:[NSString stringWithFormat:@"smallnailG%d.png", nail5GlossNr]];
        }
        
        NSMutableDictionary *md2 = [[NSMutableDictionary alloc] init];
        [md2 setObject:@"gloss" forKey:@"type"];
        [md2 setObject:[NSString stringWithFormat:@"%d", sender.tag] forKey:@"pic_nr"];
        [changes5 addObject:md2];
        [md2 release];
    }
}

- (void)patternChosen:(UIButton*)sender
{
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        singlePattern.image = [UIImage imageNamed:[NSString stringWithFormat:@"nailP%d@2x.png", sender.tag]];
    else
        singlePattern.image = [UIImage imageNamed:[NSString stringWithFormat:@"nailP%d.png", sender.tag]];
        
    if(nailSelected == 1)
    {
        nail1PatternNr = sender.tag;
        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
            nail1Pattern.image = [UIImage imageNamed:[NSString stringWithFormat:@"smallnailP%d@2x.png",nail1PatternNr]];
        else
            nail1Pattern.image = [UIImage imageNamed:[NSString stringWithFormat:@"smallnailP%d.png",nail1PatternNr]];
        
        NSMutableDictionary *md2 = [[NSMutableDictionary alloc] init];
        [md2 setObject:@"pattern" forKey:@"type"];
        [md2 setObject:[NSString stringWithFormat:@"%d", sender.tag] forKey:@"pic_nr"];
        [changes1 addObject:md2];
        [md2 release];
    }   
    else if(nailSelected == 2)
    {
        nail2PatternNr = sender.tag;
        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
            nail2Pattern.image = [UIImage imageNamed:[NSString stringWithFormat:@"smallnailP%d@2x.png",nail2PatternNr]];
        else
            nail2Pattern.image = [UIImage imageNamed:[NSString stringWithFormat:@"smallnailP%d.png", nail2PatternNr]];
        
        NSMutableDictionary *md2 = [[NSMutableDictionary alloc] init];
        [md2 setObject:@"pattern" forKey:@"type"];
        [md2 setObject:[NSString stringWithFormat:@"%d", sender.tag] forKey:@"pic_nr"];
        [changes2 addObject:md2];
        [md2 release];
    }
    else if(nailSelected == 3)
    {
        nail3PatternNr = sender.tag;
        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
            nail3Pattern.image = [UIImage imageNamed:[NSString stringWithFormat:@"smallnailP%d@2x.png",nail3PatternNr]];
        else
            nail3Pattern.image = [UIImage imageNamed:[NSString stringWithFormat:@"smallnailP%d.png", nail3PatternNr]];
        
        NSMutableDictionary *md2 = [[NSMutableDictionary alloc] init];
        [md2 setObject:@"pattern" forKey:@"type"];
        [md2 setObject:[NSString stringWithFormat:@"%d", sender.tag] forKey:@"pic_nr"];
        [changes3 addObject:md2];
        [md2 release];
    }
    else if(nailSelected == 4)
    {
        nail4PatternNr = sender.tag;
        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
            nail4Pattern.image = [UIImage imageNamed:[NSString stringWithFormat:@"smallnailP%d@2x.png",nail4PatternNr]];
        else
            nail4Pattern.image = [UIImage imageNamed:[NSString stringWithFormat:@"smallnailP%d.png", nail4PatternNr]];
        
        NSMutableDictionary *md2 = [[NSMutableDictionary alloc] init];
        [md2 setObject:@"pattern" forKey:@"type"];
        [md2 setObject:[NSString stringWithFormat:@"%d", sender.tag] forKey:@"pic_nr"];
        [changes4 addObject:md2];
        [md2 release];
    }
    else if(nailSelected == 5)
    {
        nail5PatternNr = sender.tag;
        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
            nail5Pattern.image = [UIImage imageNamed:[NSString stringWithFormat:@"smallnailP%d@2x.png",nail5PatternNr]];
        else
            nail5Pattern.image = [UIImage imageNamed:[NSString stringWithFormat:@"smallnailP%d.png", nail5PatternNr]];
        
        NSMutableDictionary *md2 = [[NSMutableDictionary alloc] init];
        [md2 setObject:@"pattern" forKey:@"type"];
        [md2 setObject:[NSString stringWithFormat:@"%d", sender.tag] forKey:@"pic_nr"];
        [changes5 addObject:md2];
        [md2 release];
    }
}

- (void)tipChosen:(UIButton*)sender
{
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        singleTip.image = [UIImage imageNamed:[NSString stringWithFormat:@"nailT%d@2x.png", sender.tag]];
    else
        singleTip.image = [UIImage imageNamed:[NSString stringWithFormat:@"nailT%d.png", sender.tag]];
    
    if(nailSelected == 1)
    {
        nail1TipNr = sender.tag;
        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
            nail1Tip.image = [UIImage imageNamed:[NSString stringWithFormat:@"smallnailT%d@2x.png",nail1TipNr]];
        else
            nail1Tip.image = [UIImage imageNamed:[NSString stringWithFormat:@"smallnailT%d.png",nail1TipNr]];
        
        NSMutableDictionary *md2 = [[NSMutableDictionary alloc] init];
        [md2 setObject:@"tip" forKey:@"type"];
        [md2 setObject:[NSString stringWithFormat:@"%d", sender.tag] forKey:@"pic_nr"];
        [changes1 addObject:md2];
        [md2 release];
    }
    else if(nailSelected == 2)
    {
        nail2TipNr = sender.tag;
        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
            nail2Tip.image = [UIImage imageNamed:[NSString stringWithFormat:@"smallnailT%d@2x.png",nail2TipNr]];
        else
            nail2Tip.image = [UIImage imageNamed:[NSString stringWithFormat:@"smallnailT%d.png", nail2TipNr]];
        
        NSMutableDictionary *md2 = [[NSMutableDictionary alloc] init];
        [md2 setObject:@"tip" forKey:@"type"];
        [md2 setObject:[NSString stringWithFormat:@"%d", sender.tag] forKey:@"pic_nr"];
        [changes2 addObject:md2];
        [md2 release];
    }
    else if(nailSelected == 3)
    {
        nail3TipNr = sender.tag;
        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
            nail3Tip.image = [UIImage imageNamed:[NSString stringWithFormat:@"smallnailT%d@2x.png",nail3TipNr]];
        else
            nail3Tip.image = [UIImage imageNamed:[NSString stringWithFormat:@"smallnailT%d.png", nail3TipNr]];
        
        NSMutableDictionary *md2 = [[NSMutableDictionary alloc] init];
        [md2 setObject:@"tip" forKey:@"type"];
        [md2 setObject:[NSString stringWithFormat:@"%d", sender.tag] forKey:@"pic_nr"];
        [changes3 addObject:md2];
        [md2 release];
    }
    else if(nailSelected == 4)
    {
        nail4TipNr = sender.tag;
        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
            nail4Tip.image = [UIImage imageNamed:[NSString stringWithFormat:@"smallnailT%d@2x.png",nail4TipNr]];
        else
            nail4Tip.image = [UIImage imageNamed:[NSString stringWithFormat:@"smallnailT%d.png", nail4TipNr]];
        
        NSMutableDictionary *md2 = [[NSMutableDictionary alloc] init];
        [md2 setObject:@"tip" forKey:@"type"];
        [md2 setObject:[NSString stringWithFormat:@"%d", sender.tag] forKey:@"pic_nr"];
        [changes4 addObject:md2];
        [md2 release];
    }
    else if(nailSelected == 5)
    {
        nail5TipNr = sender.tag;
        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
            nail5Tip.image = [UIImage imageNamed:[NSString stringWithFormat:@"smallnailT%d@2x.png",nail5TipNr]];
        else
            nail5Tip.image = [UIImage imageNamed:[NSString stringWithFormat:@"smallnailT%d.png", nail5TipNr]];
        
        NSMutableDictionary *md2 = [[NSMutableDictionary alloc] init];
        [md2 setObject:@"tip" forKey:@"type"];
        [md2 setObject:[NSString stringWithFormat:@"%d", sender.tag] forKey:@"pic_nr"];
        [changes5 addObject:md2];
        [md2 release];
    }
}

- (void)extrasChosen:(UIButton*)sender
{
    UIImageView *label = [[UIImageView alloc] init];
    UIImage *temp = [UIImage imageNamed:[NSString stringWithFormat:@"x%d.png", sender.tag]];
    label.frame = CGRectMake((singleTip.frame.size.width - temp.size.width)/2, (singleTip.frame.size.height - temp.size.height)/2, temp.size.width, temp.size.height);
    
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        temp = [UIImage imageNamed:[NSString stringWithFormat:@"x%d@2x.png", sender.tag]];
        label.frame = CGRectMake((singleTip.frame.size.width - temp.size.width)/2, (singleTip.frame.size.height - temp.size.height)/2, temp.size.width, temp.size.height);
    }
    
    label.image = temp;
    
    if(nailSelected == 1)
    {
        label.tag = [extras1Array count] + 1;
        
        NSMutableDictionary *md = [[NSMutableDictionary alloc] init];
        [md setObject:[NSString stringWithFormat:@"%d", sender.tag] forKey:@"pic"];
        [md setObject:NSStringFromCGRect(label.frame) forKey:@"frame"];
        [extras1Array addObject:md];
        [md release];
        
        
        NSMutableDictionary *md2 = [[NSMutableDictionary alloc] init];
        [md2 setObject:@"extras" forKey:@"type"];
        [md2 setObject:[NSString stringWithFormat:@"%d", sender.tag] forKey:@"pic_nr"];
        [changes1 addObject:md2];
        [md2 release];

    }
    else if(nailSelected == 2)
    {
        label.tag = [extras2Array count] + 1;
        
        NSMutableDictionary *md = [[NSMutableDictionary alloc] init];
        [md setObject:[NSString stringWithFormat:@"%d", sender.tag] forKey:@"pic"];
        [md setObject:NSStringFromCGRect(label.frame) forKey:@"frame"];
        [extras2Array addObject:md];
        [md release];
        
        NSMutableDictionary *md2 = [[NSMutableDictionary alloc] init];
        [md2 setObject:@"extras" forKey:@"type"];
        [md2 setObject:[NSString stringWithFormat:@"%d", sender.tag] forKey:@"pic_nr"];
        [changes2 addObject:md2];
        [md2 release];
    }
    else if(nailSelected == 3)
    {
        label.tag = [extras3Array count] + 1;
        
        NSMutableDictionary *md = [[NSMutableDictionary alloc] init];
        [md setObject:[NSString stringWithFormat:@"%d", sender.tag] forKey:@"pic"];
        [md setObject:NSStringFromCGRect(label.frame) forKey:@"frame"];
        [extras3Array addObject:md];
        [md release];
        
        NSMutableDictionary *md2 = [[NSMutableDictionary alloc] init];
        [md2 setObject:@"extras" forKey:@"type"];
        [md2 setObject:[NSString stringWithFormat:@"%d", sender.tag] forKey:@"pic_nr"];
        [changes3 addObject:md2];
        [md2 release];

    }
    else if(nailSelected == 4)
    {
        label.tag = [extras4Array count] + 1;
        
        NSMutableDictionary *md = [[NSMutableDictionary alloc] init];
        [md setObject:[NSString stringWithFormat:@"%d", sender.tag] forKey:@"pic"];
        [md setObject:NSStringFromCGRect(label.frame) forKey:@"frame"];
        [extras4Array addObject:md];
        [md release];
        
        NSMutableDictionary *md2 = [[NSMutableDictionary alloc] init];
        [md2 setObject:@"extras" forKey:@"type"];
        [md2 setObject:[NSString stringWithFormat:@"%d", sender.tag] forKey:@"pic_nr"];
        [changes4 addObject:md2];
        [md2 release];
    }
    else if(nailSelected == 5)
    {
        label.tag = [extras5Array count] + 1;
        
        NSMutableDictionary *md = [[NSMutableDictionary alloc] init];
        [md setObject:[NSString stringWithFormat:@"%d", sender.tag] forKey:@"pic"];
        [md setObject:NSStringFromCGRect(label.frame) forKey:@"frame"];
        [extras5Array addObject:md];
        [md release];
        
        NSMutableDictionary *md2 = [[NSMutableDictionary alloc] init];
        [md2 setObject:@"extras" forKey:@"type"];
        [md2 setObject:[NSString stringWithFormat:@"%d", sender.tag] forKey:@"pic_nr"];
        [changes5 addObject:md2];
        [md2 release];
    }
    
    label.userInteractionEnabled = YES;
    [singleTip addSubview:label];
    [label release];
}

- (void)handChosen:(UIButton*)sender
{
    hand = sender.tag;
    handImgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"hand%d.png", hand]];
    fingerImgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"finger%d.png", hand]];
    
    if(nailSelected == 1)
    {
        NSMutableDictionary *md2 = [[NSMutableDictionary alloc] init];
        [md2 setObject:@"hand" forKey:@"type"];
        [md2 setObject:[NSString stringWithFormat:@"%d", sender.tag] forKey:@"pic_nr"];
        [changes1 addObject:md2];
        [md2 release];
    }
    else if(nailSelected == 2)
    {
        NSMutableDictionary *md2 = [[NSMutableDictionary alloc] init];
        [md2 setObject:@"hand" forKey:@"type"];
        [md2 setObject:[NSString stringWithFormat:@"%d", sender.tag] forKey:@"pic_nr"];
        [changes2 addObject:md2];
        [md2 release];
    }
    else if(nailSelected == 3)
    {
        NSMutableDictionary *md2 = [[NSMutableDictionary alloc] init];
        [md2 setObject:@"hand" forKey:@"type"];
        [md2 setObject:[NSString stringWithFormat:@"%d", sender.tag] forKey:@"pic_nr"];
        [changes3 addObject:md2];
        [md2 release];
    }
    else if(nailSelected == 4)
    {
        NSMutableDictionary *md2 = [[NSMutableDictionary alloc] init];
        [md2 setObject:@"hand" forKey:@"type"];
        [md2 setObject:[NSString stringWithFormat:@"%d", sender.tag] forKey:@"pic_nr"];
        [changes4 addObject:md2];
        [md2 release];
    }
    if(nailSelected == 5)
    {
        NSMutableDictionary *md2 = [[NSMutableDictionary alloc] init];
        [md2 setObject:@"hand" forKey:@"type"];
        [md2 setObject:[NSString stringWithFormat:@"%d", sender.tag] forKey:@"pic_nr"];
        [changes5 addObject:md2];
        [md2 release];
    }
}

- (void)backgroundChosen:(UIButton*)sender
{
    background = sender.tag;
    
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        backgroundImgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d~ipad.png", background]];
        background2ImgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d~ipad.png", background]];
    }
    else if([UIScreen mainScreen].bounds.size.height == 568)
    {
        backgroundImgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d_568.png", background]];
        background2ImgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d_568.png", background]];
    }
    else
    {
        backgroundImgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d.png", background]];
        background2ImgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d.png", background]];
    }

    
    if(nailSelected == 1)
    {
        NSMutableDictionary *md2 = [[NSMutableDictionary alloc] init];
        [md2 setObject:@"background" forKey:@"type"];
        [md2 setObject:[NSString stringWithFormat:@"%d", sender.tag] forKey:@"pic_nr"];
        [changes1 addObject:md2];
        [md2 release];
    }
    else if(nailSelected == 2)
    {
        NSMutableDictionary *md2 = [[NSMutableDictionary alloc] init];
        [md2 setObject:@"background" forKey:@"type"];
        [md2 setObject:[NSString stringWithFormat:@"%d", sender.tag] forKey:@"pic_nr"];
        [changes2 addObject:md2];
        [md2 release];
    }
    else if(nailSelected == 3)
    {
        NSMutableDictionary *md2 = [[NSMutableDictionary alloc] init];
        [md2 setObject:@"background" forKey:@"type"];
        [md2 setObject:[NSString stringWithFormat:@"%d", sender.tag] forKey:@"pic_nr"];
        [changes3 addObject:md2];
        [md2 release];
    }
    else if(nailSelected == 4)
    {
        NSMutableDictionary *md2 = [[NSMutableDictionary alloc] init];
        [md2 setObject:@"background" forKey:@"type"];
        [md2 setObject:[NSString stringWithFormat:@"%d", sender.tag] forKey:@"pic_nr"];
        [changes4 addObject:md2];
        [md2 release];
    }
    else if(nailSelected == 5)
    {
        NSMutableDictionary *md2 = [[NSMutableDictionary alloc] init];
        [md2 setObject:@"background" forKey:@"type"];
        [md2 setObject:[NSString stringWithFormat:@"%d", sender.tag] forKey:@"pic_nr"];
        [changes5 addObject:md2];
        [md2 release];
    }
}

#pragma mark -
- (IBAction)nailSelected:(UIButton*)sender
{
    [(AppDelegate*)[[UIApplication sharedApplication] delegate] playSoundEffect:1];
    nailSelected = sender.tag;
    [menuScroll setContentOffset:CGPointMake(0, 0)];
    
    if(nailSelected == 1)
    {
        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        {
            singleColor.image = [UIImage imageNamed:[NSString stringWithFormat:@"nailC%d@2x.png", nail1ColorNr]];
            singleGloss.image = [UIImage imageNamed:[NSString stringWithFormat:@"nailG%d@2x.png", nail1GlossNr]];
            singlePattern.image = [UIImage imageNamed:[NSString stringWithFormat:@"nailP%d@2x.png", nail1PatternNr]];
            singleTip.image = [UIImage imageNamed:[NSString stringWithFormat:@"nailT%d@2x.png", nail1TipNr]];
        }
        else
        {
            singleColor.image = [UIImage imageNamed:[NSString stringWithFormat:@"nailC%d.png", nail1ColorNr]];
            singleGloss.image = [UIImage imageNamed:[NSString stringWithFormat:@"nailG%d.png", nail1GlossNr]];
            singlePattern.image = [UIImage imageNamed:[NSString stringWithFormat:@"nailP%d.png", nail1PatternNr]];
            singleTip.image = [UIImage imageNamed:[NSString stringWithFormat:@"nailT%d.png", nail1TipNr]];
        }
        
        for(UIView *view in [singleTip subviews])
            [view removeFromSuperview];
        
        for(int i = 0; i < [extras1Array count]; i++)
        {
            
            UIImageView *label = [[UIImageView alloc] init];
            
            label.frame = CGRectFromString([[extras1Array objectAtIndex:i] objectForKey:@"frame"]);
            label.image = [UIImage imageNamed:[NSString stringWithFormat:@"x%d.png", [[[extras1Array objectAtIndex:i] objectForKey:@"pic"] intValue]]];
            
            if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
                label.image = [UIImage imageNamed:[NSString stringWithFormat:@"x%d@2x.png", [[[extras1Array objectAtIndex:i] objectForKey:@"pic"] intValue]]];
            else
                label.image = [UIImage imageNamed:[NSString stringWithFormat:@"x%d.png", [[[extras1Array objectAtIndex:i] objectForKey:@"pic"] intValue]]];
            
            // Hassan
            int tempTag = [[[extras1Array objectAtIndex:i] objectForKey:@"pic"] intValue];
            
            if (tempTag == 5000) {
                
                if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                    
                    label.frame = CGRectFromString([[extras1Array objectAtIndex:i] objectForKey:@"frame"]);
                    
                }
                else {
                    
                    label.frame = CGRectFromString([[extras1Array objectAtIndex:i] objectForKey:@"frame"]);
                }
                
            }
            
            if (tempTag == 5000) {
                
                label.image                 = (UIImage *)[[extras1Array objectAtIndex:i] objectForKey:@"gallery_pic_1"];
                
            } else if (tempTag == 9000) {
                
                nail1Tip.backgroundColor = (UIColor *)[[extras1Array objectAtIndex:i] objectForKey:@"bg_nail_color"];
                
            }
            
            label.tag = i + 1;
            label.userInteractionEnabled = YES;
            [singleTip addSubview:label];
            [label release];
            
        }
    }
    else if(nailSelected == 2)
    {
        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        {
            singleColor.image = [UIImage imageNamed:[NSString stringWithFormat:@"nailC%d@2x.png", nail2ColorNr]];
            singleGloss.image = [UIImage imageNamed:[NSString stringWithFormat:@"nailG%d@2x.png", nail2GlossNr]];
            singlePattern.image = [UIImage imageNamed:[NSString stringWithFormat:@"nailP%d@2x.png", nail2PatternNr]];
            singleTip.image = [UIImage imageNamed:[NSString stringWithFormat:@"nailT%d@2x.png", nail2TipNr]];
        }
        else
        {
            singleColor.image = [UIImage imageNamed:[NSString stringWithFormat:@"nailC%d.png", nail2ColorNr]];
            singleGloss.image = [UIImage imageNamed:[NSString stringWithFormat:@"nailG%d.png", nail2GlossNr]];
            singlePattern.image = [UIImage imageNamed:[NSString stringWithFormat:@"nailP%d.png", nail2PatternNr]];
            singleTip.image = [UIImage imageNamed:[NSString stringWithFormat:@"nailT%d.png", nail2TipNr]];
        }
        
        for(UIView *view in [singleTip subviews])
            [view removeFromSuperview];
        
        for(int i = 0; i < [extras2Array count]; i++)
        {
            UIImageView *label = [[UIImageView alloc] init];
            
            label.frame = CGRectFromString([[extras2Array objectAtIndex:i] objectForKey:@"frame"]);
            label.image = [UIImage imageNamed:[NSString stringWithFormat:@"x%d.png", [[[extras2Array objectAtIndex:i] objectForKey:@"pic"] intValue]]];
            
            if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
                label.image = [UIImage imageNamed:[NSString stringWithFormat:@"x%d@2x.png", [[[extras2Array objectAtIndex:i] objectForKey:@"pic"] intValue]]];
            else
                label.image = [UIImage imageNamed:[NSString stringWithFormat:@"x%d.png", [[[extras2Array objectAtIndex:i] objectForKey:@"pic"] intValue]]];
            
            // Hassan
            int tempTag = [[[extras2Array objectAtIndex:i] objectForKey:@"pic"] intValue];
            
            if (tempTag == 5000) {
                
                if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                    
                    label.frame = CGRectFromString([[extras2Array objectAtIndex:i] objectForKey:@"frame"]);
                    
                }
                else {
                    
                    label.frame = CGRectFromString([[extras2Array objectAtIndex:i] objectForKey:@"frame"]);
                }
                
            }
            
            if (tempTag == 5000) {
            
                label.image                 = (UIImage *)[[extras2Array objectAtIndex:i] objectForKey:@"gallery_pic_1"];
                
            } else if (tempTag == 9000) {
                
                nail1Tip.backgroundColor = (UIColor *)[[extras2Array objectAtIndex:i] objectForKey:@"bg_nail_color"];
                
            }
            
            label.tag = i + 1;
            label.userInteractionEnabled = YES;
            [singleTip addSubview:label];
            [label release];
        }
    }
    else if(nailSelected == 3)
    {
        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        {
            singleColor.image = [UIImage imageNamed:[NSString stringWithFormat:@"nailC%d@2x.png", nail3ColorNr]];
            singleGloss.image = [UIImage imageNamed:[NSString stringWithFormat:@"nailG%d@2x.png", nail3GlossNr]];
            singlePattern.image = [UIImage imageNamed:[NSString stringWithFormat:@"nailP%d@2x.png", nail3PatternNr]];
            singleTip.image = [UIImage imageNamed:[NSString stringWithFormat:@"nailT%d@2x.png", nail3TipNr]];
        }
        else
        {
            singleColor.image = [UIImage imageNamed:[NSString stringWithFormat:@"nailC%d.png", nail3ColorNr]];
            singleGloss.image = [UIImage imageNamed:[NSString stringWithFormat:@"nailG%d.png", nail3GlossNr]];
            singlePattern.image = [UIImage imageNamed:[NSString stringWithFormat:@"nailP%d.png", nail3PatternNr]];
            singleTip.image = [UIImage imageNamed:[NSString stringWithFormat:@"nailT%d.png", nail3TipNr]];
        }
        
        for(UIView *view in [singleTip subviews])
            [view removeFromSuperview];
        
        for(int i = 0; i < [extras3Array count]; i++)
        {
            UIImageView *label = [[UIImageView alloc] init];
            
            label.frame = CGRectFromString([[extras3Array objectAtIndex:i] objectForKey:@"frame"]);
            label.image = [UIImage imageNamed:[NSString stringWithFormat:@"x%d.png", [[[extras3Array objectAtIndex:i] objectForKey:@"pic"] intValue]]];
            
            if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
                label.image = [UIImage imageNamed:[NSString stringWithFormat:@"x%d@2x.png", [[[extras3Array objectAtIndex:i] objectForKey:@"pic"] intValue]]];
            else
                label.image = [UIImage imageNamed:[NSString stringWithFormat:@"x%d.png", [[[extras3Array objectAtIndex:i] objectForKey:@"pic"] intValue]]];
            
            // Hassan
            int tempTag = [[[extras3Array objectAtIndex:i] objectForKey:@"pic"] intValue];
            
            if (tempTag == 5000) {
                
                if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                    
                    label.frame = CGRectFromString([[extras3Array objectAtIndex:i] objectForKey:@"frame"]);
                    
                }
                else {
                    
                    label.frame = CGRectFromString([[extras3Array objectAtIndex:i] objectForKey:@"frame"]);
                }
                
            }
            
            if (tempTag == 5000) {
            
                label.image                 = (UIImage *)[[extras3Array objectAtIndex:i] objectForKey:@"gallery_pic_1"];
                
            } else if (tempTag == 9000) {
                
                nail1Tip.backgroundColor = (UIColor *)[[extras3Array objectAtIndex:i] objectForKey:@"bg_nail_color"];
                
            }
            
            label.tag = i + 1;
            label.userInteractionEnabled = YES;
            [singleTip addSubview:label];
            [label release];
        }
    }
    else if(nailSelected == 4)
    {
        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        {
            singleColor.image = [UIImage imageNamed:[NSString stringWithFormat:@"nailC%d@2x.png", nail4ColorNr]];
            singleGloss.image = [UIImage imageNamed:[NSString stringWithFormat:@"nailG%d@2x.png", nail4GlossNr]];
            singlePattern.image = [UIImage imageNamed:[NSString stringWithFormat:@"nailP%d@2x.png", nail4PatternNr]];
            singleTip.image = [UIImage imageNamed:[NSString stringWithFormat:@"nailT%d@2x.png", nail4TipNr]];
        }
        else
        {
            singleColor.image = [UIImage imageNamed:[NSString stringWithFormat:@"nailC%d.png", nail4ColorNr]];
            singleGloss.image = [UIImage imageNamed:[NSString stringWithFormat:@"nailG%d.png", nail4GlossNr]];
            singlePattern.image = [UIImage imageNamed:[NSString stringWithFormat:@"nailP%d.png", nail4PatternNr]];
            singleTip.image = [UIImage imageNamed:[NSString stringWithFormat:@"nailT%d.png", nail4TipNr]];
        }
        
        for(UIView *view in [singleTip subviews])
            [view removeFromSuperview];
        
        for(int i = 0; i < [extras4Array count]; i++)
        {
            UIImageView *label = [[UIImageView alloc] init];
            
            label.frame = CGRectFromString([[extras4Array objectAtIndex:i] objectForKey:@"frame"]);
            label.image = [UIImage imageNamed:[NSString stringWithFormat:@"x%d.png", [[[extras4Array objectAtIndex:i] objectForKey:@"pic"] intValue]]];
            
            if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
                label.image = [UIImage imageNamed:[NSString stringWithFormat:@"x%d@2x.png", [[[extras4Array objectAtIndex:i] objectForKey:@"pic"] intValue]]];
            else
                label.image = [UIImage imageNamed:[NSString stringWithFormat:@"x%d.png", [[[extras4Array objectAtIndex:i] objectForKey:@"pic"] intValue]]];
            
            // Hassan
            int tempTag = [[[extras4Array objectAtIndex:i] objectForKey:@"pic"] intValue];
            
            if (tempTag == 5000) {
                
                if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                    
                    label.frame = CGRectFromString([[extras4Array objectAtIndex:i] objectForKey:@"frame"]);
                    
                }
                else {
                    
                    label.frame = CGRectFromString([[extras4Array objectAtIndex:i] objectForKey:@"frame"]);
                }
                
            }
            
            if (tempTag == 5000) {

                label.image                 = (UIImage *)[[extras4Array objectAtIndex:i] objectForKey:@"gallery_pic_1"];
                
            } else if (tempTag == 9000) {
                
                nail1Tip.backgroundColor = (UIColor *)[[extras4Array objectAtIndex:i] objectForKey:@"bg_nail_color"];
                
            }
            
            label.tag = i + 1;
            label.userInteractionEnabled = YES;
            [singleTip addSubview:label];
            [label release];
        }
    }
    else if(nailSelected == 5)
    {
        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        {
            singleColor.image = [UIImage imageNamed:[NSString stringWithFormat:@"nailC%d@2x.png", nail5ColorNr]];
            singleGloss.image = [UIImage imageNamed:[NSString stringWithFormat:@"nailG%d@2x.png", nail5GlossNr]];
            singlePattern.image = [UIImage imageNamed:[NSString stringWithFormat:@"nailP%d@2x.png", nail5PatternNr]];
            singleTip.image = [UIImage imageNamed:[NSString stringWithFormat:@"nailT%d@2x.png", nail5TipNr]];
        }
        else
        {
            singleColor.image = [UIImage imageNamed:[NSString stringWithFormat:@"nailC%d.png", nail5ColorNr]];
            singleGloss.image = [UIImage imageNamed:[NSString stringWithFormat:@"nailG%d.png", nail5GlossNr]];
            singlePattern.image = [UIImage imageNamed:[NSString stringWithFormat:@"nailP%d.png", nail5PatternNr]];
            singleTip.image = [UIImage imageNamed:[NSString stringWithFormat:@"nailT%d.png", nail5TipNr]];
        }
        
        for(UIView *view in [singleTip subviews])
            [view removeFromSuperview];
        
        for(int i = 0; i < [extras5Array count]; i++)
        {
            UIImageView *label = [[UIImageView alloc] init];
            
            label.frame = CGRectFromString([[extras5Array objectAtIndex:i] objectForKey:@"frame"]);
            label.image = [UIImage imageNamed:[NSString stringWithFormat:@"x%d.png", [[[extras5Array objectAtIndex:i] objectForKey:@"pic"] intValue]]];
            if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
                label.image = [UIImage imageNamed:[NSString stringWithFormat:@"x%d@2x.png", [[[extras5Array objectAtIndex:i] objectForKey:@"pic"] intValue]]];
            else
                label.image = [UIImage imageNamed:[NSString stringWithFormat:@"x%d.png", [[[extras5Array objectAtIndex:i] objectForKey:@"pic"] intValue]]];
            
            // Hassan
            int tempTag = [[[extras5Array objectAtIndex:i] objectForKey:@"pic"] intValue];
            
            if (tempTag == 5000) {
                
                if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                    
                    label.frame = CGRectFromString([[extras5Array objectAtIndex:i] objectForKey:@"frame"]);
                    
                }
                else {
                    
                    label.frame = CGRectFromString([[extras5Array objectAtIndex:i] objectForKey:@"frame"]);
                }
                
            }
            
            if (tempTag == 5000) {
                
                label.image                 = (UIImage *)[[extras5Array objectAtIndex:i] objectForKey:@"gallery_pic_1"];
                
            } else if (tempTag == 9000) {
                
                nail1Tip.backgroundColor = (UIColor *)[[extras5Array objectAtIndex:i] objectForKey:@"bg_nail_color"];
                
            }
            
            label.tag = i + 1;
            label.userInteractionEnabled = YES;
            [singleTip addSubview:label];
            [label release];
        }
    }
    
    singleFinger.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    [self.view addSubview:singleFinger];
    
    if([((AppDelegate *)[[UIApplication sharedApplication] delegate]) nailsLocked] == YES)
    {
        CABasicAnimation *rotation2 = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
        rotation2.fromValue = [NSNumber numberWithFloat:0];
        rotation2.toValue = [NSNumber numberWithFloat:(2*M_PI)];
        rotation2.duration = 0.8; // Speed
        rotation2.repeatCount = HUGE_VALF; // Repeat forever. Can be a finite number.
        [unlockSparkle2.layer addAnimation:rotation2 forKey:@"Spin"];
    }

    
    [UIView transitionWithView:singleFinger duration:0.5 options:UIViewAnimationOptionCurveEaseOut animations:^
     {
        singleFinger.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
     } completion:nil];
}

- (IBAction)backFromFinger:(id)sender
{
    [(AppDelegate*)[[UIApplication sharedApplication] delegate] playSoundEffect:1];
    [self updateExtras];
    
    nailSelected = 0;
    for(UIView *view in [secondScroll subviews])
        [view removeFromSuperview];
    for(UIButton *b in [menuScroll subviews])
        [b setSelected:NO];
    
    lastAccessory = -1;
    [secondScroll setContentOffset:CGPointMake(0, 0)];
    greyImgView.hidden = YES;
    
    [UIView transitionWithView:singleFinger duration:0.5 options:UIViewAnimationOptionCurveEaseOut animations:^
     {
         singleFinger.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
     } completion:^(BOOL finished) {
         [singleFinger removeFromSuperview];
     }];
}

#pragma mark -

- (IBAction)backClick:(id)sender
{
    [(AppDelegate*)[[UIApplication sharedApplication] delegate] playSoundEffect:1];
    [(AppDelegate*)[[UIApplication sharedApplication] delegate] stopSoundEffect:5];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)nextClick:(id)sender
{
    [(AppDelegate*)[[UIApplication sharedApplication] delegate] playSoundEffect:1];
    [(AppDelegate*)[[UIApplication sharedApplication] delegate] stopSoundEffect:5];
    NailFinalViewController *nailFinal = [[NailFinalViewController alloc] init];
    
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

- (IBAction)unlockEverythingClick:(id)sender
{
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(14 + 2  + 56 , 6, 56, 48)];
    button.tag = 6;
    
    [((AppDelegate *)[[UIApplication sharedApplication] delegate]).store productClick:button];
}

- (IBAction)undoClick:(id)sender
{
    [(AppDelegate*)[[UIApplication sharedApplication] delegate] playSoundEffect:1];
    
    if(nailSelected == 1)
    {
        NSMutableDictionary *md = [changes1 lastObject];
        
        if([[md objectForKey:@"type"] isEqualToString:@"extras"])
        {
            for(UIView *view in [singleTip subviews])
            {
                if(view.tag > 0 && view.tag == [extras1Array count])
                {
                    [view removeFromSuperview];
                }
            }
            [extras1Array removeLastObject];
            [changes1 removeLastObject];
            
            
        }
        else if([[md objectForKey:@"type"] isEqualToString:@"gallery_picture"])
        {
            for(UIView *view in [singleTip subviews])
            {
                if(view.tag > 0 && view.tag == [extras1Array count])
                {
                    [view removeFromSuperview];
                }
            }
            [extras1Array removeLastObject];
            [changes1 removeLastObject];
        }
        else if([[md objectForKey:@"type"] isEqualToString:@"color"])
        {
            [changes1 removeLastObject];
            
            nail1ColorNr = 1;
            for(int i = 0; i < [changes1 count]; i++)
            {
                if([[[changes1 objectAtIndex:i] objectForKey:@"type"] isEqualToString:@"color"])
                {
                    nail1ColorNr = [[[changes1 objectAtIndex:i] objectForKey:@"pic_nr"] intValue];
                }
            }
            
            if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
            {
                singleColor.image = [UIImage imageNamed:[NSString stringWithFormat:@"nailC%d@2x.png", nail1ColorNr]];
                nail1Color.image = [UIImage imageNamed:[NSString stringWithFormat:@"smallnailC%d@2x.png", nail1ColorNr]];
            }
            else
            {
                singleColor.image = [UIImage imageNamed:[NSString stringWithFormat:@"nailC%d.png", nail1ColorNr]];
                nail1Color.image = [UIImage imageNamed:[NSString stringWithFormat:@"smallnailC%d.png", nail1ColorNr]];
            }
            
            if(nail1GlossNr != 0)
            {
                nail1GlossNr = nail1ColorNr;
                if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
                {
                    nail1Gloss.image = [UIImage imageNamed:[NSString stringWithFormat:@"smallnailG%d@2x.png", nail1GlossNr]];
                    singleGloss.image = [UIImage imageNamed:[NSString stringWithFormat:@"nailG%d@2x.png", nail1ColorNr]];
                }
                else
                {
                    nail1Gloss.image = [UIImage imageNamed:[NSString stringWithFormat:@"smallnailG%d.png", nail1GlossNr]];
                    singleGloss.image = [UIImage imageNamed:[NSString stringWithFormat:@"nailG%d.png", nail1ColorNr]];
                }
            }
        }
        else if([[md objectForKey:@"type"] isEqualToString:@"gloss"])
        {
            [changes1 removeLastObject];
            
            nail1GlossNr = -1;
            for(int i = 0; i < [changes1 count]; i++)
            {
                if([[[changes1 objectAtIndex:i] objectForKey:@"type"] isEqualToString:@"gloss"])
                {
                    nail1GlossNr = [[[changes1 objectAtIndex:i] objectForKey:@"pic_nr"] intValue];
                }
            }
            
            if(nail1GlossNr == -1)
            {
                nail1GlossNr = 0;
                singleGloss.image = nil;
                nail1Gloss.image = nil;
            }
            else
            {
                nail1ColorNr = nail1GlossNr;
                if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
                {
                    singleColor.image = [UIImage imageNamed:[NSString stringWithFormat:@"nailC%d@2x.png", nail1GlossNr]];
                    nail1Color.image = [UIImage imageNamed:[NSString stringWithFormat:@"smallnailC%d@2x.png", nail1GlossNr]];
                    
                    nail1Gloss.image = [UIImage imageNamed:[NSString stringWithFormat:@"smallnailG%d@2x.png", nail1GlossNr]];
                    singleGloss.image = [UIImage imageNamed:[NSString stringWithFormat:@"nailG%d@2x.png", nail1GlossNr]];
                }
                else
                {
                    singleColor.image = [UIImage imageNamed:[NSString stringWithFormat:@"nailC%d.png", nail1GlossNr]];
                    nail1Color.image = [UIImage imageNamed:[NSString stringWithFormat:@"smallnailC%d.png", nail1GlossNr]];
                
                    nail1Gloss.image = [UIImage imageNamed:[NSString stringWithFormat:@"smallnailG%d.png", nail1GlossNr]];
                    singleGloss.image = [UIImage imageNamed:[NSString stringWithFormat:@"nailG%d.png", nail1GlossNr]];
                }
            }
        }
        else if([[md objectForKey:@"type"] isEqualToString:@"pattern"])
        {
            [changes1 removeLastObject];
            
            nail1PatternNr = -1;
            for(int i = 0; i < [changes1 count]; i++)
            {
                if([[[changes1 objectAtIndex:i] objectForKey:@"type"] isEqualToString:@"pattern"])
                {
                    nail1PatternNr = [[[changes1 objectAtIndex:i] objectForKey:@"pic_nr"] intValue];
                }
            }
            
            if(nail1PatternNr == -1)
            {
                singlePattern.image = nil;
                nail1Pattern.image = nil;
            }
            else
            {
                if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
                {
                    singlePattern.image = [UIImage imageNamed:[NSString stringWithFormat:@"nailP%d@2x.png", nail1PatternNr]];
                    nail1Pattern.image = [UIImage imageNamed:[NSString stringWithFormat:@"smallnailP%d@2x.png",nail1PatternNr]];
                }
                else
                {
                    singlePattern.image = [UIImage imageNamed:[NSString stringWithFormat:@"nailP%d.png", nail1PatternNr]];
                    nail1Pattern.image = [UIImage imageNamed:[NSString stringWithFormat:@"smallnailP%d.png",nail1PatternNr]];
                }
            }
        }
        else if([[md objectForKey:@"type"] isEqualToString:@"tip"])
        {
            [changes1 removeLastObject];
            
            nail1TipNr = -1;
            for(int i = 0; i < [changes1 count]; i++)
            {
                if([[[changes1 objectAtIndex:i] objectForKey:@"type"] isEqualToString:@"tip"])
                {
                    nail1TipNr = [[[changes1 objectAtIndex:i] objectForKey:@"pic_nr"] intValue];
                }
            }
            
            if(nail1TipNr == -1)
            {
                singleTip.image = nil;
                nail1Tip.image = nil;
            }
            else
            {
                if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
                {
                    singleTip.image = [UIImage imageNamed:[NSString stringWithFormat:@"nailT%d@2x.png", nail1TipNr]];
                    nail1Tip.image = [UIImage imageNamed:[NSString stringWithFormat:@"smallnailT%d@2x.png",nail1TipNr]];
                }
                else
                {
                    singleTip.image = [UIImage imageNamed:[NSString stringWithFormat:@"nailT%d.png", nail1TipNr]];
                    nail1Tip.image = [UIImage imageNamed:[NSString stringWithFormat:@"smallnailT%d.png",nail1TipNr]];
                }
            }
        }
        else if([[md objectForKey:@"type"] isEqualToString:@"hand"])
        {
            [changes1 removeLastObject];
            
            hand = 1;
            for(int i = 0; i < [changes1 count]; i++)
            {
                if([[[changes1 objectAtIndex:i] objectForKey:@"type"] isEqualToString:@"hand"])
                {
                    hand = [[[changes1 objectAtIndex:i] objectForKey:@"pic_nr"] intValue];
                }
            }
            
            handImgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"hand%d.png", hand]];
            fingerImgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"finger%d.png", hand]];
        }
        else if([[md objectForKey:@"type"] isEqualToString:@"background"])
        {
            [changes1 removeLastObject];
            
            background = 1;
            for(int i = 0; i < [changes1 count]; i++)
            {
                if([[[changes1 objectAtIndex:i] objectForKey:@"type"] isEqualToString:@"background"])
                {
                    background = [[[changes1 objectAtIndex:i] objectForKey:@"pic_nr"] intValue];
                }
            }

            if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
            {
                backgroundImgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d~ipad.png", background]];
                background2ImgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d~ipad.png", background]];
            }
            else if([UIScreen mainScreen].bounds.size.height == 568)
            {
                backgroundImgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d_568.png", background]];
                background2ImgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d_568.png", background]];
            }
            else
            {
                backgroundImgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d.png", background]];
                background2ImgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d.png", background]];
            }
        }
        
        if(md == nil)
        {
            nail1ColorNr = 1;
            if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
            {
                singleColor.image = [UIImage imageNamed:[NSString stringWithFormat:@"nailC%d@2x.png", nail1ColorNr]];
                nail1Color.image = [UIImage imageNamed:[NSString stringWithFormat:@"smallnailC%d@2x.png", nail1ColorNr]];
            }
            else
            {
                singleColor.image = [UIImage imageNamed:[NSString stringWithFormat:@"nailC%d.png", nail1ColorNr]];
                nail1Color.image = [UIImage imageNamed:[NSString stringWithFormat:@"smallnailC%d.png", nail1ColorNr]];
            }
        }
    }
    else if(nailSelected == 2)
    {
        NSMutableDictionary *md = [changes2 lastObject];
        
        if([[md objectForKey:@"type"] isEqualToString:@"extras"])
        {
            for(UIView *view in [singleTip subviews])
            {
                if(view.tag > 0 && view.tag == [extras2Array count])
                {
                    [view removeFromSuperview];
                }
            }
            [extras2Array removeLastObject];
            [changes2 removeLastObject];
        }
        else if([[md objectForKey:@"type"] isEqualToString:@"gallery_picture"])
        {
            for(UIView *view in [singleTip subviews])
            {
                if(view.tag > 0 && view.tag == [extras2Array count])
                {
                    [view removeFromSuperview];
                }
            }
            [extras2Array removeLastObject];
            [changes2 removeLastObject];
        }
        else if([[md objectForKey:@"type"] isEqualToString:@"color"])
        {
            [changes2 removeLastObject];
            
            nail2ColorNr = 1;
            for(int i = 0; i < [changes2 count]; i++)
            {
                if([[[changes2 objectAtIndex:i] objectForKey:@"type"] isEqualToString:@"color"])
                {
                    nail2ColorNr = [[[changes2 objectAtIndex:i] objectForKey:@"pic_nr"] intValue];
                }
            }
            
            if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
            {
                singleColor.image = [UIImage imageNamed:[NSString stringWithFormat:@"nailC%d@2x.png", nail2ColorNr]];
                nail2Color.image = [UIImage imageNamed:[NSString stringWithFormat:@"smallnailC%d@2x.png", nail2ColorNr]];
            }
            else
            {
                singleColor.image = [UIImage imageNamed:[NSString stringWithFormat:@"nailC%d.png", nail2ColorNr]];
                nail2Color.image = [UIImage imageNamed:[NSString stringWithFormat:@"smallnailC%d.png", nail2ColorNr]];
            }
            
            if(nail2GlossNr != 0)
            {
                nail2GlossNr = nail2ColorNr;
                if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
                {
                    nail2Gloss.image = [UIImage imageNamed:[NSString stringWithFormat:@"smallnailG%d@2x.png", nail2GlossNr]];
                    singleGloss.image = [UIImage imageNamed:[NSString stringWithFormat:@"nailG%d@2x.png", nail2ColorNr]];
                }
                else
                {
                    nail2Gloss.image = [UIImage imageNamed:[NSString stringWithFormat:@"smallnailG%d.png", nail2GlossNr]];
                    singleGloss.image = [UIImage imageNamed:[NSString stringWithFormat:@"nailG%d.png", nail2ColorNr]];
                }
            }
        }
        else if([[md objectForKey:@"type"] isEqualToString:@"gloss"])
        {
            [changes2 removeLastObject];
            
            nail2GlossNr = -1;
            for(int i = 0; i < [changes2 count]; i++)
            {
                if([[[changes2 objectAtIndex:i] objectForKey:@"type"] isEqualToString:@"gloss"])
                {
                    nail2GlossNr = [[[changes2 objectAtIndex:i] objectForKey:@"pic_nr"] intValue];
                }
            }
            
            if(nail2GlossNr == -1)
            {
                nail2GlossNr = 0;
                singleGloss.image = nil;
                nail2Gloss.image = nil;
            }
            else
            {
                nail2ColorNr = nail2GlossNr;
                if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
                {
                    singleColor.image = [UIImage imageNamed:[NSString stringWithFormat:@"nailC%d@2x.png", nail2GlossNr]];
                    nail2Color.image = [UIImage imageNamed:[NSString stringWithFormat:@"smallnailC%d@2x.png", nail2GlossNr]];
                    
                    nail2Gloss.image = [UIImage imageNamed:[NSString stringWithFormat:@"smallnailG%d@2x.png", nail2GlossNr]];
                    singleGloss.image = [UIImage imageNamed:[NSString stringWithFormat:@"nailG%d@2x.png", nail2GlossNr]];
                }
                else
                {
                    singleColor.image = [UIImage imageNamed:[NSString stringWithFormat:@"nailC%d.png", nail2GlossNr]];
                    nail2Color.image = [UIImage imageNamed:[NSString stringWithFormat:@"smallnailC%d.png", nail2GlossNr]];
                    
                    nail2Gloss.image = [UIImage imageNamed:[NSString stringWithFormat:@"smallnailG%d.png", nail2GlossNr]];
                    singleGloss.image = [UIImage imageNamed:[NSString stringWithFormat:@"nailG%d.png", nail2GlossNr]];
                }
            }
        }
        else if([[md objectForKey:@"type"] isEqualToString:@"pattern"])
        {
            [changes2 removeLastObject];
            
            nail2PatternNr = -1;
            for(int i = 0; i < [changes2 count]; i++)
            {
                if([[[changes2 objectAtIndex:i] objectForKey:@"type"] isEqualToString:@"pattern"])
                {
                    nail2PatternNr = [[[changes2 objectAtIndex:i] objectForKey:@"pic_nr"] intValue];
                }
            }
            
            if(nail2PatternNr == -1)
            {
                singlePattern.image = nil;
                nail2Pattern.image = nil;
            }
            else
            {
                if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
                {
                    singlePattern.image = [UIImage imageNamed:[NSString stringWithFormat:@"nailP%d@2x.png", nail2PatternNr]];
                    nail2Pattern.image = [UIImage imageNamed:[NSString stringWithFormat:@"smallnailP%d@2x.png",nail2PatternNr]];
                }
                else
                {
                    singlePattern.image = [UIImage imageNamed:[NSString stringWithFormat:@"nailP%d.png", nail2PatternNr]];
                    nail2Pattern.image = [UIImage imageNamed:[NSString stringWithFormat:@"smallnailP%d.png",nail2PatternNr]];
                }
            }
        }
        else if([[md objectForKey:@"type"] isEqualToString:@"tip"])
        {
            [changes2 removeLastObject];
            
            nail2TipNr = -1;
            for(int i = 0; i < [changes2 count]; i++)
            {
                if([[[changes2 objectAtIndex:i] objectForKey:@"type"] isEqualToString:@"tip"])
                {
                    nail2TipNr = [[[changes2 objectAtIndex:i] objectForKey:@"pic_nr"] intValue];
                }
            }
            
            if(nail2TipNr == -1)
            {
                singleTip.image = nil;
                nail2Tip.image = nil;
            }
            else
            {
                if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
                {
                    singleTip.image = [UIImage imageNamed:[NSString stringWithFormat:@"nailT%d@2x.png", nail2TipNr]];
                    nail2Tip.image = [UIImage imageNamed:[NSString stringWithFormat:@"smallnailT%d@2x.png",nail2TipNr]];
                }
                else
                {
                    singleTip.image = [UIImage imageNamed:[NSString stringWithFormat:@"nailT%d.png", nail2TipNr]];
                    nail2Tip.image = [UIImage imageNamed:[NSString stringWithFormat:@"smallnailT%d.png",nail2TipNr]];
                }
            }
        }
        else if([[md objectForKey:@"type"] isEqualToString:@"hand"])
        {
            [changes2 removeLastObject];
            
            hand = 1;
            for(int i = 0; i < [changes2 count]; i++)
            {
                if([[[changes2 objectAtIndex:i] objectForKey:@"type"] isEqualToString:@"hand"])
                {
                    hand = [[[changes2 objectAtIndex:i] objectForKey:@"pic_nr"] intValue];
                }
            }
            
            handImgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"hand%d.png", hand]];
            fingerImgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"finger%d.png", hand]];
        }
        else if([[md objectForKey:@"type"] isEqualToString:@"background"])
        {
            [changes2 removeLastObject];
            
            background = 1;
            for(int i = 0; i < [changes2 count]; i++)
            {
                if([[[changes2 objectAtIndex:i] objectForKey:@"type"] isEqualToString:@"background"])
                {
                    background = [[[changes2 objectAtIndex:i] objectForKey:@"pic_nr"] intValue];
                }
            }
            
            if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
            {
                backgroundImgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d~ipad.png", background]];
                background2ImgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d~ipad.png", background]];
            }
            else if([UIScreen mainScreen].bounds.size.height == 568)
            {
                backgroundImgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d_568.png", background]];
                background2ImgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d_568.png", background]];
            }
            else
            {
                backgroundImgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d.png", background]];
                background2ImgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d.png", background]];
            }
        }
        
        if(md == nil)
        {
            nail2ColorNr = 1;
            if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
            {
                singleColor.image = [UIImage imageNamed:[NSString stringWithFormat:@"nailC%d@2x.png", nail2ColorNr]];
                nail2Color.image = [UIImage imageNamed:[NSString stringWithFormat:@"smallnailC%d@2x.png", nail2ColorNr]];
            }
            else
            {
                singleColor.image = [UIImage imageNamed:[NSString stringWithFormat:@"nailC%d.png", nail2ColorNr]];
                nail2Color.image = [UIImage imageNamed:[NSString stringWithFormat:@"smallnailC%d.png", nail2ColorNr]];
            }
        }
    }
    else if(nailSelected == 3)
    {
        NSMutableDictionary *md = [changes3 lastObject];
        
        if([[md objectForKey:@"type"] isEqualToString:@"extras"])
        {
            for(UIView *view in [singleTip subviews])
            {
                if(view.tag > 0 && view.tag == [extras3Array count])
                {
                    [view removeFromSuperview];
                }
            }
            [extras3Array removeLastObject];
            [changes3 removeLastObject];
        }
        else if([[md objectForKey:@"type"] isEqualToString:@"gallery_picture"])
        {
            for(UIView *view in [singleTip subviews])
            {
                if(view.tag > 0 && view.tag == [extras3Array count])
                {
                    [view removeFromSuperview];
                }
            }
            [extras3Array removeLastObject];
            [changes3 removeLastObject];
        }
        else if([[md objectForKey:@"type"] isEqualToString:@"color"])
        {
            [changes3 removeLastObject];
            
            nail3ColorNr = 1;
            for(int i = 0; i < [changes3 count]; i++)
            {
                if([[[changes3 objectAtIndex:i] objectForKey:@"type"] isEqualToString:@"color"])
                {
                    nail3ColorNr = [[[changes3 objectAtIndex:i] objectForKey:@"pic_nr"] intValue];
                }
            }
            
            if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
            {
                singleColor.image = [UIImage imageNamed:[NSString stringWithFormat:@"nailC%d@2x.png", nail3ColorNr]];
                nail3Color.image = [UIImage imageNamed:[NSString stringWithFormat:@"smallnailC%d@2x.png", nail3ColorNr]];
            }
            else
            {
                singleColor.image = [UIImage imageNamed:[NSString stringWithFormat:@"nailC%d.png", nail3ColorNr]];
                nail3Color.image = [UIImage imageNamed:[NSString stringWithFormat:@"smallnailC%d.png", nail3ColorNr]];
            }
            
            if(nail3GlossNr != 0)
            {
                nail3GlossNr = nail3ColorNr;
                if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
                {
                    nail3Gloss.image = [UIImage imageNamed:[NSString stringWithFormat:@"smallnailG%d@2x.png", nail3GlossNr]];
                    singleGloss.image = [UIImage imageNamed:[NSString stringWithFormat:@"nailG%d@2x.png", nail3ColorNr]];
                }
                else
                {
                    nail3Gloss.image = [UIImage imageNamed:[NSString stringWithFormat:@"smallnailG%d.png", nail3GlossNr]];
                    singleGloss.image = [UIImage imageNamed:[NSString stringWithFormat:@"nailG%d.png", nail3ColorNr]];
                }
            }
        }
        else if([[md objectForKey:@"type"] isEqualToString:@"gloss"])
        {
            [changes3 removeLastObject];
            
            nail3GlossNr = -1;
            for(int i = 0; i < [changes3 count]; i++)
            {
                if([[[changes3 objectAtIndex:i] objectForKey:@"type"] isEqualToString:@"gloss"])
                {
                    nail3GlossNr = [[[changes3 objectAtIndex:i] objectForKey:@"pic_nr"] intValue];
                }
            }
            
            if(nail3GlossNr == -1)
            {
                nail3GlossNr = 0;
                singleGloss.image = nil;
                nail3Gloss.image = nil;
            }
            else
            {
                nail3ColorNr = nail3GlossNr;
                if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
                {
                    singleColor.image = [UIImage imageNamed:[NSString stringWithFormat:@"nailC%d@2x.png", nail3GlossNr]];
                    nail3Color.image = [UIImage imageNamed:[NSString stringWithFormat:@"smallnailC%d@2x.png", nail3GlossNr]];
                    
                    nail3Gloss.image = [UIImage imageNamed:[NSString stringWithFormat:@"smallnailG%d@2x.png", nail3GlossNr]];
                    singleGloss.image = [UIImage imageNamed:[NSString stringWithFormat:@"nailG%d@2x.png", nail3GlossNr]];
                }
                else
                {
                    singleColor.image = [UIImage imageNamed:[NSString stringWithFormat:@"nailC%d.png", nail3GlossNr]];
                    nail3Color.image = [UIImage imageNamed:[NSString stringWithFormat:@"smallnailC%d.png", nail3GlossNr]];
                    
                    nail3Gloss.image = [UIImage imageNamed:[NSString stringWithFormat:@"smallnailG%d.png", nail3GlossNr]];
                    singleGloss.image = [UIImage imageNamed:[NSString stringWithFormat:@"nailG%d.png", nail3GlossNr]];
                }
            }
        }
        else if([[md objectForKey:@"type"] isEqualToString:@"pattern"])
        {
            [changes3 removeLastObject];
            
            nail3PatternNr = -1;
            for(int i = 0; i < [changes3 count]; i++)
            {
                if([[[changes3 objectAtIndex:i] objectForKey:@"type"] isEqualToString:@"pattern"])
                {
                    nail3PatternNr = [[[changes3 objectAtIndex:i] objectForKey:@"pic_nr"] intValue];
                }
            }
            
            if(nail3PatternNr == -1)
            {
                singlePattern.image = nil;
                nail3Pattern.image = nil;
            }
            else
            {
                if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
                {
                    singlePattern.image = [UIImage imageNamed:[NSString stringWithFormat:@"nailP%d@2x.png", nail3PatternNr]];
                    nail3Pattern.image = [UIImage imageNamed:[NSString stringWithFormat:@"smallnailP%d@2x.png",nail3PatternNr]];
                }
                else
                {
                    singlePattern.image = [UIImage imageNamed:[NSString stringWithFormat:@"nailP%d.png", nail3PatternNr]];
                    nail3Pattern.image = [UIImage imageNamed:[NSString stringWithFormat:@"smallnailP%d.png",nail3PatternNr]];
                }
            }
        }
        else if([[md objectForKey:@"type"] isEqualToString:@"tip"])
        {
            [changes3 removeLastObject];
            
            nail3TipNr = -1;
            for(int i = 0; i < [changes3 count]; i++)
            {
                if([[[changes3 objectAtIndex:i] objectForKey:@"type"] isEqualToString:@"tip"])
                {
                    nail3TipNr = [[[changes3 objectAtIndex:i] objectForKey:@"pic_nr"] intValue];
                }
            }
            
            if(nail3TipNr == -1)
            {
                singleTip.image = nil;
                nail3Tip.image = nil;
            }
            else
            {
                if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
                {
                    singleTip.image = [UIImage imageNamed:[NSString stringWithFormat:@"nailT%d@2x.png", nail3TipNr]];
                    nail3Tip.image = [UIImage imageNamed:[NSString stringWithFormat:@"smallnailT%d@2x.png",nail3TipNr]];
                }
                else
                {
                    singleTip.image = [UIImage imageNamed:[NSString stringWithFormat:@"nailT%d.png", nail3TipNr]];
                    nail3Tip.image = [UIImage imageNamed:[NSString stringWithFormat:@"smallnailT%d.png",nail3TipNr]];
                }
            }
        }
        else if([[md objectForKey:@"type"] isEqualToString:@"hand"])
        {
            [changes3 removeLastObject];
            
            hand = 1;
            for(int i = 0; i < [changes3 count]; i++)
            {
                if([[[changes3 objectAtIndex:i] objectForKey:@"type"] isEqualToString:@"hand"])
                {
                    hand = [[[changes3 objectAtIndex:i] objectForKey:@"pic_nr"] intValue];
                }
            }
            
            handImgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"hand%d.png", hand]];
            fingerImgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"finger%d.png", hand]];
        }
        else if([[md objectForKey:@"type"] isEqualToString:@"background"])
        {
            [changes3 removeLastObject];
            
            background = 1;
            for(int i = 0; i < [changes3 count]; i++)
            {
                if([[[changes3 objectAtIndex:i] objectForKey:@"type"] isEqualToString:@"background"])
                {
                    background = [[[changes3 objectAtIndex:i] objectForKey:@"pic_nr"] intValue];
                }
            }
            
            if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
            {
                backgroundImgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d~ipad.png", background]];
                background2ImgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d~ipad.png", background]];
            }
            else if([UIScreen mainScreen].bounds.size.height == 568)
            {
                backgroundImgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d_568.png", background]];
                background2ImgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d_568.png", background]];
            }
            else
            {
                backgroundImgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d.png", background]];
                background2ImgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d.png", background]];
            }
        }
        
        if(md == nil)
        {
            nail3ColorNr = 1;
            if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
            {
                singleColor.image = [UIImage imageNamed:[NSString stringWithFormat:@"nailC%d@2x.png", nail3ColorNr]];
                nail3Color.image = [UIImage imageNamed:[NSString stringWithFormat:@"smallnailC%d@2x.png", nail3ColorNr]];
            }
            else
            {
                singleColor.image = [UIImage imageNamed:[NSString stringWithFormat:@"nailC%d.png", nail3ColorNr]];
                nail3Color.image = [UIImage imageNamed:[NSString stringWithFormat:@"smallnailC%d.png", nail3ColorNr]];
            }
        }
    }
    else if(nailSelected == 4)
    {
        NSMutableDictionary *md = [changes4 lastObject];
        
        if([[md objectForKey:@"type"] isEqualToString:@"extras"])
        {
            for(UIView *view in [singleTip subviews])
            {
                if(view.tag > 0 && view.tag == [extras4Array count])
                {
                    [view removeFromSuperview];
                }
            }
            [extras4Array removeLastObject];
            [changes4 removeLastObject];
        }
        else if([[md objectForKey:@"type"] isEqualToString:@"gallery_picture"])
        {
            for(UIView *view in [singleTip subviews])
            {
                if(view.tag > 0 && view.tag == [extras4Array count])
                {
                    [view removeFromSuperview];
                }
            }
            [extras4Array removeLastObject];
            [changes4 removeLastObject];
        }
        else if([[md objectForKey:@"type"] isEqualToString:@"color"])
        {
            [changes4 removeLastObject];
            
            nail4ColorNr = 1;
            for(int i = 0; i < [changes4 count]; i++)
            {
                if([[[changes4 objectAtIndex:i] objectForKey:@"type"] isEqualToString:@"color"])
                {
                    nail4ColorNr = [[[changes4 objectAtIndex:i] objectForKey:@"pic_nr"] intValue];
                }
            }
            
            if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
            {
                singleColor.image = [UIImage imageNamed:[NSString stringWithFormat:@"nailC%d@2x.png", nail4ColorNr]];
                nail4Color.image = [UIImage imageNamed:[NSString stringWithFormat:@"smallnailC%d@2x.png", nail4ColorNr]];
            }
            else
            {
                singleColor.image = [UIImage imageNamed:[NSString stringWithFormat:@"nailC%d.png", nail4ColorNr]];
                nail4Color.image = [UIImage imageNamed:[NSString stringWithFormat:@"smallnailC%d.png", nail4ColorNr]];
            }
            
            if(nail4GlossNr != 0)
            {
                nail4GlossNr = nail4ColorNr;
                if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
                {
                    nail4Gloss.image = [UIImage imageNamed:[NSString stringWithFormat:@"smallnailG%d@2x.png", nail4GlossNr]];
                    singleGloss.image = [UIImage imageNamed:[NSString stringWithFormat:@"nailG%d@2x.png", nail4ColorNr]];
                }
                else
                {
                    nail4Gloss.image = [UIImage imageNamed:[NSString stringWithFormat:@"smallnailG%d.png", nail4GlossNr]];
                    singleGloss.image = [UIImage imageNamed:[NSString stringWithFormat:@"nailG%d.png", nail4ColorNr]];
                }
            }
        }
        else if([[md objectForKey:@"type"] isEqualToString:@"gloss"])
        {
            [changes4 removeLastObject];
            
            nail4GlossNr = -1;
            for(int i = 0; i < [changes4 count]; i++)
            {
                if([[[changes4 objectAtIndex:i] objectForKey:@"type"] isEqualToString:@"gloss"])
                {
                    nail4GlossNr = [[[changes4 objectAtIndex:i] objectForKey:@"pic_nr"] intValue];
                }
            }
            
            if(nail4GlossNr == -1)
            {
                nail4GlossNr = 0;
                singleGloss.image = nil;
                nail4Gloss.image = nil;
            }
            else
            {
                nail4ColorNr = nail4GlossNr;
                if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
                {
                    singleColor.image = [UIImage imageNamed:[NSString stringWithFormat:@"nailC%d@2x.png", nail4GlossNr]];
                    nail4Color.image = [UIImage imageNamed:[NSString stringWithFormat:@"smallnailC%d@2x.png", nail4GlossNr]];
                    
                    nail4Gloss.image = [UIImage imageNamed:[NSString stringWithFormat:@"smallnailG%d@2x.png", nail4GlossNr]];
                    singleGloss.image = [UIImage imageNamed:[NSString stringWithFormat:@"nailG%d@2x.png", nail4GlossNr]];
                }
                else
                {
                    singleColor.image = [UIImage imageNamed:[NSString stringWithFormat:@"nailC%d.png", nail4GlossNr]];
                    nail4Color.image = [UIImage imageNamed:[NSString stringWithFormat:@"smallnailC%d.png", nail4GlossNr]];
                    
                    nail4Gloss.image = [UIImage imageNamed:[NSString stringWithFormat:@"smallnailG%d.png", nail4GlossNr]];
                    singleGloss.image = [UIImage imageNamed:[NSString stringWithFormat:@"nailG%d.png", nail4GlossNr]];
                }
            }
        }
        else if([[md objectForKey:@"type"] isEqualToString:@"pattern"])
        {
            [changes4 removeLastObject];
            
            nail4PatternNr = -1;
            for(int i = 0; i < [changes4 count]; i++)
            {
                if([[[changes4 objectAtIndex:i] objectForKey:@"type"] isEqualToString:@"pattern"])
                {
                    nail4PatternNr = [[[changes4 objectAtIndex:i] objectForKey:@"pic_nr"] intValue];
                }
            }
            
            if(nail4PatternNr == -1)
            {
                singlePattern.image = nil;
                nail4Pattern.image = nil;
            }
            else
            {
                if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
                {
                    singlePattern.image = [UIImage imageNamed:[NSString stringWithFormat:@"nailP%d@2x.png", nail4PatternNr]];
                    nail4Pattern.image = [UIImage imageNamed:[NSString stringWithFormat:@"smallnailP%d@2x.png",nail4PatternNr]];
                }
                else
                {
                    singlePattern.image = [UIImage imageNamed:[NSString stringWithFormat:@"nailP%d.png", nail4PatternNr]];
                    nail4Pattern.image = [UIImage imageNamed:[NSString stringWithFormat:@"smallnailP%d.png",nail4PatternNr]];
                }
            }
        }
        else if([[md objectForKey:@"type"] isEqualToString:@"tip"])
        {
            [changes4 removeLastObject];
            
            nail4TipNr = -1;
            for(int i = 0; i < [changes4 count]; i++)
            {
                if([[[changes4 objectAtIndex:i] objectForKey:@"type"] isEqualToString:@"tip"])
                {
                    nail4TipNr = [[[changes4 objectAtIndex:i] objectForKey:@"pic_nr"] intValue];
                }
            }
            
            if(nail4TipNr == -1)
            {
                singleTip.image = nil;
                nail4Tip.image = nil;
            }
            else
            {
                if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
                {
                    singleTip.image = [UIImage imageNamed:[NSString stringWithFormat:@"nailT%d@2x.png", nail4TipNr]];
                    nail4Tip.image = [UIImage imageNamed:[NSString stringWithFormat:@"smallnailT%d@2x.png",nail4TipNr]];
                }
                else
                {
                    singleTip.image = [UIImage imageNamed:[NSString stringWithFormat:@"nailT%d.png", nail4TipNr]];
                    nail4Tip.image = [UIImage imageNamed:[NSString stringWithFormat:@"smallnailT%d.png",nail4TipNr]];
                }
            }
        }
        else if([[md objectForKey:@"type"] isEqualToString:@"hand"])
        {
            [changes4 removeLastObject];
            
            hand = 1;
            for(int i = 0; i < [changes4 count]; i++)
            {
                if([[[changes4 objectAtIndex:i] objectForKey:@"type"] isEqualToString:@"hand"])
                {
                    hand = [[[changes4 objectAtIndex:i] objectForKey:@"pic_nr"] intValue];
                }
            }
            
            handImgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"hand%d.png", hand]];
            fingerImgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"finger%d.png", hand]];
        }
        else if([[md objectForKey:@"type"] isEqualToString:@"background"])
        {
            [changes4 removeLastObject];
            
            background = 1;
            for(int i = 0; i < [changes4 count]; i++)
            {
                if([[[changes4 objectAtIndex:i] objectForKey:@"type"] isEqualToString:@"background"])
                {
                    background = [[[changes4 objectAtIndex:i] objectForKey:@"pic_nr"] intValue];
                }
            }
            
            if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
            {
                backgroundImgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d~ipad.png", background]];
                background2ImgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d~ipad.png", background]];
            }
            else if([UIScreen mainScreen].bounds.size.height == 568)
            {
                backgroundImgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d_568.png", background]];
                background2ImgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d_568.png", background]];
            }
            else
            {
                backgroundImgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d.png", background]];
                background2ImgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d.png", background]];
            }
        }
        
        if(md == nil)
        {
            nail4ColorNr = 1;
            if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
            {
                singleColor.image = [UIImage imageNamed:[NSString stringWithFormat:@"nailC%d@2x.png", nail4ColorNr]];
                nail4Color.image = [UIImage imageNamed:[NSString stringWithFormat:@"smallnailC%d@2x.png", nail4ColorNr]];
            }
            else
            {
                singleColor.image = [UIImage imageNamed:[NSString stringWithFormat:@"nailC%d.png", nail4ColorNr]];
                nail4Color.image = [UIImage imageNamed:[NSString stringWithFormat:@"smallnailC%d.png", nail4ColorNr]];
            }
        }
    }
    else if(nailSelected == 5)
    {
        NSMutableDictionary *md = [changes5 lastObject];
        
        if([[md objectForKey:@"type"] isEqualToString:@"extras"])
        {
            for(UIView *view in [singleTip subviews])
            {
                if(view.tag > 0 && view.tag == [extras5Array count])
                {
                    [view removeFromSuperview];
                }
            }
            [extras5Array removeLastObject];
            [changes5 removeLastObject];
        }
        else if([[md objectForKey:@"type"] isEqualToString:@"gallery_picture"])
        {
            for(UIView *view in [singleTip subviews])
            {
                if(view.tag > 0 && view.tag == [extras5Array count])
                {
                    [view removeFromSuperview];
                }
            }
            [extras5Array removeLastObject];
            [changes5 removeLastObject];
        }
        else if([[md objectForKey:@"type"] isEqualToString:@"color"])
        {
            [changes5 removeLastObject];
            
            nail5ColorNr = 1;
            for(int i = 0; i < [changes5 count]; i++)
            {
                if([[[changes5 objectAtIndex:i] objectForKey:@"type"] isEqualToString:@"color"])
                {
                    nail5ColorNr = [[[changes5 objectAtIndex:i] objectForKey:@"pic_nr"] intValue];
                }
            }
            
            if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
            {
                singleColor.image = [UIImage imageNamed:[NSString stringWithFormat:@"nailC%d@2x.png", nail5ColorNr]];
                nail5Color.image = [UIImage imageNamed:[NSString stringWithFormat:@"smallnailC%d@2x.png", nail5ColorNr]];
            }
            else
            {
                singleColor.image = [UIImage imageNamed:[NSString stringWithFormat:@"nailC%d.png", nail5ColorNr]];
                nail5Color.image = [UIImage imageNamed:[NSString stringWithFormat:@"smallnailC%d.png", nail5ColorNr]];
            }
            
            if(nail5GlossNr != 0)
            {
                nail5GlossNr = nail5ColorNr;
                if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
                {
                    nail5Gloss.image = [UIImage imageNamed:[NSString stringWithFormat:@"smallnailG%d@2x.png", nail5GlossNr]];
                    singleGloss.image = [UIImage imageNamed:[NSString stringWithFormat:@"nailG%d@2x.png", nail5ColorNr]];
                }
                else
                {
                    nail5Gloss.image = [UIImage imageNamed:[NSString stringWithFormat:@"smallnailG%d.png", nail5GlossNr]];
                    singleGloss.image = [UIImage imageNamed:[NSString stringWithFormat:@"nailG%d.png", nail5ColorNr]];
                }
            }
        }
        else if([[md objectForKey:@"type"] isEqualToString:@"gloss"])
        {
            [changes5 removeLastObject];
            
            nail5GlossNr = -1;
            for(int i = 0; i < [changes5 count]; i++)
            {
                if([[[changes5 objectAtIndex:i] objectForKey:@"type"] isEqualToString:@"gloss"])
                {
                    nail5GlossNr = [[[changes5 objectAtIndex:i] objectForKey:@"pic_nr"] intValue];
                }
            }
            
            if(nail5GlossNr == -1)
            {
                nail5GlossNr = 0;
                singleGloss.image = nil;
                nail5Gloss.image = nil;
            }
            else
            {
                nail5ColorNr = nail5GlossNr;
                if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
                {
                    singleColor.image = [UIImage imageNamed:[NSString stringWithFormat:@"nailC%d@2x.png", nail5GlossNr]];
                    nail5Color.image = [UIImage imageNamed:[NSString stringWithFormat:@"smallnailC%d@2x.png", nail5GlossNr]];
                    
                    nail5Gloss.image = [UIImage imageNamed:[NSString stringWithFormat:@"smallnailG%d@2x.png", nail5GlossNr]];
                    singleGloss.image = [UIImage imageNamed:[NSString stringWithFormat:@"nailG%d@2x.png", nail5GlossNr]];
                }
                else
                {
                    singleColor.image = [UIImage imageNamed:[NSString stringWithFormat:@"nailC%d.png", nail5GlossNr]];
                    nail5Color.image = [UIImage imageNamed:[NSString stringWithFormat:@"smallnailC%d.png", nail5GlossNr]];
                    
                    nail5Gloss.image = [UIImage imageNamed:[NSString stringWithFormat:@"smallnailG%d.png", nail5GlossNr]];
                    singleGloss.image = [UIImage imageNamed:[NSString stringWithFormat:@"nailG%d.png", nail5GlossNr]];
                }
            }
        }
        else if([[md objectForKey:@"type"] isEqualToString:@"pattern"])
        {
            [changes5 removeLastObject];
            
            nail5PatternNr = -1;
            for(int i = 0; i < [changes5 count]; i++)
            {
                if([[[changes5 objectAtIndex:i] objectForKey:@"type"] isEqualToString:@"pattern"])
                {
                    nail5PatternNr = [[[changes5 objectAtIndex:i] objectForKey:@"pic_nr"] intValue];
                }
            }
            
            if(nail5PatternNr == -1)
            {
                singlePattern.image = nil;
                nail5Pattern.image = nil;
            }
            else
            {
                if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
                {
                    singlePattern.image = [UIImage imageNamed:[NSString stringWithFormat:@"nailP%d@2x.png", nail5PatternNr]];
                    nail5Pattern.image = [UIImage imageNamed:[NSString stringWithFormat:@"smallnailP%d@2x.png",nail5PatternNr]];
                }
                else
                {
                    singlePattern.image = [UIImage imageNamed:[NSString stringWithFormat:@"nailP%d.png", nail5PatternNr]];
                    nail5Pattern.image = [UIImage imageNamed:[NSString stringWithFormat:@"smallnailP%d.png",nail5PatternNr]];
                }
            }
        }
        else if([[md objectForKey:@"type"] isEqualToString:@"tip"])
        {
            [changes5 removeLastObject];
            
            nail5TipNr = -1;
            for(int i = 0; i < [changes5 count]; i++)
            {
                if([[[changes5 objectAtIndex:i] objectForKey:@"type"] isEqualToString:@"tip"])
                {
                    nail5TipNr = [[[changes5 objectAtIndex:i] objectForKey:@"pic_nr"] intValue];
                }
            }
            
            if(nail5TipNr == -1)
            {
                singleTip.image = nil;
                nail5Tip.image = nil;
            }
            else
            {
                if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
                {
                    singleTip.image = [UIImage imageNamed:[NSString stringWithFormat:@"nailT%d@2x.png", nail5TipNr]];
                    nail5Tip.image = [UIImage imageNamed:[NSString stringWithFormat:@"smallnailT%d@2x.png",nail5TipNr]];
                }
                else
                {
                    singleTip.image = [UIImage imageNamed:[NSString stringWithFormat:@"nailT%d.png", nail5TipNr]];
                    nail5Tip.image = [UIImage imageNamed:[NSString stringWithFormat:@"smallnailT%d.png",nail5TipNr]];
                }
            }
        }
        else if([[md objectForKey:@"type"] isEqualToString:@"hand"])
        {
            [changes5 removeLastObject];
            
            hand = 1;
            for(int i = 0; i < [changes5 count]; i++)
            {
                if([[[changes5 objectAtIndex:i] objectForKey:@"type"] isEqualToString:@"hand"])
                {
                    hand = [[[changes5 objectAtIndex:i] objectForKey:@"pic_nr"] intValue];
                }
            }
            
            handImgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"hand%d.png", hand]];
            fingerImgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"finger%d.png", hand]];
        }
        else if([[md objectForKey:@"type"] isEqualToString:@"background"])
        {
            [changes5 removeLastObject];
            
            background = 1;
            for(int i = 0; i < [changes5 count]; i++)
            {
                if([[[changes5 objectAtIndex:i] objectForKey:@"type"] isEqualToString:@"background"])
                {
                    background = [[[changes5 objectAtIndex:i] objectForKey:@"pic_nr"] intValue];
                }
            }
            
            if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
            {
                backgroundImgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d~ipad.png", background]];
                background2ImgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d~ipad.png", background]];
            }
            else if([UIScreen mainScreen].bounds.size.height == 568)
            {
                backgroundImgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d_568.png", background]];
                background2ImgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d_568.png", background]];
            }
            else
            {
                backgroundImgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d.png", background]];
                background2ImgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d.png", background]];
            }
        }
        
        if(md == nil)
        {
            nail5ColorNr = 1;
            if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
            {
                singleColor.image = [UIImage imageNamed:[NSString stringWithFormat:@"nailC%d@2x.png", nail5ColorNr]];
                nail5Color.image = [UIImage imageNamed:[NSString stringWithFormat:@"smallnailC%d@2x.png", nail5ColorNr]];
            }
            else
            {
                singleColor.image = [UIImage imageNamed:[NSString stringWithFormat:@"nailC%d.png", nail5ColorNr]];
                nail5Color.image = [UIImage imageNamed:[NSString stringWithFormat:@"smallnailC%d.png", nail5ColorNr]];
            }
        }
    }
}

- (IBAction)applyToAll:(id)sender
{
    if(nailSelected == 1)
    {
        [changes2 release], changes2 = nil;
        changes2 = [[NSMutableArray alloc] initWithArray:changes1];
        [changes3 release], changes3 = nil;
        changes3 = [[NSMutableArray alloc] initWithArray:changes1];
        [changes4 release], changes4 = nil;
        changes4 = [[NSMutableArray alloc] initWithArray:changes1];
        [changes5 release], changes5 = nil;
        changes5 = [[NSMutableArray alloc] initWithArray:changes1];
        
        [extras2Array release], extras2Array = nil;
        extras2Array = [[NSMutableArray alloc] initWithArray:extras1Array];
        [extras3Array release], extras3Array = nil;
        extras3Array = [[NSMutableArray alloc] initWithArray:extras1Array];
        [extras4Array release], extras4Array = nil;
        extras4Array = [[NSMutableArray alloc] initWithArray:extras1Array];
        [extras5Array release], extras5Array = nil;
        extras5Array = [[NSMutableArray alloc] initWithArray:extras1Array];
        
        nail2ColorNr = nail1ColorNr;
        nail3ColorNr = nail1ColorNr;
        nail4ColorNr = nail1ColorNr;
        nail5ColorNr = nail1ColorNr;
        
        nail2GlossNr = nail1GlossNr;
        nail3GlossNr = nail1GlossNr;
        nail4GlossNr = nail1GlossNr;
        nail5GlossNr = nail1GlossNr;
        
        nail2PatternNr = nail1PatternNr;
        nail3PatternNr = nail1PatternNr;
        nail4PatternNr = nail1PatternNr;
        nail5PatternNr = nail1PatternNr;
        
        nail2TipNr = nail1TipNr;
        nail3TipNr = nail1TipNr;
        nail4TipNr = nail1TipNr;
        nail5TipNr = nail1TipNr;
    }
    else if(nailSelected == 2)
    {
        [changes1 release], changes1 = nil;
        changes1 = [[NSMutableArray alloc] initWithArray:changes2];
        [changes3 release], changes3 = nil;
        changes3 = [[NSMutableArray alloc] initWithArray:changes2];
        [changes4 release], changes4 = nil;
        changes4 = [[NSMutableArray alloc] initWithArray:changes2];
        [changes5 release], changes5 = nil;
        changes5 = [[NSMutableArray alloc] initWithArray:changes2];
        
        [extras1Array release], extras1Array = nil;
        extras1Array = [[NSMutableArray alloc] initWithArray:extras2Array];
        [extras3Array release], extras3Array = nil;
        extras3Array = [[NSMutableArray alloc] initWithArray:extras2Array];
        [extras4Array release], extras4Array = nil;
        extras4Array = [[NSMutableArray alloc] initWithArray:extras2Array];
        [extras5Array release], extras5Array = nil;
        extras5Array = [[NSMutableArray alloc] initWithArray:extras2Array];
        
        nail1ColorNr = nail2ColorNr;
        nail3ColorNr = nail2ColorNr;
        nail4ColorNr = nail2ColorNr;
        nail5ColorNr = nail2ColorNr;
        
        nail1GlossNr = nail2GlossNr;
        nail3GlossNr = nail2GlossNr;
        nail4GlossNr = nail2GlossNr;
        nail5GlossNr = nail2GlossNr;
        
        nail1PatternNr = nail2PatternNr;
        nail3PatternNr = nail2PatternNr;
        nail4PatternNr = nail2PatternNr;
        nail5PatternNr = nail2PatternNr;
        
        nail1TipNr = nail2TipNr;
        nail3TipNr = nail2TipNr;
        nail4TipNr = nail2TipNr;
        nail5TipNr = nail2TipNr;
    }
    else if(nailSelected == 3)
    {
        [changes1 release], changes1 = nil;
        changes1 = [[NSMutableArray alloc] initWithArray:changes3];
        [changes2 release], changes2 = nil;
        changes2 = [[NSMutableArray alloc] initWithArray:changes3];
        [changes4 release], changes4 = nil;
        changes4 = [[NSMutableArray alloc] initWithArray:changes3];
        [changes5 release], changes5 = nil;
        changes5 = [[NSMutableArray alloc] initWithArray:changes3];
        
        [extras1Array release], extras1Array = nil;
        extras1Array = [[NSMutableArray alloc] initWithArray:extras3Array];
        [extras2Array release], extras2Array = nil;
        extras2Array = [[NSMutableArray alloc] initWithArray:extras3Array];
        [extras4Array release], extras4Array = nil;
        extras4Array = [[NSMutableArray alloc] initWithArray:extras3Array];
        [extras5Array release], extras5Array = nil;
        extras5Array = [[NSMutableArray alloc] initWithArray:extras3Array];
        
        nail1ColorNr = nail3ColorNr;
        nail2ColorNr = nail3ColorNr;
        nail4ColorNr = nail3ColorNr;
        nail5ColorNr = nail3ColorNr;
        
        nail1GlossNr = nail3GlossNr;
        nail2GlossNr = nail3GlossNr;
        nail4GlossNr = nail3GlossNr;
        nail5GlossNr = nail3GlossNr;
        
        nail1PatternNr = nail3PatternNr;
        nail2PatternNr = nail3PatternNr;
        nail4PatternNr = nail3PatternNr;
        nail5PatternNr = nail3PatternNr;
        
        nail1TipNr = nail3TipNr;
        nail2TipNr = nail3TipNr;
        nail4TipNr = nail3TipNr;
        nail5TipNr = nail3TipNr;
    }
    else if(nailSelected == 4)
    {
        [changes1 release], changes1 = nil;
        changes1 = [[NSMutableArray alloc] initWithArray:changes4];
        [changes2 release], changes2 = nil;
        changes2 = [[NSMutableArray alloc] initWithArray:changes4];
        [changes3 release], changes3 = nil;
        changes3 = [[NSMutableArray alloc] initWithArray:changes4];
        [changes5 release], changes5 = nil;
        changes5 = [[NSMutableArray alloc] initWithArray:changes4];
        
        [extras1Array release], extras1Array = nil;
        extras1Array = [[NSMutableArray alloc] initWithArray:extras4Array];
        [extras2Array release], extras2Array = nil;
        extras2Array = [[NSMutableArray alloc] initWithArray:extras4Array];
        [extras3Array release], extras3Array = nil;
        extras3Array = [[NSMutableArray alloc] initWithArray:extras4Array];
        [extras5Array release], extras5Array = nil;
        extras5Array = [[NSMutableArray alloc] initWithArray:extras4Array];
        
        nail1ColorNr = nail4ColorNr;
        nail2ColorNr = nail4ColorNr;
        nail3ColorNr = nail4ColorNr;
        nail5ColorNr = nail4ColorNr;
        
        nail1GlossNr = nail4GlossNr;
        nail2GlossNr = nail4GlossNr;
        nail3GlossNr = nail4GlossNr;
        nail5GlossNr = nail4GlossNr;
        
        nail1PatternNr = nail4PatternNr;
        nail2PatternNr = nail4PatternNr;
        nail3PatternNr = nail4PatternNr;
        nail5PatternNr = nail4PatternNr;
        
        nail1TipNr = nail4TipNr;
        nail2TipNr = nail4TipNr;
        nail3TipNr = nail4TipNr;
        nail5TipNr = nail4TipNr;
    }
    else if(nailSelected == 5)
    {
        [changes1 release], changes1 = nil;
        changes1 = [[NSMutableArray alloc] initWithArray:changes5];
        [changes2 release], changes2 = nil;
        changes2 = [[NSMutableArray alloc] initWithArray:changes5];
        [changes3 release], changes3 = nil;
        changes3 = [[NSMutableArray alloc] initWithArray:changes5];
        [changes4 release], changes4 = nil;
        changes4 = [[NSMutableArray alloc] initWithArray:changes4];
        
        [extras1Array release], extras1Array = nil;
        extras1Array = [[NSMutableArray alloc] initWithArray:extras5Array];
        [extras2Array release], extras2Array = nil;
        extras2Array = [[NSMutableArray alloc] initWithArray:extras5Array];
        [extras3Array release], extras3Array = nil;
        extras3Array = [[NSMutableArray alloc] initWithArray:extras5Array];
        [extras4Array release], extras4Array = nil;
        extras4Array = [[NSMutableArray alloc] initWithArray:extras5Array];
        
        nail1ColorNr = nail5ColorNr;
        nail2ColorNr = nail5ColorNr;
        nail3ColorNr = nail5ColorNr;
        nail4ColorNr = nail5ColorNr;
        
        nail1GlossNr = nail5GlossNr;
        nail2GlossNr = nail5GlossNr;
        nail3GlossNr = nail5GlossNr;
        nail4GlossNr = nail5GlossNr;
        
        nail1PatternNr = nail5PatternNr;
        nail2PatternNr = nail5PatternNr;
        nail3PatternNr = nail5PatternNr;
        nail4PatternNr = nail5PatternNr;
        
        nail1TipNr = nail5TipNr;
        nail2TipNr = nail5TipNr;
        nail3TipNr = nail5TipNr;
        nail4TipNr = nail5TipNr;
    }
    
    
    [(AppDelegate*)[[UIApplication sharedApplication] delegate] playSoundEffect:1];
    [self updateExtras];
    
    nailSelected = 0;
    for(UIView *view in [secondScroll subviews])
        [view removeFromSuperview];
    for(UIButton *b in [menuScroll subviews])
        [b setSelected:NO];
    
    lastAccessory = -1;
    [secondScroll setContentOffset:CGPointMake(0, 0)];
    greyImgView.hidden = YES;
    
    [UIView transitionWithView:singleFinger duration:0.5 options:UIViewAnimationOptionCurveEaseOut animations:^
     {
         singleFinger.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
     } completion:^(BOOL finished) {
         [singleFinger removeFromSuperview];
     }];
    
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        nail1Color.image = [UIImage imageNamed:[NSString stringWithFormat:@"smallnailC%d@2x.png", nail1ColorNr]];
        nail2Color.image = [UIImage imageNamed:[NSString stringWithFormat:@"smallnailC%d@2x.png", nail2ColorNr]];
        nail3Color.image = [UIImage imageNamed:[NSString stringWithFormat:@"smallnailC%d@2x.png", nail3ColorNr]];
        nail4Color.image = [UIImage imageNamed:[NSString stringWithFormat:@"smallnailC%d@2x.png", nail4ColorNr]];
        nail5Color.image = [UIImage imageNamed:[NSString stringWithFormat:@"smallnailC%d@2x.png", nail5ColorNr]];
        
        nail1Gloss.image = [UIImage imageNamed:[NSString stringWithFormat:@"smallnailG%d@2x.png", nail1GlossNr]];
        nail2Gloss.image = [UIImage imageNamed:[NSString stringWithFormat:@"smallnailG%d@2x.png", nail2GlossNr]];
        nail3Gloss.image = [UIImage imageNamed:[NSString stringWithFormat:@"smallnailG%d@2x.png", nail3GlossNr]];
        nail4Gloss.image = [UIImage imageNamed:[NSString stringWithFormat:@"smallnailG%d@2x.png", nail4GlossNr]];
        nail5Gloss.image = [UIImage imageNamed:[NSString stringWithFormat:@"smallnailG%d@2x.png", nail5GlossNr]];
        
        nail1Pattern.image = [UIImage imageNamed:[NSString stringWithFormat:@"smallnailP%d@2x.png",nail1PatternNr]];
        nail2Pattern.image = [UIImage imageNamed:[NSString stringWithFormat:@"smallnailP%d@2x.png", nail2PatternNr]];
        nail3Pattern.image = [UIImage imageNamed:[NSString stringWithFormat:@"smallnailP%d@2x.png", nail3PatternNr]];
        nail4Pattern.image = [UIImage imageNamed:[NSString stringWithFormat:@"smallnailP%d@2x.png", nail4PatternNr]];
        nail5Pattern.image = [UIImage imageNamed:[NSString stringWithFormat:@"smallnailP%d@2x.png", nail5PatternNr]];
        
        nail1Tip.image = [UIImage imageNamed:[NSString stringWithFormat:@"smallnailT%d@2x.png",nail1TipNr]];
        nail2Tip.image = [UIImage imageNamed:[NSString stringWithFormat:@"smallnailT%d@2x.png", nail2TipNr]];
        nail3Tip.image = [UIImage imageNamed:[NSString stringWithFormat:@"smallnailT%d@2x.png", nail3TipNr]];
        nail4Tip.image = [UIImage imageNamed:[NSString stringWithFormat:@"smallnailT%d@2x.png", nail4TipNr]];
        nail5Tip.image = [UIImage imageNamed:[NSString stringWithFormat:@"smallnailT%d@2x.png", nail5TipNr]];
    }
    else
    {
        nail1Color.image = [UIImage imageNamed:[NSString stringWithFormat:@"smallnailC%d.png", nail1ColorNr]];
        nail2Color.image = [UIImage imageNamed:[NSString stringWithFormat:@"smallnailC%d.png", nail2ColorNr]];
        nail3Color.image = [UIImage imageNamed:[NSString stringWithFormat:@"smallnailC%d.png", nail3ColorNr]];
        nail4Color.image = [UIImage imageNamed:[NSString stringWithFormat:@"smallnailC%d.png", nail4ColorNr]];
        nail5Color.image = [UIImage imageNamed:[NSString stringWithFormat:@"smallnailC%d.png", nail5ColorNr]];
        
        nail1Gloss.image = [UIImage imageNamed:[NSString stringWithFormat:@"smallnailG%d.png", nail1GlossNr]];
        nail2Gloss.image = [UIImage imageNamed:[NSString stringWithFormat:@"smallnailG%d.png", nail2GlossNr]];
        nail3Gloss.image = [UIImage imageNamed:[NSString stringWithFormat:@"smallnailG%d.png", nail3GlossNr]];
        nail4Gloss.image = [UIImage imageNamed:[NSString stringWithFormat:@"smallnailG%d.png", nail4GlossNr]];
        nail5Gloss.image = [UIImage imageNamed:[NSString stringWithFormat:@"smallnailG%d.png", nail5GlossNr]];
        
        nail1Pattern.image = [UIImage imageNamed:[NSString stringWithFormat:@"smallnailP%d.png",nail1PatternNr]];
        nail2Pattern.image = [UIImage imageNamed:[NSString stringWithFormat:@"smallnailP%d.png", nail2PatternNr]];
        nail3Pattern.image = [UIImage imageNamed:[NSString stringWithFormat:@"smallnailP%d.png", nail3PatternNr]];
        nail4Pattern.image = [UIImage imageNamed:[NSString stringWithFormat:@"smallnailP%d.png", nail4PatternNr]];
        nail5Pattern.image = [UIImage imageNamed:[NSString stringWithFormat:@"smallnailP%d.png", nail5PatternNr]];
        
        nail1Tip.image = [UIImage imageNamed:[NSString stringWithFormat:@"smallnailT%d.png",nail1TipNr]];
        nail2Tip.image = [UIImage imageNamed:[NSString stringWithFormat:@"smallnailT%d.png", nail2TipNr]];
        nail3Tip.image = [UIImage imageNamed:[NSString stringWithFormat:@"smallnailT%d.png", nail3TipNr]];
        nail4Tip.image = [UIImage imageNamed:[NSString stringWithFormat:@"smallnailT%d.png", nail4TipNr]];
        nail5Tip.image = [UIImage imageNamed:[NSString stringWithFormat:@"smallnailT%d.png", nail5TipNr]];
    }
}

#pragma mark - Touches

- (void)touchesBegan:(NSSet*)touches withEvent:(UIEvent*)event
{
}

- (void)touchesMoved:(NSSet*)touches withEvent:(UIEvent*)event
{
    CGPoint touchPoint = [[touches anyObject] locationInView:singleTip];
    UITouch *touch = [touches anyObject];
    if([touch view].tag > 0)
    {
        [touch view].center = touchPoint;
        
        int tagLabel = [touch view].tag;
        
        if(nailSelected == 1)
        {
            NSMutableDictionary *md = [[NSMutableDictionary alloc] init];
            
            [md setObject:[[extras1Array objectAtIndex:tagLabel - 1] objectForKey:@"pic"] forKey:@"pic"];
            [md setObject:NSStringFromCGRect([touch view].frame) forKey:@"frame"];
            [extras1Array replaceObjectAtIndex:tagLabel - 1 withObject:md];
            
        }
        else if(nailSelected == 2)
        {
            NSMutableDictionary *md = [[NSMutableDictionary alloc] init];
            [md setObject:[[extras2Array objectAtIndex:tagLabel - 1] objectForKey:@"pic"] forKey:@"pic"];
            [md setObject:NSStringFromCGRect([touch view].frame) forKey:@"frame"];
            [extras2Array replaceObjectAtIndex:tagLabel - 1 withObject:md];
        }
        else if(nailSelected == 3)
        {
            NSMutableDictionary *md = [[NSMutableDictionary alloc] init];
            [md setObject:[[extras3Array objectAtIndex:tagLabel - 1] objectForKey:@"pic"] forKey:@"pic"];
            [md setObject:NSStringFromCGRect([touch view].frame) forKey:@"frame"];
            [extras3Array replaceObjectAtIndex:tagLabel - 1 withObject:md];
        }
        else if(nailSelected == 4)
        {
            NSMutableDictionary *md = [[NSMutableDictionary alloc] init];
            [md setObject:[[extras4Array objectAtIndex:tagLabel - 1] objectForKey:@"pic"] forKey:@"pic"];
            [md setObject:NSStringFromCGRect([touch view].frame) forKey:@"frame"];
            [extras4Array replaceObjectAtIndex:tagLabel - 1 withObject:md];
        }
        else if(nailSelected == 5)
        {
            NSMutableDictionary *md = [[NSMutableDictionary alloc] init];
            [md setObject:[[extras5Array objectAtIndex:tagLabel - 1] objectForKey:@"pic"] forKey:@"pic"];
            [md setObject:NSStringFromCGRect([touch view].frame) forKey:@"frame"];
            [extras5Array replaceObjectAtIndex:tagLabel - 1 withObject:md];
        }
    }
}

- (void)touchesEnded:(NSSet*)touches withEvent:(UIEvent*)event
{
}

#pragma mark - Extras

- (void)addMaskToHoleView
{
    CGRect bounds = singleTip.bounds;
    CALayer *maskLayer = [CALayer layer];
    maskLayer.frame = bounds;
    maskLayer.contents = (id)[[UIImage imageNamed:@"nailC1.png"] CGImage];
    singleTip.layer.mask = maskLayer;
    
    bounds = nail1Tip.bounds;
    maskLayer = [CALayer layer];
    maskLayer.frame = bounds;
    maskLayer.contents = (id)[[UIImage imageNamed:@"smallnailC1.png"] CGImage];
    nail1Tip.layer.mask = maskLayer;
    
    bounds = nail2Tip.bounds;
    maskLayer = [CALayer layer];
    maskLayer.frame = bounds;
    maskLayer.contents = (id)[[UIImage imageNamed:@"smallnailC1.png"] CGImage];
    nail2Tip.layer.mask = maskLayer;
    
    bounds = nail3Tip.bounds;
    maskLayer = [CALayer layer];
    maskLayer.frame = bounds;
    maskLayer.contents = (id)[[UIImage imageNamed:@"smallnailC1.png"] CGImage];
    nail3Tip.layer.mask = maskLayer;

    bounds = nail4Tip.bounds;
    maskLayer = [CALayer layer];
    maskLayer.frame = bounds;
    maskLayer.contents = (id)[[UIImage imageNamed:@"smallnailC1.png"] CGImage];
    nail4Tip.layer.mask = maskLayer;

    bounds = nail5Tip.bounds;
    maskLayer = [CALayer layer];
    maskLayer.frame = bounds;
    maskLayer.contents = (id)[[UIImage imageNamed:@"smallnailC1.png"] CGImage];
    nail5Tip.layer.mask = maskLayer;
}

- (void)updateExtras
{
    //    if(nailSelected == 1)
    //    {
    for(UIView *view in [nail1Tip subviews])
        [view removeFromSuperview];
    
    for(int i = 0; i < [extras1Array count]; i++)
    {
        UIImageView *label = [[UIImageView alloc] init];
        
        CGRect frame = CGRectFromString([[extras1Array objectAtIndex:i] objectForKey:@"frame"]);
        
        // Hassan
        int tempTag = [[[extras1Array objectAtIndex:i] objectForKey:@"pic"] intValue];
        
        if (tempTag == 5000) {
            
            frame.origin.x      *= 0.05;
            frame.origin.y      *= 0.05;
            
            frame.size.width    *= 0.2;
            frame.size.height   *= 0.2;
            
        } else {
            
            frame.origin.x      *= 0.1192;
            frame.origin.y      *= 0.1058;
            frame.size.width    *= 0.1192;
            frame.size.height   *= 0.1192;
            
        }
        
        label.frame = frame;
        
        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
            label.image = [UIImage imageNamed:[NSString stringWithFormat:@"x%d@2x.png", [[[extras1Array objectAtIndex:i] objectForKey:@"pic"] intValue]]];
        
        else
            label.image = [UIImage imageNamed:[NSString stringWithFormat:@"x%d.png", [[[extras1Array objectAtIndex:i] objectForKey:@"pic"] intValue]]];
        
        if (tempTag == 5000) {
        
            label.image                 = (UIImage *)[[extras1Array objectAtIndex:i] objectForKey:@"gallery_pic_1"];
            
        } else if (tempTag == 9000) {
            
            nail1Tip.backgroundColor = (UIColor *)[[extras1Array objectAtIndex:i] objectForKey:@"bg_nail_color"];
            
        }
        
        label.tag = i + 1;
        [nail1Tip addSubview:label];
        [label release];
    }
    //    }
    //    else if(nailSelected == 2)
    //    {
    for(UIView *view in [nail2Tip subviews])
        [view removeFromSuperview];
    
    for(int i = 0; i < [extras2Array count]; i++)
    {
        UIImageView *label = [[UIImageView alloc] init];
        
        CGRect frame = CGRectFromString([[extras2Array objectAtIndex:i] objectForKey:@"frame"]);
        
        // Hassan
        int tempTag = [[[extras2Array objectAtIndex:i] objectForKey:@"pic"] intValue];
        
        if (tempTag == 5000) {
            
            frame.origin.x      *= 0.05;
            frame.origin.y      *= 0.05;
            
            frame.size.width    *= 0.2;
            frame.size.height   *= 0.2;
            
        } else {
            
            frame.origin.x      *= 0.1324;
            frame.origin.y      *= 0.1204;
            frame.size.width    *= 0.1324;
            frame.size.height   *= 0.1324;
            
        }
        
        label.frame = frame;
        
        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
            label.image = [UIImage imageNamed:[NSString stringWithFormat:@"x%d@2x.png", [[[extras2Array objectAtIndex:i] objectForKey:@"pic"] intValue]]];
        else
            label.image = [UIImage imageNamed:[NSString stringWithFormat:@"x%d.png", [[[extras2Array objectAtIndex:i] objectForKey:@"pic"] intValue]]];
        
        if (tempTag == 5000) {
            
            label.image                 = (UIImage *)[[extras2Array objectAtIndex:i] objectForKey:@"gallery_pic_1"];
            
        } else if (tempTag == 9000) {
            
            nail2Tip.backgroundColor = (UIColor *)[[extras2Array objectAtIndex:i] objectForKey:@"bg_nail_color"];
        }
        
        label.tag = i + 1;
        [nail2Tip addSubview:label];
        [label release];
    }
    //    }
    //    else if(nailSelected == 3)
    //    {
    for(UIView *view in [nail3Tip subviews])
        [view removeFromSuperview];
    
    for(int i = 0; i < [extras3Array count]; i++)
    {
        UIImageView *label = [[UIImageView alloc] init];
        
        CGRect frame = CGRectFromString([[extras3Array objectAtIndex:i] objectForKey:@"frame"]);
        
        // Hassan
        int tempTag = [[[extras3Array objectAtIndex:i] objectForKey:@"pic"] intValue];
        
        if (tempTag == 5000) {
            
            frame.origin.x      *= 0.05;
            frame.origin.y      *= 0.05;
            
            frame.size.width    *= 0.2;
            frame.size.height   *= 0.2;
            
        } else {
            
            frame.origin.x      *= 0.1324;
            frame.origin.y      *= 0.124;
            frame.size.width    *= 0.1324;
            frame.size.height   *= 0.1324;
            
        }
        
        label.frame = frame;
        
        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
            label.image = [UIImage imageNamed:[NSString stringWithFormat:@"x%d@2x.png", [[[extras3Array objectAtIndex:i] objectForKey:@"pic"] intValue]]];
        else
            label.image = [UIImage imageNamed:[NSString stringWithFormat:@"x%d.png", [[[extras3Array objectAtIndex:i] objectForKey:@"pic"] intValue]]];
        
        if (tempTag == 5000) {
        
            label.image                 = (UIImage *)[[extras3Array objectAtIndex:i] objectForKey:@"gallery_pic_1"];
            
        } else if (tempTag == 9000) {
            
            nail3Tip.backgroundColor = (UIColor *)[[extras3Array objectAtIndex:i] objectForKey:@"bg_nail_color"];
        }
        
        label.tag = i + 1;
        [nail3Tip addSubview:label];
        [label release];
    }
    //    }
    //    else if(nailSelected == 4)
    //    {
    for(UIView *view in [nail4Tip subviews])
        [view removeFromSuperview];
    
    for(int i = 0; i < [extras4Array count]; i++)
    {
        UIImageView *label = [[UIImageView alloc] init];
        
        CGRect frame = CGRectFromString([[extras4Array objectAtIndex:i] objectForKey:@"frame"]);
        
        // Hassan
        int tempTag = [[[extras4Array objectAtIndex:i] objectForKey:@"pic"] intValue];
        
        if (tempTag == 5000) {
            
            frame.origin.x      *= 0.05;
            frame.origin.y      *= 0.05;
            
            frame.size.width    *= 0.2;
            frame.size.height   *= 0.2;
            
        } else {
            
            frame.origin.x      *= 0.1324;
            frame.origin.y      *= 0.1204;
            frame.size.width    *= 0.1324;
            frame.size.height   *= 0.1324;
            
        }
        
        label.frame = frame;
        
        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
            label.image = [UIImage imageNamed:[NSString stringWithFormat:@"x%d@2x.png", [[[extras4Array objectAtIndex:i] objectForKey:@"pic"] intValue]]];
        else
            label.image = [UIImage imageNamed:[NSString stringWithFormat:@"x%d.png", [[[extras4Array objectAtIndex:i] objectForKey:@"pic"] intValue]]];
        
        if (tempTag == 5000) {
        
            label.image                 = (UIImage *)[[extras4Array objectAtIndex:i] objectForKey:@"gallery_pic_1"];
            
        } else if (tempTag == 9000) {
            
            nail4Tip.backgroundColor = (UIColor *)[[extras4Array objectAtIndex:i] objectForKey:@"bg_nail_color"];
        }
        
        label.tag = i + 1;
        [nail4Tip addSubview:label];
        [label release];
    }
    //    }
    //    else if(nailSelected == 5)
    //    {
    for(UIView *view in [nail5Tip subviews])
        [view removeFromSuperview];
    
    for(int i = 0; i < [extras5Array count]; i++)
    {
        UIImageView *label = [[UIImageView alloc] init];
        
        CGRect frame = CGRectFromString([[extras5Array objectAtIndex:i] objectForKey:@"frame"]);
        
        // Hassan
        int tempTag = [[[extras5Array objectAtIndex:i] objectForKey:@"pic"] intValue];
        
        if (tempTag == 5000) {
            
            frame.origin.x      *= 0.05;
            frame.origin.y      *= 0.05;
            
            frame.size.width    *= 0.2;
            frame.size.height   *= 0.2;
            
        } else {
            
            frame.origin.x      *= 0.139;
            frame.origin.y      *= 0.124;
            frame.size.width    *= 0.139;
            frame.size.height   *= 0.139;
            
        }
        
        label.frame = frame;
        
        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
            label.image = [UIImage imageNamed:[NSString stringWithFormat:@"x%d@2x.png", [[[extras5Array objectAtIndex:i] objectForKey:@"pic"] intValue]]];
        else
            label.image = [UIImage imageNamed:[NSString stringWithFormat:@"x%d.png", [[[extras5Array objectAtIndex:i] objectForKey:@"pic"] intValue]]];
        
        if (tempTag == 5000) {
            
            label.image                 = (UIImage *)[[extras5Array objectAtIndex:i] objectForKey:@"gallery_pic_1"];
            
        } else if (tempTag == 9000) {
            
            nail5Tip.backgroundColor = (UIColor *)[[extras5Array objectAtIndex:i] objectForKey:@"bg_nail_color"];
        }
        
        label.tag = i + 1;
        [nail5Tip addSubview:label];
        [label release];
    }
    //    }
}

#pragma mark - Reload Scroll

- (void)reloadScroll
{
    for(UIView *view in [secondScroll subviews])
        [view removeFromSuperview];
    
    if([((AppDelegate *)[[UIApplication sharedApplication] delegate]) nailsLocked] == NO)
    {
        [unlockSparkle1 removeFromSuperview];
        [unlockSparkle2 removeFromSuperview];
        [unlockEv1 removeFromSuperview];
        [unlockEv2 removeFromSuperview];
    }

    if(lastAccessory == 0)
    {
        for(int i = 0; i <= 20; i++)
        {
            if(i == 0)
            {
                UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(5 + 2 * i + 50 * i, 3, 50, 50)];
                if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
                    button.frame = CGRectMake(15 + 2 * i + 80 * i, 1, 65, 100);
                
                [button setImage:[UIImage imageNamed:@"cancel.png"] forState:UIControlStateNormal];
                button.tag = lastAccessory;
                [button addTarget:self action:@selector(cancelClick:) forControlEvents:UIControlEventTouchUpInside];
                [secondScroll addSubview:button];
                [button release];
            }
            else
            {
                if(i > 6 && [((AppDelegate *)[[UIApplication sharedApplication] delegate]) colorLocked] == YES)
                {
                    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(5 + 2 * i + 50 * i, 3, 50, 50)];
                    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
                        button.frame = CGRectMake(15 + 2 * i + 80 * i, 1, 65, 100);
                    
                    button.tag = 1;
                    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
                        [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"smallnailC%d@2x.png", i]] forState:UIControlStateNormal];
                    else
                        [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"smallnailC%d.png", i]] forState:UIControlStateNormal];
                    [button addTarget:((AppDelegate *)[[UIApplication sharedApplication] delegate]).store action:@selector(productClick:) forControlEvents:UIControlEventTouchUpInside];
                    
                    UIImageView *locked = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 20, 25)];
                    locked.image = [UIImage imageNamed:@"lockSmall.png"];
                    [button addSubview:locked];
                    [locked release];
                    
                    
                    [secondScroll addSubview:button];
                    [button release];
                }
                else
                {
                    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(5 + 2 * i + 50 * i, 3, 50, 50)];
                    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
                        button.frame = CGRectMake(15 + 2 * i + 80 * i, 1, 65, 100);
                    
                    button.tag = i;
                    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
                        [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"smallnailC%d@2x.png", i]] forState:UIControlStateNormal];
                    else
                        [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"smallnailC%d.png", i]] forState:UIControlStateNormal];
                    [button addTarget:self action:@selector(colorChosen:) forControlEvents:UIControlEventTouchUpInside];
                    [secondScroll addSubview:button];
                    [button release];
                }
            }
        }
        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
            secondScroll.contentSize = CGSizeMake(80 * 21 + 15 + 2 * 22 + 15, secondScroll.frame.size.height);
        else
            secondScroll.contentSize = CGSizeMake(50 * 21 + 5 + 2 * 22 + 5, secondScroll.frame.size.height);
        
    }
    else if(lastAccessory == 1)
    {
        for(int i = 0; i <= 20; i++)
        {
            if(i == 0)
            {
                UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(5 + 2 * i + 50 * i, 3, 50, 50)];
                if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
                    button.frame = CGRectMake(15 + 2 * i + 80 * i, 1, 65, 100);
                
                [button setImage:[UIImage imageNamed:@"cancel.png"] forState:UIControlStateNormal];
                button.tag = lastAccessory;
                [button addTarget:self action:@selector(cancelClick:) forControlEvents:UIControlEventTouchUpInside];
                [secondScroll addSubview:button];
                [button release];
            }
            else
            {
                if(i > 6 && [((AppDelegate *)[[UIApplication sharedApplication] delegate]) glossLocked] == YES)
                {
                    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(5 + 2 * i + 50 * i, 3, 50, 50)];
                    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
                        button.frame = CGRectMake(15 + 2 * i + 80 * i, 1, 65, 100);
                    
                    button.tag = 3;
                    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
                        [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"smallnailG%d@2x.png", i]] forState:UIControlStateNormal];
                    else
                        [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"smallnailG%d.png", i]] forState:UIControlStateNormal];
                    [button addTarget:((AppDelegate *)[[UIApplication sharedApplication] delegate]).store action:@selector(productClick:) forControlEvents:UIControlEventTouchUpInside];
                    
                    UIImageView *locked = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 20, 25)];
                    locked.image = [UIImage imageNamed:@"lockSmall.png"];
                    [button addSubview:locked];
                    [locked release];
                    
                    
                    [secondScroll addSubview:button];
                    [button release];
                }
                else
                {
                    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(5 + 2 * i + 50 * i, 3, 50, 50)];
                    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
                        button.frame = CGRectMake(15 + 2 * i + 80 * i, 1, 65, 100);
                    
                    button.tag = i;
                    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
                        [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"smallnailG%d@2x.png", i]] forState:UIControlStateNormal];
                    else
                        [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"smallnailG%d.png", i]] forState:UIControlStateNormal];
                    [button addTarget:self action:@selector(glossChosen:) forControlEvents:UIControlEventTouchUpInside];
                    [secondScroll addSubview:button];
                    [button release];
                }
            }
        }
        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
           secondScroll.contentSize = CGSizeMake(80 * 21 + 15 + 2 * 22 + 15, secondScroll.frame.size.height);
        else
            secondScroll.contentSize = CGSizeMake(50 * 21 + 5 + 2 * 22 + 5, secondScroll.frame.size.height);
        
    }
    else if(lastAccessory == 2)
    {
        for(int i = 0; i <= 20; i++)
        {
            if(i == 0)
            {
                UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(5 + 2 * i + 50 * i, 3, 50, 50)];
                if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
                    button.frame = CGRectMake(15 + 2 * i + 80 * i, 1, 65, 100);
                
                [button setImage:[UIImage imageNamed:@"cancel.png"] forState:UIControlStateNormal];
                button.tag = lastAccessory;
                [button addTarget:self action:@selector(cancelClick:) forControlEvents:UIControlEventTouchUpInside];
                [secondScroll addSubview:button];
                [button release];
            }
            else
            {
                if(i > 6 && [((AppDelegate *)[[UIApplication sharedApplication] delegate]) patternLocked] == YES)
                {
                    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(5 + 2 * i + 50 * i, 3, 50, 50)];
                    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
                        button.frame = CGRectMake(15 + 2 * i + 80 * i, 1, 65, 100);
                    
                    button.tag = 4;
                    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
                        [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"smallnailP%d@2x.png", i]] forState:UIControlStateNormal];
                    else
                        [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"smallnailP%d.png", i]] forState:UIControlStateNormal];
                    [button addTarget:((AppDelegate *)[[UIApplication sharedApplication] delegate]).store action:@selector(productClick:) forControlEvents:UIControlEventTouchUpInside];
                    
                    UIImageView *locked = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 20, 25)];
                    locked.image = [UIImage imageNamed:@"lockSmall.png"];
                    [button addSubview:locked];
                    [locked release];
                    
                    
                    [secondScroll addSubview:button];
                    [button release];
                }
                else
                {
                    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(5 + 2 * i + 50 * i, 3, 50, 50)];
                    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
                        button.frame = CGRectMake(15 + 2 * i + 80 * i, 1, 65, 100);
                    
                    button.tag = i;
                    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
                        [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"smallnailP%d@2x.png", i]] forState:UIControlStateNormal];
                    else
                        [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"smallnailP%d.png", i]] forState:UIControlStateNormal];
                    [button addTarget:self action:@selector(patternChosen:) forControlEvents:UIControlEventTouchUpInside];
                    [secondScroll addSubview:button];
                    [button release];
                }
            }
        }
        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
            secondScroll.contentSize = CGSizeMake(80 * 21 + 15 + 2 * 22 + 15, secondScroll.frame.size.height);
        else
            secondScroll.contentSize = CGSizeMake(50 * 21 + 5 + 2 * 22 + 5, secondScroll.frame.size.height);
        
    }
    else if(lastAccessory == 3)
    {
        for(int i = 0; i <= 20; i++)
        {
            if(i == 0)
            {
                UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(5 + 2 * i + 50 * i, 3, 50, 50)];
                if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
                    button.frame = CGRectMake(15 + 2 * i + 80 * i, 1, 65, 100);
                
                [button setImage:[UIImage imageNamed:@"cancel.png"] forState:UIControlStateNormal];
                button.tag = lastAccessory;
                [button addTarget:self action:@selector(cancelClick:) forControlEvents:UIControlEventTouchUpInside];
                [secondScroll addSubview:button];
                [button release];
            }
            else
            {
                if(i > 6 && [((AppDelegate *)[[UIApplication sharedApplication] delegate]) tipLocked] == YES)
                {
                    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(5 + 2 * i + 50 * i, 3, 50, 50)];
                    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
                        button.frame = CGRectMake(15 + 2 * i + 80 * i, 1, 65, 100);
                    
                    button.tag = 5;
                    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
                        [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"smallnailT%d@2x.png", i]] forState:UIControlStateNormal];
                    else
                        [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"smallnailT%d.png", i]] forState:UIControlStateNormal];
                    [button addTarget:((AppDelegate *)[[UIApplication sharedApplication] delegate]).store action:@selector(productClick:) forControlEvents:UIControlEventTouchUpInside];
                    
                    UIImageView *locked = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 20, 25)];
                    locked.image = [UIImage imageNamed:@"lockSmall.png"];
                    [button addSubview:locked];
                    [locked release];
                    
                    
                    [secondScroll addSubview:button];
                    [button release];
                }
                else
                {
                    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(5 + 2 * i + 50 * i, 3, 50, 50)];
                    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
                        button.frame = CGRectMake(15 + 2 * i + 80 * i, 1, 65, 100);
                    
                    button.tag = i;
                    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
                        [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"smallnailT%d@2x.png", i]] forState:UIControlStateNormal];
                    else
                        [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"smallnailT%d.png", i]] forState:UIControlStateNormal];
                    [button addTarget:self action:@selector(tipChosen:) forControlEvents:UIControlEventTouchUpInside];
                    [secondScroll addSubview:button];
                    [button release];
                }
            }
        }
        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
            secondScroll.contentSize = CGSizeMake(80 * 21 + 15 + 2 * 22 + 15, secondScroll.frame.size.height);
        else
            secondScroll.contentSize = CGSizeMake(50 * 21 + 5 + 2 * 22 + 5, secondScroll.frame.size.height);
        
    }
    else if(lastAccessory == 4)
    {
        for(int i = 1; i <= 21; i++)
        {
            if(i == 0)
            {
                UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(5 + 5 * i + 50 * i, 3, 50, 50)];
                if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
                    button.frame = CGRectMake(15 + 2 * i + 80 * i, 1, 65, 100);
                
                [button setImage:[UIImage imageNamed:@"cancel.png"] forState:UIControlStateNormal];
                button.tag = lastAccessory;
                [button addTarget:self action:@selector(cancelClick:) forControlEvents:UIControlEventTouchUpInside];
                [secondScroll addSubview:button];
                [button release];
            }
            else
            {
                if(i > 6 && [((AppDelegate *)[[UIApplication sharedApplication] delegate]) extrasLocked] == YES)
                {
                    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(15 + 5 * i + 50 * i, 13, 30, 30)];
                    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
                        button.frame = CGRectMake(15 + 2 * i + 80 * i, 23, 65, 65);
                    
                    button.tag = 2;
                    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
                        [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"x%d@2x.png", i]] forState:UIControlStateNormal];
                    else
                        [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"x%d.png", i]] forState:UIControlStateNormal];
                    [button addTarget:((AppDelegate *)[[UIApplication sharedApplication] delegate]).store action:@selector(productClick:) forControlEvents:UIControlEventTouchUpInside];
                    
                    UIImageView *locked = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 20, 25)];
                    locked.image = [UIImage imageNamed:@"lockSmall.png"];
                    [button addSubview:locked];
                    [locked release];
                    
                    [secondScroll addSubview:button];
                    [button release];
                }
                else
                {
                    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(15 + 5 * i + 50 * i, 13, 30, 30)];
                    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
                        button.frame = CGRectMake(15 + 2 * i + 80 * i, 23, 65, 65);
                    
                    button.tag = i;
                    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
                        [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"x%d@2x.png", i]] forState:UIControlStateNormal];
                    else
                        [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"x%d.png", i]] forState:UIControlStateNormal];
                    [button addTarget:self action:@selector(extrasChosen:) forControlEvents:UIControlEventTouchUpInside];
                    [secondScroll addSubview:button];
                    [button release];
                }
            }
        }
        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
            secondScroll.contentSize = CGSizeMake(80 * 22 + 15 + 2 * 23 + 15, secondScroll.frame.size.height);
        else
            secondScroll.contentSize = CGSizeMake(50 * 22 + 15 + 5 * 23, secondScroll.frame.size.height);
    }
    else if(lastAccessory == 5)
    {
        for(int i = 0; i <= 4; i++)
        {
            if(i == 0)
            {
                UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(5 + 2 * i + 50 * i, 3, 50, 50)];
                if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
                    button.frame = CGRectMake(15 + 2 * i + 80 * i, 1, 80, 100);
                
                [button setImage:[UIImage imageNamed:@"cancel.png"] forState:UIControlStateNormal];
                button.tag = lastAccessory;
                [button addTarget:self action:@selector(cancelClick:) forControlEvents:UIControlEventTouchUpInside];
                [secondScroll addSubview:button];
                [button release];
            }
            else
            {
                UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(5 + 2 * i + 50 * i, 3, 50, 50)];
                if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
                    button.frame = CGRectMake(15 + 2 * i + 80 * i, 1, 80, 100);
                
                button.tag = i;
                [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"hand%d.png", i]] forState:UIControlStateNormal];
                [button addTarget:self action:@selector(handChosen:) forControlEvents:UIControlEventTouchUpInside];
                [secondScroll addSubview:button];
                [button release];
            }
        }
        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
            secondScroll.contentSize = CGSizeMake(90 * 5 + 15 + 2 * 6 + 15, secondScroll.frame.size.height);
        else
            secondScroll.contentSize = CGSizeMake(50 * 5 + 5 + 2 * 6 + 5, secondScroll.frame.size.height);
    }
    else if(lastAccessory == 6)
    {
        for(int i = 0; i <= 10; i++)
        {
            if(i == 0)
            {
                UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(5 + 2 * i + 50 * i, 3, 50, 50)];
                if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
                    button.frame = CGRectMake(15 + 2 * i + 80 * i, 1, 65, 100);
                
                [button setImage:[UIImage imageNamed:@"cancel.png"] forState:UIControlStateNormal];
                button.tag = lastAccessory;
                [button addTarget:self action:@selector(cancelClick:) forControlEvents:UIControlEventTouchUpInside];
                [secondScroll addSubview:button];
                [button release];
            }
            else
            {
                if(i > 3 && [((AppDelegate *)[[UIApplication sharedApplication] delegate]) backgroundLocked] == YES)
                {
                    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(5 + 2 * i + 50 * i, 3, 42, 50)];
                    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
                        button.frame = CGRectMake(15 + 2 * i + 90 * i, 1, 80, 100);
                    
                    button.tag = 0;
                    [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%d.png", i]] forState:UIControlStateNormal];
                    [button addTarget:((AppDelegate *)[[UIApplication sharedApplication] delegate]).store action:@selector(productClick:) forControlEvents:UIControlEventTouchUpInside];
                    
                    UIImageView *locked = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 20, 25)];
                    locked.image = [UIImage imageNamed:@"lockSmall.png"];
                    [button addSubview:locked];
                    [locked release];
                    
                    
                    [secondScroll addSubview:button];
                    [button release];
                }
                else
                {
                    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(5 + 2 * i + 50 * i, 3, 42, 50)];
                    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
                        button.frame = CGRectMake(15 + 2 * i + 90 * i, 1, 80, 100);
                    
                    button.tag = i;
                    [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%d.png", i]] forState:UIControlStateNormal];
                    [button addTarget:self action:@selector(backgroundChosen:) forControlEvents:UIControlEventTouchUpInside];
                    [secondScroll addSubview:button];
                    [button release];
                }
            }
        }
        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
            secondScroll.contentSize = CGSizeMake(90 * 11 + 15 + 2 * 12 + 15, secondScroll.frame.size.height);
        else
            secondScroll.contentSize = CGSizeMake(50 * 11 + 5 + 2 * 12 + 5, secondScroll.frame.size.height);
    }
}

#pragma mark - animate

- (void)startAnimating
{
    if([((AppDelegate *)[[UIApplication sharedApplication] delegate]) nailsLocked] == YES)
    {
        CABasicAnimation *rotation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
        rotation.fromValue = [NSNumber numberWithFloat:0];
        rotation.toValue = [NSNumber numberWithFloat:(2*M_PI)];
        rotation.duration = 0.8; // Speed
        rotation.repeatCount = HUGE_VALF; // Repeat forever. Can be a finite number.
        [unlockSparkle1.layer addAnimation:rotation forKey:@"Spin"];

        CABasicAnimation *rotation2 = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
        rotation2.fromValue = [NSNumber numberWithFloat:0];
        rotation2.toValue = [NSNumber numberWithFloat:(2*M_PI)];
        rotation2.duration = 0.8; // Speed
        rotation2.repeatCount = HUGE_VALF; // Repeat forever. Can be a finite number.
        [unlockSparkle2.layer addAnimation:rotation2 forKey:@"Spin"];
    }
}

//- (NSString*)hexCodeFromColor:(UIColor *)color {
//    
//    CGFloat red = 0.0, green = 0.0, blue = 0.0, alpha = 0.0;
//    [color getRed:&red green:&green blue:&blue alpha:&alpha];
//    
//    return [NSString stringWithFormat:@"#%02X%02X%02X", (int)(red * 255.0f), (int)(green * 255.0f), (int)(blue * 255.0f)];
//}

#pragma mark - Dealloc

- (void)dealloc
{
    [extras1Array release];
    [extras2Array release];
    [extras3Array release];
    [extras4Array release];
    [extras5Array release];
    [changes1 release];
    [changes2 release];
    [changes3 release];
    [changes4 release];
    [changes5 release];

    [btnFinalSingleNail release];
    [super dealloc];
}

#pragma mark - IBAction methods
- (IBAction)btnGallery_action:(UIButton *)sender {
    
    [(AppDelegate*)[[UIApplication sharedApplication] delegate] playSoundEffect:1];
    
    ICMMenuViewCotrnoller *menuVC = [[ICMMenuViewCotrnoller alloc] initWithNibName:@"ICMMenuViewCotrnoller" bundle:nil];
    
    [self.navigationController pushViewController:menuVC animated:true];
    
//    __block UIImagePickerController *imgPickerVC;
//    
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        
//        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum] == true) {
//            
//            imgPickerVC             = [[UIImagePickerController alloc] init];
//            imgPickerVC.delegate    = self;
//            
//            imgPickerVC.sourceType  = UIImagePickerControllerSourceTypePhotoLibrary;
//            
//            [self                   presentViewController:imgPickerVC animated:YES completion:nil];
//            
//        }
//        
//    });
    
}

- (IBAction)btnClose_action:(UIButton *)sender {
    
    
}

- (IBAction)btnFrame1_action:(UIButton *)sender {
    
    singleTip.image = [UIImage imageNamed:@"frame_1"];
    
}

- (IBAction)btnFrame2_action:(UIButton *)sender {
    
    singleTip.image = [UIImage imageNamed:@"frame_2"];
    
}

- (IBAction)btnFrame3_action:(UIButton *)sender {
    
    singleTip.image = [UIImage imageNamed:@"frame_3"];
    
}

- (IBAction)btnFrame4_action:(UIButton *)sender {
    
    singleTip.image = [UIImage imageNamed:@"frame_4"];
    
}

- (IBAction)btnFrame5_action:(UIButton *)sender {
    
    singleTip.image = [UIImage imageNamed:@"frame_5"];
    
}

- (IBAction)btnFrame6_action:(UIButton *)sender {
    
    singleTip.image = [UIImage imageNamed:@"frame_6"];
    
}

- (IBAction)btnFrame7_action:(UIButton *)sender {
    
    singleTip.image = [UIImage imageNamed:@"frame_7"];
    
}

- (IBAction)btnFrame8_action:(UIButton *)sender {
    
    singleTip.image = [UIImage imageNamed:@"frame_8"];
    
}

- (IBAction)btnFrame9_action:(UIButton *)sender {
    
    singleTip.image = [UIImage imageNamed:@"frame_9"];
    
}

- (IBAction)btnFrame10_action:(UIButton *)sender {
    
    singleTip.image = [UIImage imageNamed:@"frame_10"];
    
}

- (IBAction)btnFinalSingleNail_action:(UIButton *)sender {
    
    FinalSingleNailVC *finalSingleNailVC = [[FinalSingleNailVC alloc] initWithNibName:@"FinalSingleNailVC" bundle:nil];
    
    finalSingleNailVC.img = singleTip.image;
    
    [self.navigationController pushViewController:finalSingleNailVC animated:true];
    
}

- (NSString *)hexStringForColor:(UIColor *)color {
    
    const CGFloat *components = CGColorGetComponents(color.CGColor);
    
    CGFloat r = components[0];
    CGFloat g = components[1];
    CGFloat b = components[2];
    
    NSString *hexString = [NSString stringWithFormat:@"%02X%02X%02X", (int)(r * 255), (int)(g * 255), (int)(b * 255)];
    
    return hexString;
}

- (UIColor *)colorFromHexString:(NSString *)hexString {
    
    unsigned rgbValue = 0;
    
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    [scanner setScanLocation:1]; // bypass '#' character
    [scanner scanHexInt:&rgbValue];
    
    UIColor *color = [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0 green:((rgbValue & 0xFF00) >> 8)/255.0 blue:(rgbValue & 0xFF)/255.0 alpha:1.0];
    
    return color;
}

//- (void)saveBackgroundColorOfNail:(UIColor *)color {
//    
//    if(nailSelected == 1)
//    {
//        NSMutableDictionary *md = [[NSMutableDictionary alloc] init];
//        [md setObject:[NSString stringWithFormat:@"%d", 9000] forKey:@"pic"];
//        [md setObject:color forKey:@"bg_nail_color"];
//        [extras1Array addObject:md];
//        [md release];
//        
//        
//        NSMutableDictionary *md2 = [[NSMutableDictionary alloc] init];
//        [md2 setObject:@"extras" forKey:@"type"];
//        [md2 setObject:[NSString stringWithFormat:@"%d", 9000] forKey:@"pic_nr"];
//        [changes1 addObject:md2];
//        [md2 release];
//        
//    }
//    else if(nailSelected == 2)
//    {
//        NSMutableDictionary *md = [[NSMutableDictionary alloc] init];
//        [md setObject:[NSString stringWithFormat:@"%d", 9000] forKey:@"pic"];
//        [md setObject:color forKey:@"bg_nail_color"];
//        [extras2Array addObject:md];
//        [md release];
//        
//        NSMutableDictionary *md2 = [[NSMutableDictionary alloc] init];
//        [md2 setObject:@"extras" forKey:@"type"];
//        [md2 setObject:[NSString stringWithFormat:@"%d", 9000] forKey:@"pic_nr"];
//        [changes2 addObject:md2];
//        [md2 release];
//    }
//    else if(nailSelected == 3)
//    {
//        NSMutableDictionary *md = [[NSMutableDictionary alloc] init];
//        [md setObject:[NSString stringWithFormat:@"%d", 9000] forKey:@"pic"];
//        [md setObject:color forKey:@"bg_nail_color"];
//        [extras3Array addObject:md];
//        [md release];
//        
//        NSMutableDictionary *md2 = [[NSMutableDictionary alloc] init];
//        [md2 setObject:@"extras" forKey:@"type"];
//        [md2 setObject:[NSString stringWithFormat:@"%d", 9000] forKey:@"pic_nr"];
//        [changes3 addObject:md2];
//        [md2 release];
//        
//    }
//    else if(nailSelected == 4)
//    {
//        NSMutableDictionary *md = [[NSMutableDictionary alloc] init];
//        [md setObject:[NSString stringWithFormat:@"%d", 9000] forKey:@"pic"];
//        [md setObject:color forKey:@"bg_nail_color"];
//        [extras4Array addObject:md];
//        [md release];
//        
//        NSMutableDictionary *md2 = [[NSMutableDictionary alloc] init];
//        [md2 setObject:@"extras" forKey:@"type"];
//        [md2 setObject:[NSString stringWithFormat:@"%d", 9000] forKey:@"pic_nr"];
//        [changes4 addObject:md2];
//        [md2 release];
//    }
//    else if(nailSelected == 5)
//    {
//        NSMutableDictionary *md = [[NSMutableDictionary alloc] init];
//        [md setObject:[NSString stringWithFormat:@"%d", 9000] forKey:@"pic"];
//        [md setObject:color forKey:@"bg_nail_color"];
//        [extras5Array addObject:md];
//        [md release];
//        
//        NSMutableDictionary *md2 = [[NSMutableDictionary alloc] init];
//        [md2 setObject:@"extras" forKey:@"type"];
//        [md2 setObject:[NSString stringWithFormat:@"%d", 9000] forKey:@"pic_nr"];
//        [changes5 addObject:md2];
//        [md2 release];
//    }
//    
//}

#pragma mark - UIImagePickerViewController delegate method
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^() {
        
        dispatch_async(dispatch_get_main_queue(), ^() {

            [self dismissViewControllerAnimated:false completion:^{
                
                CropImageViewController *cropImageViewCont  = [[CropImageViewController alloc] initWithNibName:@"CropImageViewController" bundle:nil];
                cropImageViewCont.delegate                  = self;
                cropImageViewCont.imgSelected               = [info objectForKey:UIImagePickerControllerOriginalImage];
                
                UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:cropImageViewCont];
                
                [self presentViewController:navController animated:YES completion:^{
                    
                }];
                
            }];
            
        });
        
    });
    
}

#pragma mar - CropImageViewController delegate method
- (void)selectedImage:(UIImage *)orignalImage croppedImage:(UIImage *)croppedImage {
    
    isImageSelectedFromGallery  = true;
    
//    UIPanGestureRecognizer *panRecognizer = [[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(move:)] autorelease];
//    [panRecognizer setMinimumNumberOfTouches:1];
//    [panRecognizer setMaximumNumberOfTouches:1];
//    [panRecognizer setDelegate:self];
//    [canvas addGestureRecognizer:panRecognizer];
    
    [self imageChosen:croppedImage originalImg:orignalImage];
    
}

-(void)scale:(id)sender {
    
    if([(UIPinchGestureRecognizer*)sender state] == UIGestureRecognizerStateBegan) {
        _lastScale = 1.0;
    }
    
    CGFloat scale = 1.0 - (_lastScale - [(UIPinchGestureRecognizer*)sender scale]);
    
    CGAffineTransform currentTransform = photoImage.transform;
    CGAffineTransform newTransform = CGAffineTransformScale(currentTransform, scale, scale);
    
    [photoImage setTransform:newTransform];
    
    _lastScale = [(UIPinchGestureRecognizer*)sender scale];
}

-(void)rotate:(id)sender {
    
    if([(UIRotationGestureRecognizer*)sender state] == UIGestureRecognizerStateEnded) {
        
        _lastRotation = 0.0;
        return;
    }
    
    CGFloat rotation = 0.0 - (_lastRotation - [(UIRotationGestureRecognizer*)sender rotation]);
    
    CGAffineTransform currentTransform = photoImage.transform;
    CGAffineTransform newTransform = CGAffineTransformRotate(currentTransform,rotation);
    
    [photoImage setTransform:newTransform];
    
    _lastRotation = [(UIRotationGestureRecognizer*)sender rotation];
}

- (void)imageChosen:(UIImage *)sender originalImg:(UIImage *)originalImg {
    
    UIImageView *label = [[UIImageView alloc] initWithImage:sender];
    UIImage *temp = sender;
    label.frame = CGRectMake(CGRectGetWidth(singleTip.frame)/3.5, CGRectGetHeight(singleTip.frame)/2.5, 70.0, 70.0);
    
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        label.frame = CGRectMake(CGRectGetWidth(singleTip.frame)/3.8, CGRectGetHeight(singleTip.frame)/2.5, 164, 164);
    }
    
    label.image = temp;
    
    if(nailSelected == 1)
    {
        label.tag = [extras1Array count] + 1;
        
//        NSMutableDictionary *md = [[NSMutableDictionary alloc] init];
//        [md setObject:[NSString stringWithFormat:@"%d", sender.tag] forKey:@"pic"];
//        [md setObject:NSStringFromCGRect(label.frame) forKey:@"frame"];
//        [extras1Array addObject:md];
//        [md release];
//        
//        
//        NSMutableDictionary *md2 = [[NSMutableDictionary alloc] init];
//        [md2 setObject:@"extras" forKey:@"type"];
//        [md2 setObject:[NSString stringWithFormat:@"%d", sender.tag] forKey:@"pic_nr"];
//        [changes1 addObject:md2];
//        [md2 release];
        
        NSMutableDictionary *md = [[NSMutableDictionary alloc] init];
        [md setObject:[NSString stringWithFormat:@"%d", 5000] forKey:@"pic"];
        [md setObject:label.image forKey:@"gallery_pic_1"];
        [md setObject:NSStringFromCGRect(label.frame) forKey:@"frame"];
        [extras1Array addObject:md];
        [md release];
        
        NSMutableDictionary *md2 = [[NSMutableDictionary alloc] init];
        [md2 setObject:@"gallery_picture" forKey:@"type"];
        [md2 setObject:[NSString stringWithFormat:@"%d", 5000] forKey:@"pic_nr"];
        [changes1 addObject:md2];
        [md2 release];
        
    }
    else if(nailSelected == 2)
    {
        label.tag = [extras2Array count] + 1;
        
        NSMutableDictionary *md = [[NSMutableDictionary alloc] init];
        [md setObject:[NSString stringWithFormat:@"%d", 5000] forKey:@"pic"];
        [md setObject:sender forKey:@"gallery_pic_1"];
        [md setObject:NSStringFromCGRect(label.frame) forKey:@"frame"];
        [extras2Array addObject:md];
        [md release];
        
        NSMutableDictionary *md2 = [[NSMutableDictionary alloc] init];
        [md2 setObject:@"gallery_picture" forKey:@"type"];
        [md2 setObject:[NSString stringWithFormat:@"%d", 5000] forKey:@"pic_nr"];
        [changes2 addObject:md2];
        [md2 release];
    }
    else if(nailSelected == 3)
    {
        label.tag = [extras3Array count] + 1;
        
        NSMutableDictionary *md = [[NSMutableDictionary alloc] init];
        [md setObject:[NSString stringWithFormat:@"%d", 5000] forKey:@"pic"];
        [md setObject:sender forKey:@"gallery_pic_1"];
        [md setObject:NSStringFromCGRect(label.frame) forKey:@"frame"];
        [extras3Array addObject:md];
        [md release];
        
        NSMutableDictionary *md2 = [[NSMutableDictionary alloc] init];
        [md2 setObject:@"gallery_picture" forKey:@"type"];
        [md2 setObject:[NSString stringWithFormat:@"%d", 5000] forKey:@"pic_nr"];
        [changes3 addObject:md2];
        [md2 release];
        
    }
    else if(nailSelected == 4)
    {
        label.tag = [extras4Array count] + 1;
        
        NSMutableDictionary *md = [[NSMutableDictionary alloc] init];
        [md setObject:[NSString stringWithFormat:@"%d", 5000] forKey:@"pic"];
        [md setObject:sender forKey:@"gallery_pic_1"];
        [md setObject:NSStringFromCGRect(label.frame) forKey:@"frame"];
        [extras4Array addObject:md];
        [md release];
        
        NSMutableDictionary *md2 = [[NSMutableDictionary alloc] init];
        [md2 setObject:@"gallery_picture" forKey:@"type"];
        [md2 setObject:[NSString stringWithFormat:@"%d", 5000] forKey:@"pic_nr"];
        [changes4 addObject:md2];
        [md2 release];
    }
    else if(nailSelected == 5)
    {
        label.tag = [extras5Array count] + 1;
        
        NSMutableDictionary *md = [[NSMutableDictionary alloc] init];
        [md setObject:[NSString stringWithFormat:@"%d", 5000] forKey:@"pic"];
        [md setObject:sender forKey:@"gallery_pic_1"];
        [md setObject:NSStringFromCGRect(label.frame) forKey:@"frame"];
        [extras5Array addObject:md];
        [md release];
        
        NSMutableDictionary *md2 = [[NSMutableDictionary alloc] init];
        [md2 setObject:@"gallery_picture" forKey:@"type"];
        [md2 setObject:[NSString stringWithFormat:@"%d", 5000] forKey:@"pic_nr"];
        [changes5 addObject:md2];
        [md2 release];
    }
    
    label.userInteractionEnabled = true;
    [singleTip addSubview:label];
    [label release];

}

@end
