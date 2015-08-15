//
//  StoreViewController.m
//  Pony
//
//  Created by Alexandra Smau on 4/30/13.
//  Copyright (c) 2013 Newrosoft. All rights reserved.
//

#import "StoreViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "AppDelegate.h"
#import <StoreKit/StoreKit.h>
#import "Defines.h"

@implementation StoreViewController

- (id)init
{
    self = [super init];

    if([SKPaymentQueue canMakePayments])
	{
		NSLog(@"Can buy.");
		// Display a store to the user.
		//MyStoreObserver *observer = [[MyStoreObserver alloc] init];
		//[[SKPaymentQueue defaultQueue] addTransactionObserver:observer];
		[[SKPaymentQueue defaultQueue] addTransactionObserver:self];
        [self requestProductData];
	}
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if([SKPaymentQueue canMakePayments])
	{
		NSLog(@"Can buy.");
		// Display a store to the user.
		//MyStoreObserver *observer = [[MyStoreObserver alloc] init];
		//[[SKPaymentQueue defaultQueue] addTransactionObserver:observer];
		[[SKPaymentQueue defaultQueue] addTransactionObserver:self];
	}
	else
	{
		NSLog(@"Can NOT buy.");
		// Warn the user that purchases are disabled.
		UIAlertView *actionAlert;
        actionAlert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"In App Purchases are not available." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
		[actionAlert show];
        [actionAlert release];
	}
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark -

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskLandscape;
}

- (BOOL)shouldAutorotate
{
    return YES;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return (toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft || toInterfaceOrientation == UIInterfaceOrientationLandscapeRight);
}

#pragma mark - IBAction

- (IBAction)backClick:(id)sender
{
    //    CATransition *transition = [CATransition animation];
    //    transition.duration = 0.3f;
    //    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    //    transition.type = kCATransitionPush;
    //    transition.subtype = kCATransitionFromLeft;
    //    [self.navigationController.view.layer addAnimation:transition forKey:nil];
    
    [((AppDelegate*)[[UIApplication sharedApplication] delegate]) playSoundEffect:1];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)productClick:(UIButton*)sender
{
    [((AppDelegate*)[[UIApplication sharedApplication] delegate]) playSoundEffect:1];
    if([SKPaymentQueue canMakePayments])
    {
        if([myProduct count] > 0)
        {
            SKProduct *selectedProd = [myProduct objectAtIndex:sender.tag];
            
            NSLog(@"prod identifier: %@, tag: %d", selectedProd.productIdentifier, sender.tag);
            //SKPayment *payment = [SKPayment paymentWithProductIdentifier:kMyFeatureIdentifier];
            SKPayment *payment = [SKPayment paymentWithProduct:selectedProd];
            [[SKPaymentQueue defaultQueue] addPayment:payment];
        }
    }
}


#pragma mark - SKProductsRequest methods

