//
//  NotificationService.m
//  OneSignalNotificationServiceExtension
//
//  Created by StrateCore - iMac1 on 31/05/18.
//  Copyright © 2018 StrateCore - iMac1. All rights reserved.
//

#import "NotificationService.h"
#import <OneSignal/OneSignal.h>

@interface NotificationService ()

@property (nonatomic, strong) void (^contentHandler)(UNNotificationContent *contentToDeliver);
@property (nonatomic, strong) UNMutableNotificationContent *bestAttemptContent;
@property (nonatomic, strong) UNNotificationRequest *receivedRequest;

@end

@implementation NotificationService


- (void)didReceiveNotificationRequest:(UNNotificationRequest *)request withContentHandler:(void (^)(UNNotificationContent * _Nonnull))contentHandler {
    self.receivedRequest = request;
    self.contentHandler = contentHandler;
    self.bestAttemptContent = [request.content mutableCopy];
    
 //  [OneSignal didReceiveNotificationExtensionRequest:self.receivedRequest withMutableNotificationContent:self.bestAttemptContent];
    
    // DEBUGGING: Uncomment the 2 lines below and comment out the one above to ensure this extension is excuting
    //            Note, this extension only runs when mutable-content is set
    //            Setting an attachment or action buttons automatically adds this
    // NSLog(@"Running NotificationServiceExtension");
    // self.bestAttemptContent.body = [@"[Modified] " stringByAppendingString:self.bestAttemptContent.body];
    
    self.contentHandler(self.bestAttemptContent);
}

- (void)serviceExtensionTimeWillExpire {
    // Called just before the extension will be terminated by the system.
    // Use this as an opportunity to deliver your "best attempt" at modified content, otherwise the original push payload will be used.
    
   // [OneSignal serviceExtensionTimeWillExpireRequest:self.receivedRequest withMutableNotificationContent:self.bestAttemptContent];
    
    self.contentHandler(self.bestAttemptContent);
}

@end


