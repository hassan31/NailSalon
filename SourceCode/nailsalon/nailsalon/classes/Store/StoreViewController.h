//
//  StoreViewController.h
//  Pony
//
//  Created by Alexandra Smau on 4/30/13.
//  Copyright (c) 2013 Newrosoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <StoreKit/StoreKit.h>

@interface StoreViewController : UIViewController <SKProductsRequestDelegate, SKPaymentTransactionObserver>
{
    SKProduct *proUpgradeProduct;
    SKProductsRequest *productsRequest;
    NSArray *myProduct;
}

- (IBAction)backClick:(id)sender;
- (void)productClick:(UIButton*)sender;
- (void)requestProductData;
- (IBAction)restoreTransactions:(id)sender;

@end
