//
//  ChatDataSource.m
//  Chat
//
//  Created by Maks on 10/11/15.
//  Copyright © 2015 Maks. All rights reserved.
//

#import "ChatDataSource.h"
#import <SRWebSocket.h>
#import "MessageObject.h"
#import "Constants.h"



@interface ChatDataSource () <SRWebSocketDelegate>
{
    SRWebSocket *socketChat;
}

@property (nonatomic, strong) NSMutableArray *arrayOfMessages;

@end

@implementation ChatDataSource

- (instancetype)initWithDelegate:(id<DataSourceDelegate>)delegate {
    self = [super init];
    if (self) {
        self.delegate = delegate;
        socketChat = [[SRWebSocket alloc]initWithURL:[NSURL URLWithString:urlChat]];
        socketChat.delegate = self;
        [socketChat open];
    }
    return self;
}

#pragma mark - SRWebSocket Delegate Methods

- (void)webSocket:(SRWebSocket *)webSocket didReceiveMessage:(id)message {
    NSData *data = [message dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    
    if (json) {
        NSLog(@"%@", json);
        MessageObject *object = [[MessageObject alloc]init];
        object.userID = [json valueForKey:kUserID];
        object.recipientID = [json valueForKey:kRecipient_id];
        object.name = [json valueForKey:kName];
        object.lastName = [json valueForKey:kLastName];
        object.messageText = [json valueForKey:kMessageText];
        [self.arrayOfMessages addObject: object];
        if ([self.delegate respondsToSelector:@selector(dataWasChanged)]) {
            [self.delegate dataWasChanged];
        }
    }
}

- (void)sendMessageWithString:(NSString *)messageText {
    NSString *messageString = [NSString stringWithFormat:@"{\"message\":true,\"message_text\":\"%@\",\"recipient_id\":\"%@\",\"user_id\":%@,\"user_name\":\"%@\",\"user_lastname\":\"%@\"}", messageText, recipient_id, user_id, name, lastName];
    
    [socketChat send:messageString];
    
//    self.textField.text = @"";
}

- (NSUInteger)countOfModels {
    return [self.arrayOfMessages count];
}

- (MessageObject *)modelAtIndex:(NSInteger)index {
    return self.arrayOfMessages[index];
}


- (void)dealloc {
    socketChat.delegate = nil;
    [socketChat close];
}

@end
