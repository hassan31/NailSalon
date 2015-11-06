
#import "CropImageViewController.h"

@interface CropImageViewController ()
@end

@implementation CropImageViewController
@synthesize imgSelected, delegate;

#pragma mark - VIEW LIFE CYCLE
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    
//    if([[UIScreen mainScreen] bounds].size.height == 1024) {
//        
//        self = [super initWithNibName:@"CropImageViewController~ipad" bundle:nibBundleOrNil];
//        
//    } else {
//        
//        self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
//        
//    }
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) {
        
    }
    
    return self;
    
}

- (void)viewDidLoad {
    
    [super viewDidLoad]; [self setLayout];
    
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    
}

- (void)setLayout {
    
    self.navigationItem.leftBarButtonItem   = [[UIBarButtonItem alloc] initWithCustomView:btnSave];
    self.navigationItem.rightBarButtonItem  = [[UIBarButtonItem alloc] initWithCustomView:btnClose];
    
    imgViewSelected.image           = imgSelected;
    
    imgViewSelected.contentMode     = UIViewContentModeScaleAspectFit;
    imgViewSelected.clipsToBounds   = YES;
    
    float widthRatio                = imgViewSelected.bounds.size.width / imgViewSelected.image.size.width;
    float heightRatio               = imgViewSelected.bounds.size.height / imgViewSelected.image.size.height;
    
    float scale                     = MIN (widthRatio, heightRatio);
    
    float imageWidth                = scale * imgViewSelected.image.size.width;
    float imageHeight               = scale * imgViewSelected.image.size.height;
    
    // TO SET imgViewSelected FRAME ACCORDING TO imgSelected SIZE
    CGRect frame                    = imgViewSelected.frame;
    
    frame.origin.x                  = ([UIScreen mainScreen].bounds.size.width - imageWidth) / 2;
    frame.origin.y                  = ([UIScreen mainScreen].bounds.size.height - imageHeight) / 2;
    
    frame.size.width                = imageWidth;
    frame.size.height               = imageHeight;
    
    imgViewSelected.frame           = frame;
    
    UIView *viewCover               = [[UIView alloc] initWithFrame:imgViewSelected.frame];
    viewCover.backgroundColor       = [UIColor clearColor];
    [self.view                      addSubview:viewCover];
    
    // SET CROP VIEW FRAME
    userResizableView               = [[SPUserResizableView alloc] initWithFrame:CGRectMake(0.0f,
                                                                                            0.0f,
                                                                                            130.0f,
                                                                                            130.0f)];
    userResizableView.delegate      = self;
    [userResizableView              showEditingHandles];
    [viewCover                      addSubview:userResizableView];
    
}

#pragma mark - UIButton ACTION METHODS
- (IBAction)btnBack_action:(UIButton *)sender {
    
    [self dismissViewControllerAnimated:YES completion:^{}];
    
}

- (IBAction)btnCrop_action:(UIButton *)sender {
    
    if ([self.delegate respondsToSelector:@selector(selectedImage:croppedImage:)]) {
    
        [self.delegate selectedImage:imgSelected croppedImage:[self croppIngimageByImageName:imgViewSelected toRect:userResizableView.frame]];
    
    }

    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
    
}

#pragma mark - OTHERS
- (UIImage *)croppIngimageByImageName:(UIImageView *)imageToCrop toRect:(CGRect)frame {
    
    // Find the scalefactors  UIImageView's widht and height / UIImage width and height
    CGFloat widthScale = imgViewSelected.bounds.size.width / imgViewSelected.image.size.width;
    CGFloat heightScale = imgViewSelected.bounds.size.height / imgViewSelected.image.size.height;
    
    // Calculate the right crop rectangle
    frame.origin.x = frame.origin.x * (1 / widthScale);
    frame.origin.y = frame.origin.y * (1 / heightScale);
    frame.size.width = frame.size.width * (1 / widthScale);
    frame.size.height = frame.size.height * (1 / heightScale);
    
    
    CGAffineTransform rectTransform;
    switch (imageToCrop.image.imageOrientation)
    {
        case UIImageOrientationLeft:
            rectTransform = CGAffineTransformTranslate(CGAffineTransformMakeRotation(M_PI_2), 0, -imageToCrop.image.size.height);
            break;
        case UIImageOrientationRight:
            rectTransform = CGAffineTransformTranslate(CGAffineTransformMakeRotation(-M_PI_2), -imageToCrop.image.size.width, 0);
            break;
        case UIImageOrientationDown:
            rectTransform = CGAffineTransformTranslate(CGAffineTransformMakeRotation(-M_PI), -imageToCrop.image.size.width, -imageToCrop.image.size.height);
            break;
        default:
            rectTransform = CGAffineTransformIdentity;
    };
    rectTransform = CGAffineTransformScale(rectTransform, imageToCrop.image.scale, imageToCrop.image.scale);
    
    CGImageRef imageRef = CGImageCreateWithImageInRect([imageToCrop.image CGImage], CGRectApplyAffineTransform(frame, rectTransform));
    UIImage *croppedImage = [UIImage imageWithCGImage:imageRef scale:imageToCrop.image.scale orientation:imageToCrop.image.imageOrientation];
    CGImageRelease(imageRef);
    
    return croppedImage;
}

- (void)dealloc {
    [btnSave release];
    [btnClose release];
    [super dealloc];
}
@end
