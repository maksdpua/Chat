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

@interface DialogsListVC()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong)Dialogs *allDialogs;

@end

@implementation DialogsListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getDialogs];
}

- (void)getDialogs {
    [[APIRequestManager sharedInstance] GETConnectionWithURLString:[NSString stringWithFormat:@"%@%@%@%@%@",kURLServer, kDialogsOffeset, @"0",kDialogsLimit, @"10"] classMapping:[Dialogs class] requestSerializer:YES showProgressOnView:self.view response:^(AFHTTPRequestOperation *operation, id responseObject) {
        self.allDialogs = (Dialogs *)responseObject;
        [self.tableView reloadData];
    }fail:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", error);
    }];
    NSLog(@"%@", self.allDialogs);
}

#pragma mark - UITableView methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.allDialogs.array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DialogCell *cell = [tableView dequeueReusableCellWithIdentifier:kDialogCell];
    [cell setupWithModel:[self.allDialogs.array objectAtIndex:indexPath.row]];
    [cell updateConstraintsIfNeeded];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    DialogCell *cell = [tableView dequeueReusableCellWithIdentifier:kDialogCell];
    return [cell loadWithHeight];;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    DialogVC *dialogVC = [self.storyboard instantiateViewControllerWithIdentifier:@"DialogVC"];
    dialogVC.userData = [self.allDialogs.array objectAtIndex:indexPath.row];
    [(UINavigationController *)[self.slideMenuController contentViewController] setViewControllers:@[dialogVC] animated:YES];
}



@end
