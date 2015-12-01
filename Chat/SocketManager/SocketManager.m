//
//  SocketManager.m
//  Chat
//
//  Created by Maks on 11/28/15.
//  Copyright © 2015 Maks. All rights reserved.
//

#import "SocketManager.h"
#import <SRWebSocket.h>

@interface SocketManager()<SRWebSocketDelegate>

@property (nonatomic, strong) SRWebSocket *socketChat;

@end

@implementation SocketManager {
}

+ (instancetype)sharedSocket {
    static SocketManager *sharedSocket;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedSocket = [[SocketManager alloc] init];
    });
    
    return sharedSocket;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.socketChat = [[SRWebSocket alloc] initWithURL:[NSURL URLWithString:urlChat]];
        self.socketChat.delegate = self;
        [self.socketChat open];
    }
    return self;
}

- (void)webSocket:(SRWebSocket *)webSocket didReceiveMessage:(id)message {
    NSData *data = [message dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    if ([json valueForKey: kAcceptFriend]) {
        [[NSNotificationCenter defaultCenter]postNotificationName:kAcceptFriend object:json];
    } else if ([json valueForKey: kAddFriend]) {
        [[NSNotificationCenter defaultCenter]postNotificationName:kAddFriend object:json];
    } else if ([json valueForKey: kMessage]) {
        [[NSNotificationCenter defaultCenter]postNotificationName:kMessage object:json];
    }

}

//- (void)dealloc {
//    [[NSNotificationCenter defaultCenter] removeObserver:self];
//    self.socketChat.delegate = nil;
//    [self.socketChat close];
//}

@end
