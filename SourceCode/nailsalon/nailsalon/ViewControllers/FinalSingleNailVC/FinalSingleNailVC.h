//
//  FinalSingleNailVC.h
//  nailsalon
//
//  Created by Muhammad Hassan on 02/10/2015.
//  Copyright © 2015 Newrosoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Social/Social.h>
#import <MessageUI/MessageUI.h>
#import <QuartzCore/QuartzCore.h>

#import "Defines.h"
#import "AppDelegate.h"

@interface FinalSingleNailVC : UIViewController <UIActionSheetDelegate, UIAlertViewDelegate, MFMailComposeViewControllerDelegate> {
    
    IBOutlet UIImageView *fingerImgView;
    IBOutlet UIImageView *backgroundImgView;
    
    IBOutlet UIImageView *singleTip;
    IBOutlet UIImageView *singleColor;
    IBOutlet UIImageView *singleGloss;
    IBOutlet UIImageView *singlePattern;
    
    UIImage *imageWithBackground;
    
    IBOutlet UIButton *backButton;
    IBOutlet UIButton *saveButton;
    IBOutlet UIButton *shareButton;
    IBOutlet UIButton *homeButton;
    
    BOOL saved;
    
    int nr1;
    int nr2;
    
}

@property (nonatomic, strong) UIImage *img;

- (IBAction)backClick:(id)sender;
- (IBAction)homeClick:(id)sender;
- (IBAction)saveClick:(id)sender;
- (IBAction)shareClick:(id)sender;

@end
