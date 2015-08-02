
#import "TTYMessage.h"

@interface TTYMessage ()

@end

@implementation TTYMessage

#pragma mark -  Public

- (NSDate *)date
{
    if (self.dateInterval <= 0) {
        return nil;
    }

    return [NSDate dateWithTimeIntervalSince1970:self.dateInterval];
}

- (BOOL)isOutgoing
{
    return (self.sender == nil);
}

- (NSString *)description
{
    NSString *string = nil;

    if (self.messageText) {
        string = [self.messageText description];
    }
//    else if (self.messageFile) {
//        string = [self.messageFile description];
//    }

    return [NSString stringWithFormat:@"TTYMessage with date %@, %@", self.date, string];
}

@end
