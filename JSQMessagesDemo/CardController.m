//
//  CardController.m
//  JSQMessages
//
//  Created by Johan Sellström on 27/07/15.
//  Copyright (c) 2015 Hexed Bits. All rights reserved.
//

#import "CardController.h"
#import "GMImagePickerController.h"

@import UIKit;
@import Photos;


@interface CardController () <GMImagePickerControllerDelegate, UINavigationControllerDelegate>
@end

@implementation CardController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    GMImagePickerController *picker = [[GMImagePickerController alloc] init];
    picker.delegate = self;
    picker.title = @"Assets";
    //picker.customNavigationBarPrompt = @"Custom helper message!";
    picker.colsInPortrait = 3;
    picker.colsInLandscape = 5;
    picker.minimumInteritemSpacing = 2.0;
    //picker.modalPresentationStyle = UIModalPresentationPopover;
    
    //UIPopoverPresentationController *popPC = picker.popoverPresentationController;
    //popPC.permittedArrowDirections = UIPopoverArrowDirectionAny;
    //   popPC.sourceView = _gmImagePickerButton;
    //  popPC.sourceRect = _gmImagePickerButton.bounds;
    [self presentViewController:picker animated:YES completion:nil];
    //[self showViewController:picker sender:nil];
    
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)launchGMImagePicker:(id)sender
{
}

#pragma mark - UIImagePickerControllerDelegate


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    [picker.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    NSLog(@"UIImagePickerController: User ended picking assets");
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    NSLog(@"UIImagePickerController: User pressed cancel button");
}

#pragma mark - GMImagePickerControllerDelegate

- (void)assetsPickerController:(GMImagePickerController *)picker didFinishPickingAssets:(NSArray *)assetArray
{
    [picker.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    
    NSLog(@"GMImagePicker: User ended picking assets. Number of selected items is: %lu", (unsigned long)assetArray.count);
}

//Optional implementation:
-(void)assetsPickerControllerDidCancel:(GMImagePickerController *)picker
{
    NSLog(@"GMImagePicker: User pressed cancel button");
}
@end
