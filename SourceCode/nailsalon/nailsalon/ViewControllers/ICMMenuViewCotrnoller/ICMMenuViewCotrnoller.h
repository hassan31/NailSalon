//
//  ICMViewController.h
//  InstagramCollageMaker
//
//  Created by  mrhard on 07.04.14.
//  Copyright (c) 2014 Azoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iCarousel.h"
#import "ICMBaseViewController.h"

@interface ICMMenuViewCotrnoller : ICMBaseViewController <iCarouselDataSource, iCarouselDelegate>

- (IBAction)btnPV_action:(UIButton *)sender;

@end
