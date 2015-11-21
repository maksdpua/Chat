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

@property (nonatomic, strong) NSMutableDictionary *allFriends;

@end

@implementation UserFriendListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.allFriends = @{}.mutableCopy;
    
    [self checkForNewFriends];
    [self getFriendList];
}

- (void)checkForNewFriends {
    [[APIRequestManager sharedInstance] GETConnectionWithURLString:[NSString stringWithFormat:@"%@%@%@", kURLServer, kFriendRequest, [AuthorizeManager userID]] classMapping: [Friends class] requestSerializer:YES showProgressOnView:nil response:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self.allFriends setObject:(Friends *)responseObject forKey:kUserRequestCell];
        [self.tableView reloadData];
    }fail:^(AFHTTPRequestOperation *operation, NSError *error){
        NSLog(@"%@", error);
    }];
}

- (void)getFriendList {
    [[APIRequestManager sharedInstance] GETConnectionWithURLString:[NSString stringWithFormat:@"%@%@%@", kURLServer, kGetUserFrinedList, [AuthorizeManager userID]] classMapping:[Friends class] requestSerializer:YES showProgressOnView:nil response:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self.allFriends setObject:(Friends *)responseObject forKey:kUserCell];
        [self.tableView reloadData];
    }fail:^(AFHTTPRequestOperation *operation, NSError *error){
        NSLog(@"%@", error);
    }];
}

- (NSArray *)arrayAtSection: (NSInteger)section {
    id obj =[self.allFriends valueForKey:[self.allFriends allKeys][section]];
    
    return [obj array];
}

- (id)objectAtIndexPath:(NSIndexPath *)indexPath {
    return [self arrayAtSection:indexPath.section][indexPath.row];
}

- (IBAction)acceptButton:(id)sender {
    NSDictionary *parametrs;
    UIButton *index = (UIButton *)sender;
    User *user = [self objectAtIndexPath:[NSIndexPath indexPathForRow:index.indexPathForButton.row inSection:0]];
    parametrs = @{@"confirm_friend" : @"1"};
    
    [[APIRequestManager sharedInstance] POSTConnectionWithURLString:[NSString stringWithFormat:@"%@%@%@", kURLServer, kFriendAccept, user.userID] parameters:parametrs classMapping:nil requestSerializer:YES showProgressOnView:self.view response:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@", responseObject);
        [self.tableView reloadData];
    }fail:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", error);
    }];
    
}


#pragma mark - UITableVIewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.allFriends.allKeys.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSString *key = [[self.allFriends allKeys] objectAtIndex:section];
    NSArray *arr = [[self.allFriends valueForKey:key] array];
    return arr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UserCell *cell = [tableView dequeueReusableCellWithIdentifier:[self.allFriends allKeys][indexPath.section]];
    [cell setupWithModel:[self objectAtIndexPath:indexPath]];

    cell.acceptButton.indexPathForButton = indexPath;
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [self.allFriends allKeys][section];
}

- (CGFloat)estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //    UserProfileVC *userInfoVC = [self.storyboard instantiateViewControllerWithIdentifier:@"UserProfileVC"];
    //    userInfoVC.userData = [self.foundedUsers.array objectAtIndex:indexPath.row];
    //    [(UINavigationController *)[self.slideMenuController contentViewController] setViewControllers:@[userInfoVC] animated:YES];
}


@end
