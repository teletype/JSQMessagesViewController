/*
 Copyright (C) 2015 Apple Inc. All Rights Reserved.
 See LICENSE.txt for this sample’s licensing information
 
 Abstract:
 Base or common view controller to share a common UITableViewCell prototype between subclasses.
 */

#import "AppDelegate.h"
#import "APLBaseTableViewController.h"
#import "JSQMessages.h"
#import "ModelData.h"

NSString *const kCellIdentifier = @"AvatarIdentifier";

@implementation APLBaseTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
 }

- (void)configureCell:(UITableViewCell *)cell forAvatar:(Avatar *)avatar {
    cell.textLabel.text = avatar.displayName;
    NSString *avatarId =  avatar.avatarId;
    
    NSLog(@"AvatarId %@",avatarId);
    JSQMessagesAvatarImage *avatarImage = [gAppDelegate.modelData.avatars objectForKey:avatarId];
    cell.imageView.image=avatarImage.avatarImage;
}

- (NSMutableSet *)selectedAvatars {
    if (!_selectedAvatars) {
        _selectedAvatars = [NSMutableSet set];
    }
    return _selectedAvatars;
}
@end
