//
//  ChatAPI.h
//  Chat
//
//  Created by Maks on 11/2/15.
//  Copyright © 2015 Maks. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>

@interface HTTPManager : NSObject

@property (nonatomic, readonly) NSString *user_id;
@property (nonatomic, readonly) NSString *user_session_hash;

+ (instancetype)sharedInstance;

- (void)registrateUserWithNameString:(NSString*)name emailString:(NSString *)email date:(NSInteger)date passwordString:(NSString *)password;

- (void)loginUserWithEmailString:(NSString *)email passwordString:(NSString *)password compliction:(void (^)())compliction failure:(void (^)(NSString *errorText))failure;

- (void)loadUserInfoCompliction:(void (^)(NSDictionary *dictionary))compliction failure:(void (^)(NSString *errorText))failure;

- (void)editUserProfileWithDictionary:(NSDictionary *)dictionary;

- (BOOL)isSavedUserIdAndSessionHashReachable;

- (BOOL)isNetworkReachable;

@end
