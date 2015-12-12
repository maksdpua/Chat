//
//  LeftMenuVC.m
//  Chat
//
//  Created by Maks on 11/7/15.
//  Copyright © 2015 Maks. All rights reserved.
//

#import "LeftMenuVC.h"
#import "FriendsVC.h"
#import "Friends.h"
#import "APIRequestManager.h"
#import "ConstantsOfAPI.h"
#import "AuthorizeManager.h"
#import "DialogsEntity.h"

@interface LeftMenuVC()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) IBOutlet UITableView *leftMenuTableView;
@property (nonatomic, strong) NSMutableArray *leftMenuItems;
@property (nonatomic, assign) BOOL checkFriendRequest;

@end

@implementation LeftMenuVC {
    NSMutableArray *arrayVCid;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.leftMenuItems = [[NSMutableArray alloc]init];
    arrayVCid = [[NSMutableArray alloc]init];
    [self.leftMenuItems addObjectsFromArray:@[@"Profile", @"Search friend",@"Friends", @"Dialogs", @"Logout"]];
    [arrayVCid addObjectsFromArray:@[@"MyInfoVC", @"FriendsVC", @"UserFLVC", kDialogsListVC]];
}

- (void)checkForRequestToFriends {
//    __weak LeftMenuVC *weakSelf = self;
    
    [[APIRequestManager sharedInstance] GETConnectionWithURLString:[NSString stringWithFormat:@"%@%@%@", kURLServer, kFriendRequest,[AuthorizeManager userID]] classMapping:nil requestSerializer:YES showProgressOnView:nil response:^(AFHTTPRequestOperation *operation, id responseObject) {
        [responseObject printDescription];
        self.checkFriendRequest = YES;
    }fail:^(AFHTTPRequestOperation *operation, NSError *error){
        NSLog(@"%@", error);
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.leftMenuItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:CellIdentifier];
    }
    
    cell.textLabel.text = [self.leftMenuItems objectAtIndex:indexPath.row];
    
    CGRect frame = CGRectMake(150, 15, 10, 10);
    UILabel *label = [[UILabel alloc]initWithFrame:frame];
    label.backgroundColor = [UIColor redColor];
    [cell.contentView addSubview:label];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([[self.leftMenuItems objectAtIndex:indexPath.row] isEqualToString:@"Logout"]) {
        [self requestToLogout];
        [AuthorizeManager removeUserIdAndSessionHashData];
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        [self.navigationController popToRootViewControllerAnimated:YES];
        [self.slideMenuController hideMenu:YES];
    } else {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        id vc = [self.storyboard instantiateViewControllerWithIdentifier:[arrayVCid objectAtIndex:indexPath.row]];
        
        [(UINavigationController *)[self.slideMenuController contentViewController] setViewControllers:@[vc] animated:YES];
        [self.slideMenuController hideMenu:YES];
    }
    
}

- (void)requestToLogout {
    [[APIRequestManager sharedInstance] PUTConnectionWithURLString:[NSString stringWithFormat:@"%@%@", kURLServer, kLogout] classMapping:nil requestSerializer:YES showProgressOnView:self.view response:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@",responseObject);
        [DialogsEntity MR_truncateAll];
    } fail:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
    
}



@end
