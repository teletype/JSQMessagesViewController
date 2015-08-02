/*
 Copyright (C) 2015 Apple Inc. All Rights Reserved.
 See LICENSE.txt for this sample’s licensing information
 
 Abstract:
 Base or common view controller to share a common UITableViewCell prototype between subclasses.
 */

#import "ModelData.h"

@import UIKit;

@class Avatar;

extern NSString *const kCellIdentifier;

@interface APLBaseTableViewController : UITableViewController

@property (strong, nonatomic) NSMutableSet *selectedAvatars;

- (void)configureCell:(UITableViewCell *)cell forAvatar:(Avatar *)avatar;

@end
