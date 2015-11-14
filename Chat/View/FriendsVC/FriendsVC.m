//
//  FriendsVC.m
//  Chat
//
//  Created by Maks on 11/7/15.
//  Copyright © 2015 Maks. All rights reserved.
//

#import "FriendsVC.h"

@interface FriendsVC()

@property (nonatomic, weak) IBOutlet UISearchBar *searchBar;
@property (nonatomic, weak) IBOutlet UITableView *friendsTableView;

@end

@implementation FriendsVC

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark

#pragma mark - UITableVIewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:CellIdentifier];
    }
    

    
    return cell;
}


@end
