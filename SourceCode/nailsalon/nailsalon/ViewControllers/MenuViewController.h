//
//  MenuViewController.h
//  NailSalon
//
//  Created by Alexandra Smau on 5/7/13.
//  Copyright (c) 2013 Newrosoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuViewController : UIViewController <UIAlertViewDelegate>
{
    IBOutlet UIImageView *unlockSparkle;

    int nr1;
    int nr2;
}

- (IBAction)play:(id)sender;
- (IBAction)storeClick:(id)sender;
- (IBAction)moreClick:(id)sender;
- (IBAction)photoAlbum:(id)sender;
- (IBAction)restoreClick:(id)sender;
- (IBAction)PrivacyPolicy:(id)sender;

@end
