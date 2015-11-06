//
//  ICMCollageViewController.h
//  InstagramCollageMaker
//
//  Created by  mrhard on 08.04.14.
//  Copyright (c) 2014 Azoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ICMBaseViewController.h"
#import "CropImageViewController.h"

#import "NailDecorateViewController.h"

@class ICMCollage;

@interface ICMCollageViewController : ICMBaseViewController <UINavigationControllerDelegate, UIImagePickerControllerDelegate, CropImageViewControllerDelegate>

@property (nonatomic, strong) ICMCollage *collage;

- (IBAction)btnPV_action:(UIButton *)sender;
- (IBAction)btnCreateImage_action:(UIButton *)sender;

@end
