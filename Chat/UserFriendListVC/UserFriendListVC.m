//
//  UserFriendListVC.m
//  Chat
//
//  Created by Maks on 11/18/15.
//  Copyright © 2015 Maks. All rights reserved.
//

#import "UserFriendListVC.h"
#import "User.h"
#import "UserCell.h"
#import "UserFriendList.h"
#import "APIRequestManager.h"
#import "ConstantsOfAPI.h"
#import "AuthorizeManager.h"

@interface UserFriendListVC()<UITableViewDataSource, UITableViewDataSource>

@property (nonatomic, strong) UserFriendList *userFriendList;

@end

@implementation UserFriendListVC
- (void)viewDidLoad {
    [super viewDidLoad];
    [self getFriendList];
}

- (void)getFriendList {
    [[APIRequestManager sharedInstance] GETConnectionWithURLString:[NSString stringWithFormat:@"%@%@%@", kURLServer, kGetUserFrinedList, [AuthorizeManager sharedAuthorization].userID] classMapping:[UserFriendList class] requestSerializer:YES showProgressOnView:nil response:^(AFHTTPRequestOperation *operation, id responseObject) {
        [responseObject printDescription];
        NSLog(@"%@", responseObject);
        self.userFriendList = (UserFriendList *)responseObject;
    }fail:^(AFHTTPRequestOperation *operation, NSError *error){
        NSLog(@"%@", error);
    }];
}

#pragma mark - UITableVIewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.self.userFriendList.friendsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
     UserCell *cell = [tableView dequeueReusableCellWithIdentifier:kUserCell];
    [cell setupWithModel:[self.userFriendList.friendsArray objectAtIndex:indexPath.row]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    UserProfileVC *userInfoVC = [self.storyboard instantiateViewControllerWithIdentifier:@"UserProfileVC"];
//    userInfoVC.userData = [self.foundedUsers.array objectAtIndex:indexPath.row];
//    [(UINavigationController *)[self.slideMenuController contentViewController] setViewControllers:@[userInfoVC] animated:YES];
}


@end
