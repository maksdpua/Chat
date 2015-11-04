//
//  ChatAPI.m
//  Chat
//
//  Created by Maks on 11/2/15.
//  Copyright © 2015 Maks. All rights reserved.
//

#import "HTTPManager.h"
#import "AFNetworking.h"
#import "ConstantsOfAPI.h"
#import "MBProgressHUD.h"

@interface HTTPManager()

@property (nonatomic, strong) AFHTTPRequestOperationManager *managerRequest;
@property (nonatomic, strong) NSNumber *user_id;
@property (nonatomic, strong) NSString *user_session_hash;

@end

@implementation HTTPManager

+ (id)sharedInstance {
    static HTTPManager *sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[HTTPManager alloc] init];

    });
    
    return sharedInstance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.managerRequest = [AFHTTPRequestOperationManager manager];
        self.managerRequest.responseSerializer = [AFJSONResponseSerializer serializer];
        self.managerRequest.requestSerializer = [AFHTTPRequestSerializer serializer];
    }
    return self;
}


- (void)registrateUserWithNameString:(NSString*)name emailString:(NSString *)email date:(NSInteger)date passwordString:(NSString *)password {
    NSString *language = @"1";
    NSString *user_token = kToken;
    NSString *user_birthday = [NSString stringWithFormat:@"%tu", date];
    NSDictionary *params = @{@"user_name" : name,
                             @"user_email" : email,
                             @"user_password" : password,
                             @"user_token" : user_token,
                             @"user_birthday": user_birthday,
                             @"language" : language};
    
    [self.managerRequest POST:[NSString stringWithFormat:@"%@%@", kURLServer, kRegistrationPath] parameters:params
                      success:^(AFHTTPRequestOperation *operation, id responseObject) {
                          NSLog(@"%@", [responseObject valueForKey:@"message"]);
                      }
                      failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
                          if (operation.responseData) {
                              NSError *jsonError = nil;
                              NSDictionary *json = [NSJSONSerialization JSONObjectWithData:operation.responseData options:NSJSONReadingMutableContainers error:&jsonError];
                              NSLog(@"%@",json);
                          }
                      }];
}

- (void)loadUserInfoCompliction:(void (^)(NSDictionary *dictionary))compliction failure:(void (^)(NSString *errorText))failure  {
    [self.managerRequest.requestSerializer setValue:[self.user_id stringValue] forHTTPHeaderField:@"userid"];
    [self.managerRequest.requestSerializer setValue:self.user_session_hash forHTTPHeaderField:@"usersessionhash"];
    
    [self.managerRequest GET :[NSString stringWithFormat:@"%@%@", kURLServer, kUserProfile] parameters:nil
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              NSLog(@"%@", [responseObject valueForKey:@"user_info"]);
              compliction([responseObject valueForKey:@"user_info"]);
          }
          failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
              if (operation.responseData) {
                  NSError *jsonError = nil;
                  NSDictionary *json = [NSJSONSerialization JSONObjectWithData:operation.responseData options:NSJSONReadingMutableContainers error:&jsonError];
                  NSLog(@"%@",json);
                  failure([NSString stringWithFormat:@"%@", [json valueForKey:@"errors"]]);
              }
              
          }];    
}

- (void)loginUserWithEmailString:(NSString *)email passwordString:(NSString *)password compliction:(void (^)())compliction failure:(void (^)(NSString *errorText))failure {
    
    NSString *user_token = kToken;
    NSDictionary *params = @{@"user_email" : email,
                             @"user_password" : password,
                             @"user_token" : user_token};
    
    if (![[NSUserDefaults standardUserDefaults]stringForKey:@"user_email"]) {
        [[NSUserDefaults standardUserDefaults] setObject:email forKey:@"user_email"];
    }
    if (![[NSUserDefaults standardUserDefaults]stringForKey:@"user_password"]) {
        [[NSUserDefaults standardUserDefaults] setObject:password forKey:@"user_password"];
    }
    
    [self.managerRequest POST:[NSString stringWithFormat:@"%@%@", kURLServer, kLogin] parameters:params
                      success:^(AFHTTPRequestOperation *operation, id responseObject) {
                          NSLog(@"%@", [responseObject valueForKey:@"user_id"]);
                          NSLog(@"%@", [responseObject valueForKey:@"user_session_hash"]);
                          
                          self.user_id = [responseObject valueForKey:@"user_id"];
                          self.user_session_hash = [responseObject valueForKey:@"user_session_hash"];
                          compliction();
                      }
                      failure:^(AFHTTPRequestOperation  *_Nonnull operation, NSError  *_Nonnull error) {
                          if (operation.responseData) {
                              NSError *jsonError = nil;
                              NSDictionary *json = [NSJSONSerialization JSONObjectWithData:operation.responseData options:NSJSONReadingMutableContainers error:&jsonError];
                              NSLog(@"%@",json);
                              failure([NSString stringWithFormat:@"%@", [json valueForKey:@"errors"]]);
                          }
                      }];
}

- (BOOL)isNetworkReachable {
    
    if ([AFNetworkReachabilityManager sharedManager].reachable) {
        
        if ([AFNetworkReachabilityManager sharedManager].isReachableViaWiFi)
            NSLog(@"Network reachable via WWAN");
        else
            NSLog(@"Network reachable via Wifi");
        
        return YES;
    }
    else {
        
        NSLog(@"Network is not reachable");
        return NO;
    }
}
@end
