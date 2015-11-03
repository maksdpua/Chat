//
//  ChatAPI.m
//  Chat
//
//  Created by Maks on 11/2/15.
//  Copyright © 2015 Maks. All rights reserved.
//

#import "ChatAPI.h"
#import "AFNetworking.h"
#import "ConstantsOfAPI.h"

@interface ChatAPI()

@property (nonatomic, strong) AFHTTPRequestOperationManager *managerRequest;
@property (nonatomic, strong) NSString *user_id;
@property (nonatomic, strong) NSString *user_session_hash;

@end

@implementation ChatAPI

+ (id)sharedInstance {
    static ChatAPI *sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[ChatAPI alloc] init];

    });
    
    return sharedInstance;
}


- (instancetype)init {
    self = [super init];
    if (self) {
        self.managerRequest = [AFHTTPRequestOperationManager manager];
        self.managerRequest.responseSerializer = [AFJSONResponseSerializer serializer];
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

- (void)loginUserWithEmailString:(NSString *)email passwordString:(NSString *)password {
    NSString *user_token = kToken;
    NSDictionary *params = @{@"user_email" : email,
                             @"user_password" : password,
                             @"user_token" : user_token};
    
    [self.managerRequest POST:[NSString stringWithFormat:@"%@%@", kURLServer, kLogin] parameters:params
                      success:^(AFHTTPRequestOperation *operation, id responseObject) {
                          NSLog(@"%@", [responseObject valueForKey:@"user_id"]);
                          NSLog(@"%@", [responseObject valueForKey:@"user_session_hash"]);

                          self.user_id = [responseObject valueForKey:@"user_id"];
                          self.user_session_hash = [responseObject valueForKey:@"user_session_hash"];
                          
                      }
                      failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
                          if (operation.responseData) {
                              NSError *jsonError = nil;
                              NSDictionary *json = [NSJSONSerialization JSONObjectWithData:operation.responseData options:NSJSONReadingMutableContainers error:&jsonError];
                              NSLog(@"%@",json);
                          }
                      }];
}


- (void)loadUserInfo {

    NSDictionary *params = @{@"user_session_hash" : self.user_session_hash, @"user_id" : self.user_id};
    
    [self.managerRequest GET :[NSString stringWithFormat:@"%@%@", kURLServer, kUserProfile] parameters:params
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              NSLog(@"%@", [responseObject valueForKey:@"user_info"]);
          }
          failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
              if (operation.responseData) {
                  NSError *jsonError = nil;
                  NSDictionary *json = [NSJSONSerialization JSONObjectWithData:operation.responseData options:NSJSONReadingMutableContainers error:&jsonError];
                  NSLog(@"%@",json);
              }
              
          }];
}

@end