- (void)completeTransaction:(SKPaymentTransaction*)transaction
{
	// Your application should implement these two methods.
    //[self recordTransaction: transaction];
    NSLog(@"id: %@", transaction.payment.productIdentifier);
	NSLog(@"Transaction complete.");
    [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
    
    
    if([transaction.payment.productIdentifier isEqualToString:kId1])
    {
        [[NSUserDefaults standardUserDefaults] setObject:@"NO" forKey:@"nailsLocked"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        ((AppDelegate*)[[UIApplication sharedApplication] delegate]).nailsLocked = NO;
        
        [[NSUserDefaults standardUserDefaults] setObject:@"NO" forKey:@"colorLocked"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        ((AppDelegate*)[[UIApplication sharedApplication] delegate]).colorLocked = NO;
        
        [[NSUserDefaults standardUserDefaults] setObject:@"NO" forKey:@"glossLocked"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        ((AppDelegate*)[[UIApplication sharedApplication] delegate]).glossLocked = NO;
        
        [[NSUserDefaults standardUserDefaults] setObject:@"NO" forKey:@"patternLocked"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        ((AppDelegate*)[[UIApplication sharedApplication] delegate]).patternLocked = NO;
        
        [[NSUserDefaults standardUserDefaults] setObject:@"NO" forKey:@"tipLocked"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        ((AppDelegate*)[[UIApplication sharedApplication] delegate]).tipLocked = NO;
        
        [[NSUserDefaults standardUserDefaults] setObject:@"NO" forKey:@"extrasLocked"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        ((AppDelegate*)[[UIApplication sharedApplication] delegate]).extrasLocked = NO;
        
        [[NSUserDefaults standardUserDefaults] setObject:@"NO" forKey:@"backgroundLocked"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        ((AppDelegate*)[[UIApplication sharedApplication] delegate]).backgroundLocked = NO;
    }
    else if([transaction.payment.productIdentifier isEqualToString:kId2])
    {
        [[NSUserDefaults standardUserDefaults] setObject:@"NO" forKey:@"colorLocked"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        ((AppDelegate*)[[UIApplication sharedApplication] delegate]).colorLocked = NO;
    }
    else if([transaction.payment.productIdentifier isEqualToString:kId3])
    {
        [[NSUserDefaults standardUserDefaults] setObject:@"NO" forKey:@"glossLocked"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        ((AppDelegate*)[[UIApplication sharedApplication] delegate]).glossLocked = NO;
    }
    else if([transaction.payment.productIdentifier isEqualToString:kId4])
    {
        [[NSUserDefaults standardUserDefaults] setObject:@"NO" forKey:@"patternLocked"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        ((AppDelegate*)[[UIApplication sharedApplication] delegate]).patternLocked = NO;
    }
    else if([transaction.payment.productIdentifier isEqualToString:kId5])
    {
        [[NSUserDefaults standardUserDefaults] setObject:@"NO" forKey:@"tipLocked"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        ((AppDelegate*)[[UIApplication sharedApplication] delegate]).tipLocked = NO;
    }
    else if([transaction.payment.productIdentifier isEqualToString:kId6])
    {
        [[NSUserDefaults standardUserDefaults] setObject:@"NO" forKey:@"extrasLocked"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        ((AppDelegate*)[[UIApplication sharedApplication] delegate]).extrasLocked = NO;
    }
    else if([transaction.payment.productIdentifier isEqualToString:kId7])
    {
        [[NSUserDefaults standardUserDefaults] setObject:@"NO" forKey:@"backgroundLocked"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        ((AppDelegate*)[[UIApplication sharedApplication] delegate]).backgroundLocked = NO;
    }
    
    UIAlertView *actionAlert = [[UIAlertView alloc] initWithTitle:@"Succes" message:@"Transaction complete!" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    [actionAlert show];
    [actionAlert release];
    
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"update" object:nil];
    //[[NSNotificationCenter defaultCenter] postNotificationName:@"upgraded" object:nil];
}

- (void)restoreTransaction:(SKPaymentTransaction*)transaction
{
	NSLog(@"Transaction restored.");
    NSLog(@"id: %@", transaction.payment.productIdentifier);
    
    [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
    
    
    if([transaction.payment.productIdentifier isEqualToString:kId1])
    {
        [[NSUserDefaults standardUserDefaults] setObject:@"NO" forKey:@"nailsLocked"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        ((AppDelegate*)[[UIApplication sharedApplication] delegate]).nailsLocked = NO;
        
        [[NSUserDefaults standardUserDefaults] setObject:@"NO" forKey:@"colorLocked"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        ((AppDelegate*)[[UIApplication sharedApplication] delegate]).colorLocked = NO;
        
        [[NSUserDefaults standardUserDefaults] setObject:@"NO" forKey:@"glossLocked"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        ((AppDelegate*)[[UIApplication sharedApplication] delegate]).glossLocked = NO;
        
        [[NSUserDefaults standardUserDefaults] setObject:@"NO" forKey:@"patternLocked"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        ((AppDelegate*)[[UIApplication sharedApplication] delegate]).patternLocked = NO;
        
        [[NSUserDefaults standardUserDefaults] setObject:@"NO" forKey:@"tipLocked"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        ((AppDelegate*)[[UIApplication sharedApplication] delegate]).tipLocked = NO;
        
        [[NSUserDefaults standardUserDefaults] setObject:@"NO" forKey:@"extrasLocked"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        ((AppDelegate*)[[UIApplication sharedApplication] delegate]).extrasLocked = NO;
        
        [[NSUserDefaults standardUserDefaults] setObject:@"NO" forKey:@"backgroundLocked"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        ((AppDelegate*)[[UIApplication sharedApplication] delegate]).backgroundLocked = NO;
    }
    else if([transaction.payment.productIdentifier isEqualToString:kId2])
    {
        [[NSUserDefaults standardUserDefaults] setObject:@"NO" forKey:@"colorLocked"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        ((AppDelegate*)[[UIApplication sharedApplication] delegate]).colorLocked = NO;
    }
    else if([transaction.payment.productIdentifier isEqualToString:kId3])
    {
        [[NSUserDefaults standardUserDefaults] setObject:@"NO" forKey:@"glossLocked"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        ((AppDelegate*)[[UIApplication sharedApplication] delegate]).glossLocked = NO;
    }
    else if([transaction.payment.productIdentifier isEqualToString:kId4])
    {
        [[NSUserDefaults standardUserDefaults] setObject:@"NO" forKey:@"patternLocked"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        ((AppDelegate*)[[UIApplication sharedApplication] delegate]).patternLocked = NO;
    }
    else if([transaction.payment.productIdentifier isEqualToString:kId5])
    {
        [[NSUserDefaults standardUserDefaults] setObject:@"NO" forKey:@"tipLocked"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        ((AppDelegate*)[[UIApplication sharedApplication] delegate]).tipLocked = NO;
    }
    else if([transaction.payment.productIdentifier isEqualToString:kId6])
    {
        [[NSUserDefaults standardUserDefaults] setObject:@"NO" forKey:@"extrasLocked"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        ((AppDelegate*)[[UIApplication sharedApplication] delegate]).extrasLocked = NO;
    }
    else if([transaction.payment.productIdentifier isEqualToString:kId7])
    {
        [[NSUserDefaults standardUserDefaults] setObject:@"NO" forKey:@"backgroundLocked"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        ((AppDelegate*)[[UIApplication sharedApplication] delegate]).backgroundLocked = NO;
    }
    
    
    UIAlertView *actionAlert = [[UIAlertView alloc] initWithTitle:@"Succes" message:@"Transaction restored!" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    [actionAlert show];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"update" object:nil];
    //[[NSNotificationCenter defaultCenter] postNotificationName:@"upgraded" object:nil];
}

//- (void)paymentQueueRestoreCompletedTransactionsFinished:(SKPaymentQueue*)queue
//{
//    for (SKPaymentTransaction *transaction in queue.transactions)
//    {
//        NSString *productID = transaction.payment.productIdentifier;
//        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:productID];
//        [[NSUserDefaults standardUserDefaults] synchronize];
//    }
//
//}

- (void)failedTransaction:(SKPaymentTransaction*)transaction
{
    if(transaction.error.code != SKErrorPaymentCancelled)
    {
		UIAlertView *actionAlert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Product purchase failed." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
		[actionAlert show];
        [actionAlert release];
    }
    else
    {
        [(AppDelegate*)[[UIApplication sharedApplication] delegate] showFullScreenAd];
        [(AppDelegate*)[[UIApplication sharedApplication] delegate] showChartboostAd];
    }
    
    [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
}

- (void)paymentQueue:(SKPaymentQueue*)queue updatedTransactions:(NSArray*)transactions
{
    for(SKPaymentTransaction *transaction in transactions)
    {
        switch(transaction.transactionState)
        {
            case SKPaymentTransactionStatePurchased:
                [self completeTransaction:transaction];
                break;
            case SKPaymentTransactionStateFailed:
                [self failedTransaction:transaction];
                break;
            case SKPaymentTransactionStateRestored:
                [self restoreTransaction:transaction];
            default:
                break;
        }
    }
}

- (void)requestProductData
{
	NSLog(@"about to retrieve products...");
    //	SKProductsRequest *request = [[SKProductsRequest alloc]
    //								 initWithProductIdentifiers:
    //								 [NSSet setWithObjects: kId0, kId1, kId2, kId3, nil]];
    //	request.delegate = self;
    //	[request start];
    
    
    productsRequest = [[SKProductsRequest alloc] initWithProductIdentifiers:[NSSet setWithObjects: kId1, kId2, kId3, kId4, kId5, kId6, kId7, nil]];
	productsRequest.delegate = self;
	[productsRequest start];
}


- (void)productsRequest:(SKProductsRequest*)request didReceiveResponse:(SKProductsResponse*)response
{
	myProduct = response.products;
    [myProduct retain];
	//NSArray *invalidProducts = response.invalidProductIdentifiers;
	// populate UI
	NSLog(@"Products:");
    
	for (int i = 0; i < [myProduct count]; i++)
    {
        //		NSLog(@"Product title: %@" , [[myProduct objectAtIndex:i] localizedTitle]);
        //		NSLog(@"Product description: %@" , [[myProduct objectAtIndex:i] localizedDescription]);
        //		NSLog(@"Product price: %@" , [[myProduct objectAtIndex:i] price]);
		NSLog(@"Product id: %@" , [[myProduct objectAtIndex:i] productIdentifier]);
	}	
	//[self.navigationController popViewControllerAnimated:YES];
}



//------------------------------------------------------------

- (IBAction)restoreTransactions:(id)sender
{
    [((AppDelegate*)[[UIApplication sharedApplication] delegate]) playSoundEffect:1];
    [[SKPaymentQueue defaultQueue] restoreCompletedTransactions];
}

@end
