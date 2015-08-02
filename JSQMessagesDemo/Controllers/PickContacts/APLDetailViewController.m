/*
 Copyright (C) 2015 Apple Inc. All Rights Reserved.
 See LICENSE.txt for this sample’s licensing information
 
 Abstract:
 The detail view controller navigated to from our main and results table.
 */

#import "APLDetailViewController.h"
#import "ModelData.h"

@interface APLDetailViewController ()

@property (nonatomic, weak) IBOutlet UILabel *yearLabel;
@property (nonatomic, weak) IBOutlet UILabel *priceLabel;

@end


#pragma mark -

@implementation APLDetailViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.title = self.avatar.displayName;
    
    self.yearLabel.text = @"";
    /*
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    NSString *priceString = [numberFormatter stringFromNumber:self.product.introPrice];
     */
    self.priceLabel.text = @"";
}

@end



