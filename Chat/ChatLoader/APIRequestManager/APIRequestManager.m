//
//  APIRequestManager.m
//  Chat
//
//  Created by Maks on 11/12/15.
//  Copyright © 2015 Maks. All rights reserved.
//

#import "APIRequestManager.h"
#import "ConstantsOfAPI.h"
#import "MBProgressHUD.h"
#import "AuthorizeManager.h"

@interface APIRequestManager()

@property (nonatomic, strong) AFHTTPRequestOperationManager *managerRequest;

@end



@implementation APIRequestManager {
    NSDictionary *_parameters;
    NSString *_urlString;
    UIView *_view;
    Class _class;
    
//    AFHTTPRequestOperationManager *_manager;
    
    void (^_responseBlock)(AFHTTPRequestOperation *operation, id);
    void (^_failBlock)(AFHTTPRequestOperation *, NSError *error);

}

+ (instancetype)sharedInstance {
    static APIRequestManager *sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[APIRequestManager alloc] init];
//        sharedInstance.user_id = [NSNumber numberWithInteger:[[[NSUserDefaults standardUserDefaults] stringForKey:@"user_id"] integerValue]];
//        sharedInstance.user_session_hash = [[NSUserDefaults standardUserDefaults]stringForKey:@"user_session_hash"];
        
    });
    
    return sharedInstance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.managerRequest = [AFHTTPRequestOperationManager manager];
//        self.managerRequest.responseSerializer = [AFJSONResponseSerializer serializer];
        self.managerRequest.requestSerializer = [AFHTTPRequestSerializer serializer];
//        self.user_id = [[NSNumber alloc]init];
//        self.user_session_hash = [[NSString alloc]init];
    }
    return self;
}

- (NSDictionary *)dictionaryInstructionManager {
    return @{@"user_id" : @"userID", @"user_session_hash" : @"sessionHash"};
}

#pragma mark - POST & GET Methods

//- (void)manager {
//    _manager = [AFHTTPRequestOperationManager manager];
//}

- (void)setParameters:(NSDictionary *)dictionary {
    _parameters = dictionary;
}

- (void)setURLString:(NSString *)urlString {
    _urlString = urlString;
}

- (void)setView:(UIView *)view {
    _view = view;
}

- (void)setClass:(Class)theClass {
    _class = theClass;
}

- (void)setResponseBlock:(void (^)(AFHTTPRequestOperation *, id))responseBlock {
    _responseBlock = responseBlock;
}

- (void)setFailBlock:(void (^)(AFHTTPRequestOperation *, NSError *))failBlock {
    _failBlock = failBlock;
}

- (void)requestSerializer {
//    _manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    [self.managerRequest.requestSerializer setValue:[AuthorizeManager userID] forHTTPHeaderField:userIDKey];
    [self.managerRequest.requestSerializer setValue:[AuthorizeManager sessionHash] forHTTPHeaderField:sessionHashKey];
}

- (void)connectionStartPOST {
    
    [self.managerRequest POST:_urlString parameters:_parameters success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        dispatch_async(dispatch_get_main_queue(), ^(void){
            [self hiddenProgressOnView:_view];
            _responseBlock(operation, _class ? [self fillObjectResponseWithDictionary:responseObject] : responseObject);
        });
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        dispatch_async(dispatch_get_main_queue(), ^(void){
            
            [self hiddenProgressOnView:_view];
            _failBlock(operation, error);
        });
    }];
}

- (void)connectionStartGET {
    
    [self.managerRequest GET:_urlString parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        dispatch_async(dispatch_get_main_queue(), ^(void){
            [self hiddenProgressOnView:_view];
            _responseBlock(operation, _class ? [self fillObjectResponseWithDictionary:responseObject] : responseObject);
        });
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        dispatch_async(dispatch_get_main_queue(), ^(void){
            [self hiddenProgressOnView:_view];
            _failBlock(operation, error);
        });

    }];
}

- (void)connectionStartPUT {
    [self.managerRequest PUT:_urlString parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id _Nonnull responseObject) {
        dispatch_async(dispatch_get_main_queue(), ^(void){
            [self hiddenProgressOnView:_view];
            _responseBlock(operation, _class ? [self fillObjectResponseWithDictionary:responseObject] : responseObject);
        });
    }failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        dispatch_async(dispatch_get_main_queue(), ^(void){
            [self hiddenProgressOnView:_view];
            _failBlock(operation, error);
        });
    }];
}

- (id)fillObjectResponseWithDictionary:(NSDictionary *)dictionary {
    
//    SEL selector = sel_registerName(SELECTOR_NAME);
    id obj = [_class alloc];
    if ([obj respondsToSelector:@selector(initClassWithDictionary:)]) {
        obj = [obj initClassWithDictionary:dictionary];
    }
    [obj printDescription];
    return obj;
}

- (void)showProgressOnView:(UIView *)view {
    if (!view) return;
    [MBProgressHUD showHUDAddedTo:view animated:YES];
}

- (void)hiddenProgressOnView:(UIView *)view {
    if (!view) return;
    [MBProgressHUD hideHUDForView:view animated:YES];
}

- (void)fillManagerURLString:(NSString *)urlString parameters:(NSDictionary *)parameters classMapping:(__unsafe_unretained Class)classMapping showProgressOnView:(UIView *)view response:(void (^)(AFHTTPRequestOperation *, id))response fail:(void (^)(AFHTTPRequestOperation *, NSError *))failure  {
//    [self manager];
    
    [self setURLString:urlString];
    [self setParameters:parameters];
    [self setClass:classMapping];
    [self setView:view];
    [self setResponseBlock:response];
    [self setFailBlock:failure];
    
    [self showProgressOnView:view];
}

- (void)POSTConnectionWithURLString:(NSString *)urlString parameters:(NSDictionary *)parameters classMapping:(Class)classMapping requestSerializer:(BOOL)withSerializer showProgressOnView:(UIView *)view response:(void (^)(AFHTTPRequestOperation *operation, id responseObject))response fail:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    
    [self fillManagerURLString:urlString parameters:parameters classMapping:classMapping showProgressOnView:view response:response fail:failure];
    
    if (withSerializer) {
        [self requestSerializer];
    }
    [self connectionStartPOST];
}

- (void)GETConnectionWithURLString:(NSString *)urlString classMapping:(Class)classMapping requestSerializer:(BOOL)withSerializer showProgressOnView:(UIView *)view response:(void (^)(AFHTTPRequestOperation *operation, id responseObject))response fail:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    
    
    [self fillManagerURLString:urlString parameters:nil classMapping:classMapping showProgressOnView:view response:response fail:failure];
    
    if (withSerializer) {
        [self requestSerializer];
    }
    [self connectionStartGET];
}

- (void)PUTConnectionWithURLString:(NSString *)urlString classMapping:(Class)classMapping requestSerializer:(BOOL)withSerializer showProgressOnView:(UIView *)view response:(void (^)(AFHTTPRequestOperation *operation, id responseObject))response fail:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    
    [self fillManagerURLString:urlString parameters:nil classMapping:classMapping showProgressOnView:view response:response fail:failure];
    
    if (withSerializer) {
        [self requestSerializer];
    }
    [self connectionStartPUT];
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
