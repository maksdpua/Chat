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

typedef void (^responseBlock)(AFHTTPRequestOperation *operation, id responseObject);
typedef void (^failBlock)(AFHTTPRequestOperation *operation, NSError *error);
typedef void (^multipartBlock)(id<AFMultipartFormData> formData);

@end

@implementation APIRequestManager {
    NSDictionary *_parameters;
    NSString *_urlString;
    UIView *_view;
    Class _class;
    UIImage *_image;
    NSData *_dataWithImage;
    
}

+ (instancetype)sharedInstance {
    static APIRequestManager *sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[APIRequestManager alloc] init];
    });
    
    return sharedInstance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.managerRequest = [AFHTTPRequestOperationManager manager];
        self.managerRequest.requestSerializer = [AFHTTPRequestSerializer serializer];

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

- (void)setImage:(UIImage*)image{
    _image = image;
    _dataWithImage = UIImageJPEGRepresentation(_image, 0.5);
}

- (void)requestSerializer {
//    _manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    [self.managerRequest.requestSerializer setValue:[AuthorizeManager userID] forHTTPHeaderField:userIDKey];
    [self.managerRequest.requestSerializer setValue:[AuthorizeManager sessionHash] forHTTPHeaderField:sessionHashKey];
}

- (void)connectionStartPOSTresponse:(void (^)(AFHTTPRequestOperation *operation, id responseObject))response fail:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    
    responseBlock compl = response;
    failBlock fail = failure;
    
    [self.managerRequest POST:_urlString parameters:_parameters success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        dispatch_async(dispatch_get_main_queue(), ^(void){
            [self hiddenProgressOnView:_view];
            compl(operation, _class ? [self fillObjectResponseWithDictionary:responseObject] : responseObject);
        });
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        dispatch_async(dispatch_get_main_queue(), ^(void){
            
            [self hiddenProgressOnView:_view];
            fail(operation, error);
        });
    }];
}

- (void)connectionStartGETresponse:(void (^)(AFHTTPRequestOperation *operation, id responseObject))response fail:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    
    responseBlock compl = response;
    failBlock fail = failure;

    [self.managerRequest GET:_urlString parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        dispatch_async(dispatch_get_main_queue(), ^(void){
            [self hiddenProgressOnView:_view];
            compl(operation, _class ? [self fillObjectResponseWithDictionary:responseObject] : responseObject);
        });
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        dispatch_async(dispatch_get_main_queue(), ^(void){
            [self hiddenProgressOnView:_view];
            fail(operation, error);
        });

    }];
}

- (void)connectionStartPOSTresponseWithData:(void (^)(AFHTTPRequestOperation *operation, id responseObject))response fail:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {

    responseBlock compl = response;
    failBlock fail = failure;
    
    [self.managerRequest POST:_urlString parameters:_parameters
    constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
//        dispatch_async(dispatch_get_main_queue(), ^(void){
            if (_dataWithImage) {
                [formData appendPartWithFileData:_dataWithImage name:@"user_avatar" fileName:@"testImage.jpeg" mimeType:@"image/jpeg"];
            }
//        });
    }
                      success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
                          dispatch_async(dispatch_get_main_queue(), ^(void){
                              [self hiddenProgressOnView:_view];
                              compl(operation, _class ? [self fillObjectResponseWithDictionary:responseObject] : responseObject);
                          });
                      } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
                          dispatch_async(dispatch_get_main_queue(), ^(void){
                              
                              [self hiddenProgressOnView:_view];
                              fail(operation, error);
                          });
                      }];
    
}

- (void)connectionStartPUTresponse:(void (^)(AFHTTPRequestOperation *operation, id responseObject))response fail:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    
    responseBlock compl = response;
    failBlock fail = failure;
    
    [self.managerRequest PUT:_urlString parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id _Nonnull responseObject) {
        dispatch_async(dispatch_get_main_queue(), ^(void){
            [self hiddenProgressOnView:_view];
            compl(operation, _class ? [self fillObjectResponseWithDictionary:responseObject] : responseObject);
        });
    }failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        dispatch_async(dispatch_get_main_queue(), ^(void){
            [self hiddenProgressOnView:_view];
            fail(operation, error);
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

- (void)fillManagerURLString:(NSString *)urlString parameters:(NSDictionary *)parameters classMapping:(__unsafe_unretained Class)classMapping showProgressOnView:(UIView *)view {
//    [self manager];
    
    [self setURLString:urlString];
    [self setParameters:parameters];
    [self setClass:classMapping];
    [self setView:view];
    
    [self showProgressOnView:view];
}

- (void)POSTConnectionWithURLStringAndData:(NSString *)urlString parameters:(NSDictionary *)parameters image:(UIImage *)image classMapping:(Class)classMapping requestSerializer:(BOOL)withSerializer showProgressOnView:(UIView *)view response:(void (^)(AFHTTPRequestOperation *operation, id responseObject))response fail:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    
    [self fillManagerURLString:urlString parameters:parameters classMapping:classMapping showProgressOnView:view];
    
    [self setImage:image];
    
    if (withSerializer) {
        [self requestSerializer];
    }
    [self connectionStartPOSTresponseWithData:response fail:failure];
}


- (void)POSTConnectionWithURLString:(NSString *)urlString parameters:(NSDictionary *)parameters classMapping:(Class)classMapping requestSerializer:(BOOL)withSerializer showProgressOnView:(UIView *)view response:(void (^)(AFHTTPRequestOperation *operation, id responseObject))response fail:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    
    [self fillManagerURLString:urlString parameters:parameters classMapping:classMapping showProgressOnView:view];
    
    if (withSerializer) {
        [self requestSerializer];
    }
    [self connectionStartPOSTresponse:response fail:failure];
}

- (void)GETConnectionWithURLString:(NSString *)urlString classMapping:(Class)classMapping requestSerializer:(BOOL)withSerializer showProgressOnView:(UIView *)view response:(void (^)(AFHTTPRequestOperation *operation, id responseObject))response fail:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    
    
    [self fillManagerURLString:urlString parameters:nil classMapping:classMapping showProgressOnView:view];
    
    if (withSerializer) {
        [self requestSerializer];
    }
    [self connectionStartGETresponse:response fail:failure];
}

- (void)PUTConnectionWithURLString:(NSString *)urlString classMapping:(Class)classMapping requestSerializer:(BOOL)withSerializer showProgressOnView:(UIView *)view response:(void (^)(AFHTTPRequestOperation *operation, id responseObject))response fail:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    
    [self fillManagerURLString:urlString parameters:nil classMapping:classMapping showProgressOnView:view];
    
    if (withSerializer) {
        [self requestSerializer];
    }
    [self connectionStartPUTresponse:response fail:failure];
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
