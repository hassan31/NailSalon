//
//  ICMViewController.m
//  InstagramCollageMaker
//
//  Created by  mrhard on 07.04.14.
//  Copyright (c) 2014 Azoft. All rights reserved.
//

#import "ICMMenuViewCotrnoller.h"
#import "ICMCollageViewController.h"
#import "ICMCollage.h"
#import "UIImage+CollagePreview.h"

#import <QuartzCore/CALayer.h>
#import "SVProgressHUD.h"

@interface ICMMenuViewCotrnoller ()

@property (nonatomic, strong) IBOutlet UIButton *giveCollageButton;
@property (nonatomic, strong) IBOutlet UIButton *nameButton;
@property (nonatomic, strong) IBOutlet iCarousel *collagePreviewCarousel;

@property (nonatomic, strong) ICMCollage *selectedCollage;

@property (nonatomic, strong) NSArray *collages;
@property (nonatomic, strong) NSMutableDictionary *previewImages;

@end

@implementation ICMMenuViewCotrnoller

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(gobackVC:) name:@"goback" object:nil];
    
    _collages = [ICMCollage collages];
    _selectedCollage = [_collages firstObject];
    _previewImages = [NSMutableDictionary dictionaryWithCapacity:[_collages count]];
    
    self.nameButton.layer.cornerRadius = self.giveCollageButton.layer.cornerRadius = 5.0;
    
    self.collagePreviewCarousel.type = iCarouselTypeCoverFlow2;
    
    [self.collagePreviewCarousel reloadData];
}

- (void)gobackVC:(NSNotification *)notification {
    
    NSDictionary *dict = [notification userInfo];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"gobackToMainVC" object:nil userInfo:dict];
    
    [self.navigationController popViewControllerAnimated:true];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    [self.previewImages removeAllObjects];
}

#pragma mark - helpers
- (void)setSelectedCollage:(ICMCollage *)selectedCollage {
    _selectedCollage = selectedCollage;
    [self refreshGiveCollageButton];
}

- (void)refreshGiveCollageButton {
//    self.giveCollageButton.enabled = self.selectedUser && self.selectedCollage;
}

#pragma mark - Actions

- (IBAction)onGiveCollageButtonTap:(UIButton *)sender {
    
    ICMCollageViewController *vc = [[ICMCollageViewController alloc] initWithNibName:@"ICMCollageViewController" bundle:nil];

    vc.collage = self.selectedCollage;
                                    
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark iCarousel staff

- (NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel {
    
    return [self.collages count];
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view {
    UIImageView *result = (UIImageView *)view;
    
    if (!result) {
        result = [[UIImageView alloc] initWithFrame:CGRectMake(0.,
                                                               0.,
                                                               self.collagePreviewCarousel.frame.size.height,
                                                               self.collagePreviewCarousel.frame.size.height)];
    }
    
    if (!self.previewImages[@(index)]) {
        self.previewImages[@(index)] = [UIImage renderPreviewImageWithCollage:self.collages[index] ofSize:result.frame.size];
    }
    result.image = self.previewImages[@(index)];
    
    return result;
}

- (CGFloat)carousel:(iCarousel *)carousel valueForOption:(iCarouselOption)option withDefault:(CGFloat)value {
    const CGFloat carouselSpacingCoef = 1.1;
    return option == iCarouselOptionSpacing ? value * carouselSpacingCoef : value;
}

- (void)carousel:(iCarousel *)carousel didSelectItemAtIndex:(NSInteger)index {
    
    self.selectedCollage = self.collages[index];
    
    ICMCollageViewController *vc = [[ICMCollageViewController alloc] initWithNibName:@"ICMCollageViewController" bundle:nil];
    
    vc.collage = self.selectedCollage;
    
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)carouselDidEndScrollingAnimation:(iCarousel *)carousel {
    
    self.selectedCollage = self.collages[carousel.currentItemIndex];
}

- (IBAction)btnPV_action:(UIButton *)sender {
    
    [self.navigationController popViewControllerAnimated:true];
    
}

@end
