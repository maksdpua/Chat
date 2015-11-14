//
//  MainNavigation.m
//  Chat
//
//  Created by Maks on 11/14/15.
//  Copyright © 2015 Maks. All rights reserved.
//

#import "MainNavigation.h"
#import "MainVC.h"
#import "MenuVC.h"
#import "AuthorizeManager.h"

@implementation MainNavigation

- (void)viewDidLoad {
    [super viewDidLoad];
    
    MainVC *mainVC = [self.storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([MainVC class])];
    NSMutableArray *arrayVC = [NSMutableArray new];
    [arrayVC addObject:mainVC];
    
    if ([AuthorizeManager sharedAuthorization].userID && [AuthorizeManager sharedAuthorization].sessionHash) {
        MenuVC *menuVC = [self.storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([MenuVC class])];
        [arrayVC addObject:menuVC];
    }
    [self setViewControllers:arrayVC animated:NO];
}

@end
