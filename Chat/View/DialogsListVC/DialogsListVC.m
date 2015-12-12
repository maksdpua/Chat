//
//  DialogsListVC.m
//  Chat
//
//  Created by Maks on 11/24/15.
//  Copyright © 2015 Maks. All rights reserved.
//

#import "DialogsListVC.h"
#import "APIRequestManager.h"
#import "ConstantsOfAPI.h"
#import "Dialogs.h"
#import "DialogCell.h"
#import "User.h"
#import "DialogVC.h"
#import "DialogsEntity.h"
#import "DialogEntity.h"

@interface DialogsListVC()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong)Dialogs *allDialogs;
@property (nonatomic, strong)NSArray *dialogsArray;

@end

@implementation DialogsListVC

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self getDialogs];
    [self getDialogsWithCD];
}

- (void)getDialogsWithCD {
    [[APIRequestManager sharedInstance] GETConnectionWithURLString:[NSString stringWithFormat:@"%@%@%@%@%@",kURLServer, kDialogsOffeset, @"0",kDialogsLimit, @"10"] classMapping:[DialogsEntity class] requestSerializer:YES showProgressOnView:self.view response:^(AFHTTPRequestOperation *operation, id responseObject) {
//        self.dialogsArray = [DialogEntity MR_findAllSortedBy:@"messageDate" ascending:NO];
        
        DialogsEntity *dE = [DialogsEntity MR_findFirst];
        self.dialogsArray = [dE.dialogRS allObjects];
        
        [self.tableView reloadData];
    }fail:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", error);
    }];
}

#pragma mark - UITableView methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dialogsArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DialogCell *cell = [tableView dequeueReusableCellWithIdentifier:kDialogCell];
    [cell setupWithModel:[self.dialogsArray objectAtIndex:indexPath.row]];
    [cell updateConstraintsIfNeeded];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    DialogCell *cell = [tableView dequeueReusableCellWithIdentifier:kDialogCell];
    return [cell loadWithHeight];;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    DialogVC *dialogVC = [self.storyboard instantiateViewControllerWithIdentifier:@"DialogVC"];
    dialogVC.userData = [self.dialogsArray objectAtIndex:indexPath.row];
    NSLog(@"%@", dialogVC.userData.userID);
    NSLog(@"%@", dialogVC.userData.dialogID);
    [(UINavigationController *)[self.slideMenuController contentViewController] setViewControllers:@[dialogVC] animated:YES];
}



@end
