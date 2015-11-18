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
@property (nonatomic, readwrite) NSNumber *user_id;
@property (nonatomic, readwrite) NSString *user_session_hash;

@end

@implementation HTTPManager

+ (instancetype)sharedInstance {
    static HTTPManager *sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[HTTPManager alloc] init];
        sharedInstance.user_id = [NSNumber numberWithInteger:[[[NSUserDefaults standardUserDefaults] stringForKey:@"user_id"] integerValue]];
        sharedInstance.user_session_hash = [[NSUserDefaults standardUserDefaults]stringForKey:@"user_session_hash"];
        
    });
    
    return sharedInstance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.managerRequest = [AFHTTPRequestOperationManager manager];
        self.managerRequest.responseSerializer = [AFJSONResponseSerializer serializer];
        self.managerRequest.requestSerializer = [AFHTTPRequestSerializer serializer];
        self.user_id = [[NSNumber alloc]init];
        self.user_session_hash = [[NSString alloc]init];
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
    
    [self.managerRequest GET :[NSString stringWithFormat:@"%@%@", kURLServer, kMyProfile] parameters:nil
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

- (void)getRequestWithParameters: (NSDictionary *)dicParamters pathArgumentText:(NSString *)pathString compliction:(void (^)(NSDictionary *dictionary))compliction failure:(void (^)(NSString *errorText))failure {
    
    [self.managerRequest.requestSerializer setValue:[self.user_id stringValue] forHTTPHeaderField:@"userid"];
    [self.managerRequest.requestSerializer setValue:self.user_session_hash forHTTPHeaderField:@"usersessionhash"];
    
    [self.managerRequest GET :[NSString stringWithFormat:@"%@%@", kURLServer, pathString] parameters:dicParamters
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
    
    __weak HTTPManager *weakSelf = self;
    
    [self.managerRequest POST:[NSString stringWithFormat:@"%@%@", kURLServer, kLogin] parameters:params
                      success:^(AFHTTPRequestOperation *operation, id responseObject) {
                          NSLog(@"%@", [responseObject valueForKey:@"user_id"]);
                          NSLog(@"%@", [responseObject valueForKey:@"user_session_hash"]);
                          
                          weakSelf.user_id = [responseObject valueForKey:@"user_id"];
                          weakSelf.user_session_hash = [responseObject valueForKey:@"user_session_hash"];
                          
                          [[NSUserDefaults standardUserDefaults] setObject:weakSelf.user_id forKey:@"user_id"];
                          [[NSUserDefaults standardUserDefaults] setObject:weakSelf.user_session_hash forKey:@"user_session_hash"];
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

- (void)editUserProfileWithDictionary:(NSDictionary *)dictionary  {
    
    NSData *imageData = UIImageJPEGRepresentation([UIImage testImage], 0.5);
    
    [self.managerRequest POST:[NSString stringWithFormat:@"%@%@", kURLServer, kMyProfile] parameters:dictionary constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        if (imageData) {
            [formData appendPartWithFileData:imageData name:@"user_avatar" fileName:@"testImage.jpeg" mimeType:@"image/jpeg"];
        }
    } success:^(AFHTTPRequestOperation *operation, id responseObject){
        NSError *error;
        NSDictionary* json = [NSJSONSerialization
                              JSONObjectWithData:operation.responseData
                              options:kNilOptions
                              error:&error];
        NSLog(@"Registration JSON:- %@",json);
    }failure:^(AFHTTPRequestOperation *operation, NSError *error){
        NSLog(@"Error: %@", error);
    }];
    
}

- (BOOL)isSavedUserIdAndSessionHashReachable {
    if (self.user_id!=0 && self.user_session_hash) {
        return YES;
    }
    return NO;
}

- (BOOL)isNetworkReachable {
    if ([AFNetworkReachabilityManager sharedManager].reachable) {
        NSLog(@"Newtwork is reachable");
        return YES;
    }
    NSLog(@"Network is not reachable");
    return NO;
}
@end
