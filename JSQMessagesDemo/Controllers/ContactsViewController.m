//
//  ContactsViewController.m
//  JSQMessages
//
//  Created by Johan Sellström on 28/07/15.
//  Copyright (c) 2015 Hexed Bits. All rights reserved.
//

#import "ContactsViewController.h"
#import "ZLPeoplePickerViewController.h"

#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>
#import <MessageUI/MessageUI.h>

static int numSelectionSliderMaxValue = 100;

@interface ContactsViewController () <
ABPeoplePickerNavigationControllerDelegate, ABPersonViewControllerDelegate,
ZLPeoplePickerViewControllerDelegate, MFMailComposeViewControllerDelegate>

@property (nonatomic, assign) ABAddressBookRef addressBookRef;

@property (nonatomic, strong) ZLPeoplePickerViewController *peoplePicker;


@end

@implementation ContactsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Contacts";
    
    _addressBookRef = ABAddressBookCreateWithOptions(NULL, NULL);
    [ZLPeoplePickerViewController initializeAddressBook];
    
    self.peoplePicker = [[ZLPeoplePickerViewController alloc] init];
    self.peoplePicker.delegate = self;
    
    [self.navigationController pushViewController:self.peoplePicker animated:NO ];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

#pragma mark - ZLPeoplePickerViewControllerDelegate
- (void)peoplePickerViewController:(ZLPeoplePickerViewController *)peoplePicker
                   didSelectPerson:(NSNumber *)recordId {
    
    
    
}
- (void)peoplePickerViewController:(ZLPeoplePickerViewController *)peoplePicker
       didReturnWithSelectedPeople:(NSArray *)people {
    if (!people || people.count == 0) {
        return;
    }
   
    NSArray *toRecipients = [self emailsForPeople:people];
    [self showMailPicker:toRecipients];
 
}
- (void)newPersonViewControllerDidCompleteWithNewPerson:
(nullable ABRecordRef)person {
    NSLog(@"Added a new person");
}


#pragma mark Display and edit a person
- (void)showPersonViewController:(ABRecordID)recordId
          onNavigationController:
(UINavigationController *)navigationController {
    ABRecordRef person = (ABRecordRef)(
                                       ABAddressBookGetPersonWithRecordID(self.addressBookRef, recordId));
    
    if (person != NULL) {
        ABPersonViewController *picker = [[ABPersonViewController alloc] init];
        picker.personViewDelegate = self;
        picker.displayedPerson = person;
        // Allow users to edit the person’s information
        picker.allowsEditing = YES;
        picker.allowsActions = NO;
        picker.shouldShowLinkedPeople = YES;
        [navigationController pushViewController:picker animated:YES];
    } else {
        // Show an alert if "Appleseed" is not in Contacts
        UIAlertView *alert =
        [[UIAlertView alloc] initWithTitle:@"Error"
                                   message:@"Could not find the person in "
         @"the Contacts application"
                                  delegate:nil
                         cancelButtonTitle:@"Cancel"
                         otherButtonTitles:nil];
        [alert show];
    }
}

#pragma mark ABPersonViewControllerDelegate methods
// Does not allow users to perform default actions such as dialing a phone
// number, when they select a contact property.
- (BOOL)personViewController:(ABPersonViewController *)personViewController
shouldPerformDefaultActionForPerson:(ABRecordRef)person
                    property:(ABPropertyID)property
                  identifier:
(ABMultiValueIdentifier)identifierForValue {
    return NO;
}

#pragma mark - Compose Mail/SMS
- (void)displayMailComposerSheet:(NSArray *)recipients {
    MFMailComposeViewController *picker =
    [[MFMailComposeViewController alloc] init];
    picker.mailComposeDelegate = self;
    [picker setToRecipients:recipients];
    [picker setSubject:@"Check Out ZLPeoplePickerViewController!"];
    NSString *emailBody = @"Check Out ZLPeoplePickerViewController at "
    @"https://github.com/zhxnlai/" @"ZLPeoplePickerViewController";
    [picker setMessageBody:emailBody isHTML:NO];
    
    [self presentViewController:picker animated:YES completion:NULL];
}

