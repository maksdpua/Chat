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
#import "Friends.h"
#import "APIRequestManager.h"
#import "ConstantsOfAPI.h"
#import "AuthorizeManager.h"

@interface UserFriendListVC()<UITableViewDataSource, UITableViewDataSource>

@property (nonatomic, strong) Friends *userFriendList;
@property (nonatomic, strong) Friends *requestForFriends;

@end

@implementation UserFriendListVC

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self checkForNewFriends];
    [self getFriendList];
    [self.tableView reloadData];
    
}

- (void)checkForNewFriends {
    [[APIRequestManager sharedInstance] GETConnectionWithURLString:[NSString stringWithFormat:@"%@%@%@", kURLServer, kFriendRequest, [AuthorizeManager userID]] classMapping: [Friends class] requestSerializer:YES showProgressOnView:nil response:^(AFHTTPRequestOperation *operation, id responseObject) {
        self.requestForFriends = (Friends *)responseObject;
        NSLog(@"%@", self.requestForFriends.array);
    }fail:^(AFHTTPRequestOperation *operation, NSError *error){
        NSLog(@"%@", error);
    }];
}

- (void)getFriendList {

    [[APIRequestManager sharedInstance] GETConnectionWithURLString:[NSString stringWithFormat:@"%@%@%@", kURLServer, kGetUserFrinedList, [AuthorizeManager userID]] classMapping:[Friends class] requestSerializer:YES showProgressOnView:nil response:^(AFHTTPRequestOperation *operation, id responseObject) {
        self.userFriendList = (Friends *)responseObject;
        NSLog(@"%@", self.userFriendList.array);
        [self.tableView reloadData];
    }fail:^(AFHTTPRequestOperation *operation, NSError *error){
        NSLog(@"%@", error);
    }];
}


#pragma mark - UITableVIewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if ([self.requestForFriends.array count]>0) {
        return 2;
    }
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"FrientList count%@", self.userFriendList.array);
    if ([self.requestForFriends.array count]>0) {
        if (section==0) {
            return [self.requestForFriends.array count];
        } else {
            return [self.userFriendList.array count];
        }
    } else {
        return self.userFriendList.array.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
     UserCell *cell = [tableView dequeueReusableCellWithIdentifier:kUserCell];
    [cell setupWithModel:[self.userFriendList.array objectAtIndex:indexPath.row]];
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if ([self.requestForFriends.array count]>0) {
        if (section==0) {
            return @"Requests for friends";
        }
        else {
            return @"Friends";
        }
        
    } else {
        return @"Friends";
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    UserProfileVC *userInfoVC = [self.storyboard instantiateViewControllerWithIdentifier:@"UserProfileVC"];
//    userInfoVC.userData = [self.foundedUsers.array objectAtIndex:indexPath.row];
//    [(UINavigationController *)[self.slideMenuController contentViewController] setViewControllers:@[userInfoVC] animated:YES];
}


@end
