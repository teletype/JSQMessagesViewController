//
//  Created by Jesse Squires
//  http://www.jessesquires.com
//
//
//  Documentation
//  http://cocoadocs.org/docsets/JSQMessagesViewController
//
//
//  GitHub
//  https://github.com/jessesquires/JSQMessagesViewController
//
//
//  License
//  Copyright (c) 2014 Jesse Squires
//  Released under an MIT license: http://opensource.org/licenses/MIT
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "DemoMessagesViewController.h"
#import "ContactsViewController.h"
#import <Realm/Realm.h>

@interface TableViewController : UITableViewController <JSQDemoViewControllerDelegate>

@property (strong, nonatomic) ModelData *modelData;
@property (nonatomic, strong) RLMNotificationToken *notification;
@property (nonatomic, strong) RLMResults *chats;

- (IBAction)unwindSegue:(UIStoryboardSegue *)sender;

@end