- (void)showMailPicker:(NSArray *)recipients {
    // You must check that the current device can send email messages before you
    // attempt to create an instance of MFMailComposeViewController.  If the
    // device can not send email messages,
    // [[MFMailComposeViewController alloc] init] will return nil.  Your app
    // will crash when it calls -presentViewController:animated:completion: with
    // a nil view controller.
    if ([MFMailComposeViewController canSendMail])
        // The device can send email.
    {
        [self displayMailComposerSheet:recipients];
    } else
        // The device can not send email.
    {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"Cannot send text"
                              message:@"Device not configured to send email."
                              delegate:self
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        [alert show];
    }
}

- (void)mailComposeController:(MFMailComposeViewController *)controller
          didFinishWithResult:(MFMailComposeResult)result
                        error:(NSError *)error {
    // Notifies users about errors associated with the interface
    switch (result) {
        case MFMailComposeResultCancelled:
            break;
        case MFMailComposeResultSaved:
            break;
        case MFMailComposeResultSent:
            break;
        case MFMailComposeResultFailed:
            break;
        default:
            //            self.feedbackMsg.text = @"Result: Mail not sent";
            break;
    }
    
    [self dismissViewControllerAnimated:YES completion:NULL];
}

#pragma mark - ()
- (NSArray *)emailsForPeople:(NSArray *)recordIds {
    NSMutableArray *emails = [NSMutableArray array];
    for (NSNumber *recordId in recordIds) {
        [emails addObjectsFromArray:[self emailsForPerson:recordId]];
    }
    return emails;
}
- (NSArray *)emailsForPerson:(NSNumber *)recordId {
    return [self arrayProperty:kABPersonEmailProperty
                    fromRecord:[self recordRefFromRecordId:recordId]];
}
- (NSArray *)firstNameForPeople:(NSArray *)recordIds {
    NSMutableArray *firstNames = [NSMutableArray array];
    for (NSNumber *recordId in recordIds) {
        NSString *firstName = [self firstNameForPerson:recordId];
        if (firstName) {
            [firstNames addObject:firstName];
        }
    }
    return firstNames;
}
- (NSString *)firstNameForPerson:(NSNumber *)recordId {
    NSString *firstName = (__bridge_transfer NSString *)ABRecordCopyValue(
                                                                          [self recordRefFromRecordId:recordId], kABPersonFirstNameProperty);
    return firstName;
}
- (ABRecordRef)recordRefFromRecordId:(NSNumber *)recordId {
    return ABAddressBookGetPersonWithRecordID(self.addressBookRef,
                                              [recordId intValue]);
}
- (NSArray *)arrayProperty:(ABPropertyID)property
                fromRecord:(ABRecordRef)recordRef {
    NSMutableArray *array = [[NSMutableArray alloc] init];
    [self enumerateMultiValueOfProperty:property
                             fromRecord:recordRef
                              withBlock:^(ABMultiValueRef multiValue,
                                          NSUInteger index) {
                                  CFTypeRef value = ABMultiValueCopyValueAtIndex(
                                                                                 multiValue, index);
                                  NSString *string =
                                  (__bridge_transfer NSString *)value;
                                  if (string) {
                                      [array addObject:string];
                                  }
                              }];
    return array.copy;
}
- (void)enumerateMultiValueOfProperty:(ABPropertyID)property
                           fromRecord:(ABRecordRef)recordRef
                            withBlock:(void (^)(ABMultiValueRef multiValue,
                                                NSUInteger index))block {
    ABMultiValueRef multiValue = ABRecordCopyValue(recordRef, property);
    NSUInteger count = (NSUInteger)ABMultiValueGetCount(multiValue);
    for (NSUInteger i = 0; i < count; i++) {
        block(multiValue, i);
    }
    CFRelease(multiValue);
}

@end
