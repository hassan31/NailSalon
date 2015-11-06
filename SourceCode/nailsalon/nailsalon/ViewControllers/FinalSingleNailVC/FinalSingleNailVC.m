//
//  FinalSingleNailVC.m
//  nailsalon
//
//  Created by Muhammad Hassan on 02/10/2015.
//  Copyright © 2015 Newrosoft. All rights reserved.
//

#import "FinalSingleNailVC.h"

@interface FinalSingleNailVC ()

@end

@implementation FinalSingleNailVC

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    CGRect bounds = singleTip.bounds;
    CALayer *maskLayer = [CALayer layer];
    maskLayer.frame = bounds;
    maskLayer.contents = (id)[[UIImage imageNamed:@"nailC1.png"] CGImage];
    singleTip.layer.mask = maskLayer;
    
    singleTip.image = self.img;

}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];

}

#pragma mark - IBAction methods
- (IBAction)backClick:(id)sender {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [(AppDelegate*)[[UIApplication sharedApplication] delegate] playSoundEffect:1];
    [(AppDelegate*)[[UIApplication sharedApplication] delegate] stopSoundEffect:4];
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (IBAction)homeClick:(id)sender {
    
    [(AppDelegate *)[[UIApplication sharedApplication] delegate] playSoundEffect:1];
    
    if(saved == NO) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Oops!" message:@"You didn't save your nails! Do you really want to leave?" delegate:self cancelButtonTitle:@"Leave" otherButtonTitles:@"Save", nil];
        [alert show];
        
    } else {
        
        [[NSNotificationCenter defaultCenter] removeObserver:self];
        [(AppDelegate*)[[UIApplication sharedApplication] delegate] stopSoundEffect:4];
        [self.navigationController popToRootViewControllerAnimated:YES];
        
    }
}

- (IBAction)saveClick:(id)sender {
    
    [((AppDelegate *)[[UIApplication sharedApplication] delegate]) playSoundEffect:1];
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Save Your Nails" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Save to Album", @"Save to Photos", nil];
    
    actionSheet.tag = 16;
    actionSheet.actionSheetStyle = UIActionSheetStyleDefault;
    [actionSheet showInView:self.view];
    
}

- (IBAction)shareClick:(id)sender {
    
    [(AppDelegate *)[[UIApplication sharedApplication] delegate] playSoundEffect:1];
    
    //Parental Control
    nr1 = arc4random() % 5 + 4;
    nr2 = arc4random() % 5 + 4;
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:[NSString stringWithFormat:@"%d x %d = ?", nr1, nr2] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:@"Cancel", nil];
    alert.tag = 13;
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    [alert textFieldAtIndex:0].keyboardType = UIKeyboardTypeNumberPad;
    [alert show];
    [alert release];
    
}

