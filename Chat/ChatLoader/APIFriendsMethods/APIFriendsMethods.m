//
//  APIFriendsMethods.m
//  Chat
//
//  Created by Maks on 11/20/15.
//  Copyright © 2015 Maks. All rights reserved.
//

#import "APIFriendsMethods.h"
#import "Friends.h"
#import "AuthorizeManager.h"
#import "ConstantsOfAPI.h"

@implementation APIFriendsMethods
//
//- (void)checkForNewFriends {
//    [[APIRequestManager sharedInstance] GETConnectionWithURLString:[NSString stringWithFormat:@"%@%@%@", kURLServer, kFriendRequest, [AuthorizeManager userID]] classMapping: [Friends class] requestSerializer:YES showProgressOnView:nil response:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSLog(@"%@", responseObject);
//        NSLog(@"%@", self.requestForFriends.array);
//    }fail:^(AFHTTPRequestOperation *operation, NSError *error){
//        NSLog(@"%@", error);
//    }];
//}
//
//- (id)getFriendList {
//    [[APIRequestManager sharedInstance] GETConnectionWithURLString:[NSString stringWithFormat:@"%@%@%@", kURLServer, kGetUserFrinedList, [AuthorizeManager userID]] classMapping:[Friends class] requestSerializer:YES showProgressOnView:nil response:^(AFHTTPRequestOperation *operation, id responseObject) {
//        self.fri = (Friends *)responseObject;
//        NSLog(@"%@", self.userFriendList.array);
//    }fail:^(AFHTTPRequestOperation *operation, NSError *error){
//        NSLog(@"%@", error);
//    }];
//}

@end
