//
//  UserInfoVCViewController.m
//  Chat
//
//  Created by Maks on 11/3/15.
//  Copyright © 2015 Maks. All rights reserved.
//

#import "UserInfoVC.h"
#import "ChatAPI.h"

@interface UserInfoVC ()

@end

@implementation UserInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [[ChatAPI sharedInstance]loadUserInfo];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
