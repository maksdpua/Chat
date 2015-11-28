//
//  FriendsVC.m
//  Chat
//
//  Created by Maks on 11/7/15.
//  Copyright © 2015 Maks. All rights reserved.
//

#import "FriendsVC.h"
#import "User.h"
#import "AllFoundedUsers.h"
#import "APIRequestManager.h"
#import "SearchFriendCell.h"
#import "UserProfileVC.h"
#import "ConstantsOfAPI.h"

@interface FriendsVC()<UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) IBOutlet UISearchBar *searchBar;
@property (nonatomic, strong) IBOutlet UITableView *friendsTableView;
@property (nonatomic, strong) AllFoundedUsers *foundedUsers;

@end

@implementation FriendsVC

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark - UITableVIewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.foundedUsers.array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SearchFriendCell *cell = [tableView dequeueReusableCellWithIdentifier:kSearchFriendCell];
    [cell setupWithModel:[self.foundedUsers.array objectAtIndex:indexPath.row]];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    SearchFriendCell *cell = [tableView dequeueReusableCellWithIdentifier:kSearchFriendCell];
    return [cell loadWithHeight];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UserProfileVC *userInfoVC = [self.storyboard instantiateViewControllerWithIdentifier:@"UserProfileVC"];
    userInfoVC.userData = [self.foundedUsers.array objectAtIndex:indexPath.row];
    [(UINavigationController *)[self.slideMenuController contentViewController] setViewControllers:@[userInfoVC] animated:YES];
}

#pragma mark - UISearchBarDelegate

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    NSString *limit = @"10";
    NSString *searchPath = [NSString stringWithFormat: @"%@users?search=%@&limit=%@&offset=0", kURLServer, [searchText stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]], limit];
    
    [[APIRequestManager sharedInstance] GETConnectionWithURLString:searchPath classMapping:[AllFoundedUsers class] requestSerializer:YES showProgressOnView:nil response:^(AFHTTPRequestOperation *operation, id responseObject) {
        [responseObject printDescription];
        self.foundedUsers = (AllFoundedUsers *)responseObject;
        [self.friendsTableView reloadData];
    }fail:^(AFHTTPRequestOperation *operation, NSError *error){
        NSLog(@"%@", error);
    }];
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.view endEditing:YES];
}


@end