#pragma mark - Share/Save
- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex  // after animation
{
    [((AppDelegate*)[[UIApplication sharedApplication] delegate]) playSoundEffect:1];
    if(actionSheet.tag == 16)
    {
        if(buttonIndex == 0)
        {
            saved = YES;
            //Album
            [self.view setBackgroundColor:[UIColor clearColor]];
            [backButton removeFromSuperview];
            [shareButton removeFromSuperview];
            [saveButton removeFromSuperview];
            [homeButton removeFromSuperview];
            [backgroundImgView removeFromSuperview];
            
            if([[UIScreen mainScreen] respondsToSelector:@selector(scale)])
                UIGraphicsBeginImageContextWithOptions(self.view.frame.size, NO, [UIScreen mainScreen].scale);
            else
                UIGraphicsBeginImageContext(self.view.frame.size);
            [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
            UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
            
            [self.view addSubview:backButton];
            [self.view addSubview:shareButton];
            [self.view addSubview:saveButton];
            [self.view addSubview:homeButton];
            
            [self.view insertSubview:backgroundImgView atIndex:0];
            
            
            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            NSString *documentsDirectory = [paths objectAtIndex:0];
            NSTimeInterval timeStamp = [[NSDate date] timeIntervalSince1970];
            NSNumber *timeStampObj = [NSNumber numberWithDouble:timeStamp];
            
            NSString *savedImagePath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png",timeStampObj]];
            NSData *imageData = UIImagePNGRepresentation(img);
            [imageData writeToFile:savedImagePath atomically:NO];
            
        }
        else if(buttonIndex == 1)
        {
            saved = YES;
            //Photos
            if(imageWithBackground == nil)
            {
                [backButton removeFromSuperview];
                [shareButton removeFromSuperview];
                [saveButton removeFromSuperview];
                [homeButton removeFromSuperview];
                
                if([[UIScreen mainScreen] respondsToSelector:@selector(scale)])
                    UIGraphicsBeginImageContextWithOptions(self.view.frame.size, NO, [UIScreen mainScreen].scale);
                else
                    UIGraphicsBeginImageContext(self.view.frame.size);
                [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
                imageWithBackground = UIGraphicsGetImageFromCurrentImageContext();
                [imageWithBackground retain];
                
                [self.view addSubview:backButton];
                [self.view addSubview:shareButton];
                [self.view addSubview:saveButton];
                [self.view addSubview:homeButton];

            }
            
            UIImageWriteToSavedPhotosAlbum(imageWithBackground, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
        }
    }
    if(actionSheet.tag == 17)
    {
        if(buttonIndex == 0)
        {
            //Facebook
            
            if([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook])
            {
                SLComposeViewController *mySLComposerSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
                [mySLComposerSheet setInitialText:FACEBOOK_SHARE_TEXT];
                [mySLComposerSheet addImage:imageWithBackground];
                [mySLComposerSheet addURL:[NSURL URLWithString:ITUNES_LINK]];
                
                [mySLComposerSheet setCompletionHandler:^(SLComposeViewControllerResult result)
                 {
                     switch(result)
                     {
                         case SLComposeViewControllerResultCancelled:
                             NSLog(@"Post Canceled");
                             break;
                         case SLComposeViewControllerResultDone:
                             NSLog(@"Post Sucessful");
                             break;
                         default:
                             break;
                     }
                 }];
                
                [self presentViewController:mySLComposerSheet animated:YES completion:nil];
            }
            else
            {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Please log in on Facebook before using this feature" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
                [alert show];
                [alert release];
            }
        }
        else if(buttonIndex == 1)
        {
            //Email
            
            if([MFMailComposeViewController canSendMail])
            {
                MFMailComposeViewController *mailer = [[MFMailComposeViewController alloc] init];
                mailer.mailComposeDelegate = self;
                [mailer setSubject:EMAIL_SUBJECT];
                
                //[imageWithBackground retain];
                NSData *imageData = UIImagePNGRepresentation(imageWithBackground);
                [mailer addAttachmentData:imageData mimeType:@"image/png" fileName:@"Nails"];
                
                NSString *emailBody = EMAIL_MESSAGE;
                [mailer setMessageBody:emailBody isHTML:YES];
                
                [self presentViewController:mailer animated:YES completion:nil];
            }
            else
            {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Failure"
                                                                message:@"Your device doesn't support this feature."
                                                               delegate:nil
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles:nil];
                [alert show];
            }
        }
    }
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    
    UIAlertView *alert;
    
    if(error)
        alert = [[UIAlertView alloc] initWithTitle:@"Failure"
                                           message:@"This pic couldn't be saved in your photo album."
                                          delegate:nil cancelButtonTitle:@"Ok"
                                 otherButtonTitles:nil];
    else
        alert = [[UIAlertView alloc] initWithTitle:@""
                                           message:@"This pic was saved in your photo album"
                                          delegate:nil cancelButtonTitle:@"Ok"
                                 otherButtonTitles:nil];
    [alert show];
}

#pragma mark - UIAlertView

- (void)alertView:(UIAlertView*)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if(alertView.tag == 13)
    {
        if(buttonIndex == 0)
        {
            if([[alertView textFieldAtIndex:0].text isEqualToString:[NSString stringWithFormat:@"%d", nr1 * nr2]])
            {
                [alertView dismissWithClickedButtonIndex:-1 animated:YES];
                
                if(imageWithBackground == nil)
                {
                    [backButton removeFromSuperview];
                    [shareButton removeFromSuperview];
                    [saveButton removeFromSuperview];
                    [homeButton removeFromSuperview];
                    
                    if([[UIScreen mainScreen] respondsToSelector:@selector(scale)])
                        UIGraphicsBeginImageContextWithOptions(self.view.frame.size, NO, [UIScreen mainScreen].scale);
                    else
                        UIGraphicsBeginImageContext(self.view.frame.size);
                    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
                    imageWithBackground = UIGraphicsGetImageFromCurrentImageContext();
                    [imageWithBackground retain];
                    
                    [self.view addSubview:backButton];
                    [self.view addSubview:shareButton];
                    [self.view addSubview:saveButton];
                    [self.view addSubview:homeButton];
                    
                }
                
                UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Share Your Nails" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Share to Facebook", @"Email to Friends", nil];
                actionSheet.tag = 17;
                actionSheet.actionSheetStyle = UIActionSheetStyleDefault;
                [actionSheet showInView:self.view];
            }
        }
    }
    else
    {
        if(buttonIndex == 0)
        {
            [[NSNotificationCenter defaultCenter] removeObserver:self];
            [((AppDelegate *)[[UIApplication sharedApplication] delegate]) playSoundEffect:1];
            ((AppDelegate*)[[UIApplication sharedApplication] delegate]).fromLastPage = YES;
            [(AppDelegate*)[[UIApplication sharedApplication] delegate] stopSoundEffect:4];
            
            [self.navigationController popToRootViewControllerAnimated:YES];
            [alertView dismissWithClickedButtonIndex:0 animated:YES];
        }
        else
        {
            [alertView dismissWithClickedButtonIndex:1 animated:YES];
            [self saveClick:nil];
        }
    }
}

@end
