//
//  ViewController.m
//  Chat
//
//  Created by Maks on 10/11/15.
//  Copyright © 2015 Maks. All rights reserved.
//

#import "DialogVC.h"
#import <SRWebSocket.h>
#import "ChatCell.h"
#import "Constants.h"
#import "MessageObject.h"
#import "APIRequestManager.h"
#import "ConstantsOfAPI.h"
#import "Messages.h"
#import "AuthorizeManager.h"

static int constantForConstraint = 8;


@interface DialogVC ()<UITableViewDelegate, UITableViewDelegate, UITextViewDelegate, SRWebSocketDelegate>
{
    SRWebSocket *socketChat;
}

@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (nonatomic, weak) IBOutlet UITextView *textView;
@property IBOutlet NSLayoutConstraint *textFieldConstraint;
@property (nonatomic, strong)NSMutableArray *messagesArray;
@property (nonatomic, weak) IBOutlet UIButton *sendButton;

@end

@implementation DialogVC {
    Messages *allMessages;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getMessages];
    [self.sendButton setEnabled:NO];
    socketChat = [[SRWebSocket alloc] initWithURL:[NSURL URLWithString:urlChat]];
    socketChat.delegate = self;
    [socketChat open];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector (keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector (keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector (keyboardDidShow:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
    
}

- (void)dealloc {
    socketChat.delegate = nil;
    [socketChat close];
}

- (void)webSocket:(SRWebSocket *)webSocket didReceiveMessage:(id)message {
    NSData *data = [message dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    
    User *userMessage = [[User alloc]initClassWithDictionary:json];
    
    if ([userMessage.userID isEqualToString:self.userData.userID]) {
        [self.messagesArray addObject:userMessage];
    }
    if ([userMessage.userID isEqualToString: [AuthorizeManager userID]]) {
        [self.messagesArray addObject:userMessage];
    }
    NSInteger index = self.messagesArray.count - 1;
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
//    [self.tableView reloadData];
    [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
}

- (void)getMessages {
    [[APIRequestManager sharedInstance] GETConnectionWithURLString:[NSString stringWithFormat:@"%@messages/%@?limit=20&offset=0", kURLServer, self.userData.userID] classMapping:[Messages class] requestSerializer:YES showProgressOnView:nil response:^(AFHTTPRequestOperation *operation, id responseObject){
        allMessages = (Messages *)responseObject;
        [self reverseAllmessages];
        [self.tableView reloadData];
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.messagesArray.count-1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:NO];
        NSLog(@"%@", responseObject);
    }fail:^(AFHTTPRequestOperation *operation, NSError *error){
        NSLog(@"%@", error);
    }];
}

- (void)reverseAllmessages {
    self.messagesArray = [NSMutableArray arrayWithCapacity:allMessages.array.count];
    for (id element in [allMessages.array reverseObjectEnumerator]) {
        [self.messagesArray addObject:element];
    }
}

#pragma mark - Actions

- (IBAction)sendMessage:(id)sender {

    NSDictionary *parametrs = @{@"message" : self.textView.text};
    [[APIRequestManager sharedInstance] POSTConnectionWithURLString:[NSString stringWithFormat:@"%@%@%@", kURLServer, kSendmessage, self.userData.userID] parameters:parametrs classMapping:nil requestSerializer:YES showProgressOnView:nil response:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"Message send %@", responseObject);
    }fail:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", error);
    }];
    self.textView.text = @"";
}


#pragma mark - SRWebSocket Delegate Methods


//- (void)webSocket:(SRWebSocket *)webSocket didReceiveMessage:(id)message {
//    NSData *data = [message dataUsingEncoding:NSUTF8StringEncoding];
//    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
//    
//    if (json) {
//        NSLog(@"%@", json);
//        MessageObject *object = [[MessageObject alloc]init];
//        object.userID = [json valueForKey:kUserID];
//        object.recipientID = [json valueForKey:kRecipient_id];
//        object.name = [json valueForKey:kName];
//        object.lastName = [json valueForKey:kLastName];
//        object.messageText = [json valueForKey:kMessageText];
//        [self.arrayOfMessages addObject:object];
//        [self.tableView reloadData];
//        
//        
//        
//        
//        //анимированное появление новых ячеек
////        NSInteger index = self.arrayOfMessages.count - 1;
////        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
////        [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
//    }
//}

#pragma mark - Keyboard notifications Methods

- (void)keyboardWillShow:(NSNotification*)notification {
    NSDictionary *keyboardInfo = [notification userInfo];
    NSValue *keyboardFrameBegin = [keyboardInfo valueForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardFrameBeginRect = [keyboardFrameBegin CGRectValue];
    self.textFieldConstraint.constant = keyboardFrameBeginRect.size.height;
    [self.view layoutIfNeeded];
}

- (void)keyboardWillHide:(NSNotification*)notification {
    self.textFieldConstraint.constant = constantForConstraint;
    [self.view layoutIfNeeded];
}

- (void)keyboardDidShow:(NSNotification*)notification {
    NSInteger index = self.messagesArray.count - 1;
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
//    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    //    [self.tableView reloadData];
    [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
}


#pragma mark - UITextView Delegate Methods

- (void)textViewDidEndEditing:(UITextView *)textView {
    [self.textView resignFirstResponder];
}

- (void)textViewDidChange:(UITextView *)textView {
    if ([self checkForSymbolsInString:self.textView.text]) {
        [self.sendButton setEnabled:YES];
    } else {
        [self.sendButton setEnabled:NO];
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    if (textView.text.length >= 300) {
        return NO;
    }
    return YES;
}

#pragma mark - UITableView Delegate Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.messagesArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ChatCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    User *message = [self.messagesArray objectAtIndex:indexPath.row];
    [message printDescription];
    cell.labelCell.text = message.messageText;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    ChatCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    [cell loadWithFrame:tableView.frame];
    return [cell heightForRowFromMessageObject:[self.messagesArray objectAtIndex:indexPath.row]].height+16+1;
    
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(ChatCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    [cell loadWithFrame:tableView.frame];
    [cell loadWithMessageObject:[self.messagesArray objectAtIndex:indexPath.row]];
    
}



@end
