//
//  APIRequestManager.h
//  Chat
//
//  Created by Maks on 11/12/15.
//  Copyright © 2015 Maks. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>

@interface APIRequestManager : NSObject


+ (instancetype)sharedInstance;

- (void)POSTConnectionWithURLString:(NSString *)urlString parameters:(NSDictionary *)parameters classMapping:(Class)classMapping requestSerializer:(BOOL)withSerializer showProgressOnView:(UIView *)view response:(void (^)(AFHTTPRequestOperation *operation, id responseObject))response fail:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

- (void)GETConnectionWithURLString:(NSString *)urlString classMapping:(Class)classMapping requestSerializer:(BOOL)withSerializer showProgressOnView:(UIView *)view response:(void (^)(AFHTTPRequestOperation *operation, id responseObject))response fail:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

- (void)PUTConnectionWithURLString:(NSString *)urlString classMapping:(Class)classMapping requestSerializer:(BOOL)withSerializer showProgressOnView:(UIView *)view response:(void (^)(AFHTTPRequestOperation *operation, id responseObject))response fail:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

- (BOOL)isNetworkReachable;

@end
