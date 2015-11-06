//
//  ICMCollageViewController.m
//  InstagramCollageMaker
//
//  Created by  mrhard on 08.04.14.
//  Copyright (c) 2014 Azoft. All rights reserved.
//

#import "ICMCollageViewController.h"
#import "ICMCollage.h"
#import "UIView+RelativeFrame.h"
//#import "ICMImage.h"
//#import "ICMMedia.h"
#import "UIView+ImageRender.h"
//#import "ICMPreviewViewController.h"
#import "ICMCollageElementView.h"

#import <QuartzCore/CALayer.h>

@interface ICMCollageViewController ()

@property (nonatomic, strong) UIView *collageView;
@property (nonatomic, strong) ICMCollageElementView *currentCollageElementView;

@end

@implementation ICMCollageViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeBottom;

    self.collageView = [[UIView alloc] initWithFrame:CGRectMake(0., 0., self.view.frame.size.width, self.view.frame.size.width)];
    self.collageView.backgroundColor = [UIColor whiteColor];
    self.collageView.layer.cornerRadius = 5.;
    [self.view addSubview:self.collageView];
    
    if (self.collage) {
        
        [self buildCollageView];
        
    }
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    const CGFloat kCollageViewPaddings = 5.;
    
    CGRect frame = self.collageView.frame;
    
    BOOL needUseWidth = YES;
    
    if (self.collage.ratio >= 1.) {
        if (self.view.frame.size.width < self.view.frame.size.height &&
            self.view.frame.size.height >= self.view.frame.size.width / self.collage.ratio) {
            needUseWidth = YES;
        } else {
            needUseWidth = NO;
        }
    } else {
        if (self.view.frame.size.height < self.view.frame.size.width &&
            self.view.frame.size.width >= self.view.frame.size.height / self.collage.ratio) {
            needUseWidth = YES;
        } else {
            needUseWidth = NO;
        }
    }
    
    
    if (needUseWidth) {
        frame.size.width = self.view.frame.size.width - kCollageViewPaddings * 2.;
        frame.size.height = frame.size.width / self.collage.ratio;
    } else {
        frame.size.height = self.view.frame.size.height - kCollageViewPaddings * 2.;
        frame.size.width = frame.size.height * self.collage.ratio;
    }
    
    self.collageView.frame = frame;
    
    self.collageView.center = CGPointMake(self.view.frame.size.width / 2., self.view.frame.size.height / 2.);
    
    [self.collageView.subviews makeObjectsPerformSelector:@selector(refreshFrame)];
}

#pragma mark - helpers

- (void)setCollage:(ICMCollage *)collage {
    
    if (_collage != collage) {
        _collage = collage;
        if ([self isViewLoaded]) {
            [self buildCollageView];
        }
    }
}

- (void)buildCollageView {
    
    [self.collageView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    [self.collage enumerateRelativeFramesUsingBlock:^(CGRect relativeFrame, NSUInteger index) {
        
        [self createCollageElementViewWithRelativeFrame:relativeFrame];
        
    }];
}

- (void)createCollageElementViewWithRelativeFrame:(CGRect)relativeFrame {
    
    ICMCollageElementView *result = [ICMCollageElementView new];
    
    result.relativeFrame = relativeFrame;
    
    [result addTarget:self action:@selector(onCollageElementTap:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.collageView addSubview:result];
}

- (void)onCollageElementTap:(id)sender {
    
    self.currentCollageElementView = sender;
    
    __block UIImagePickerController *imgPickerVC;
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum] == true) {
            
            imgPickerVC             = [[UIImagePickerController alloc] init];
            imgPickerVC.delegate    = self;
            
            imgPickerVC.sourceType  = UIImagePickerControllerSourceTypePhotoLibrary;
            
            [self                   presentViewController:imgPickerVC animated:YES completion:nil];
            
        }
        
    });

    
}

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
    
    self.currentCollageElementView.image = croppedImage;
    
}

#pragma mark - Actions
- (IBAction)btnPV_action:(UIButton *)sender {
    
    [self.navigationController popViewControllerAnimated:true];
    
}

- (IBAction)btnCreateImage_action:(UIButton *)sender {
    
    NSDictionary *dict = [NSDictionary dictionaryWithObject:[self.collageView renderImage] forKey:@"render_image"];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"goback" object:nil userInfo:dict];
    
    [self.navigationController popViewControllerAnimated:false];
    
}

@end
