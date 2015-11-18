//
//  LeftMenuVC.m
//  Chat
//
//  Created by Maks on 11/7/15.
//  Copyright © 2015 Maks. All rights reserved.
//

#import "LeftMenuVC.h"
#import "FriendsVC.h"

@interface LeftMenuVC()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) IBOutlet UITableView *leftMenuTableView;
@property (nonatomic, strong) NSArray *leftMenuItems;

@end

@implementation LeftMenuVC {
    NSArray *arrayVCid;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.leftMenuItems = @[@"Profile", @"Search friend",@"Friends"];
    arrayVCid = @[@"UserInfoVC", @"FriendsVC", @"UserFriendListVC"];
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
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    id vc = [self.storyboard instantiateViewControllerWithIdentifier:[arrayVCid objectAtIndex:indexPath.row]];
    
    [(UINavigationController *)[self.slideMenuController contentViewController] setViewControllers:@[vc] animated:YES];
    [self.slideMenuController hideMenu:YES];
}

@end
