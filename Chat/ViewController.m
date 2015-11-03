//
//  ViewController.m
//  Chat
//
//  Created by Maks on 10/11/15.
//  Copyright © 2015 Maks. All rights reserved.
//

#import "ViewController.h"
#import <SRWebSocket.h>
#import "ChatCell.h"
#import "Constants.h"
#import "MessageObject.h"
#import "ChatDataSource.h"

static int constantForConstraint = 8;


@interface ViewController ()<UITableViewDelegate, UITableViewDelegate, UITextFieldDelegate,DataSourceDelegate>
{
    SRWebSocket *socketChat;
}

@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (nonatomic, weak) IBOutlet UITextField *textField;
//@property (nonatomic, strong) NSMutableArray *arrayOfMessages;
@property IBOutlet NSLayoutConstraint *textFieldConstraint;
@property (nonatomic, strong) ChatDataSource *dataSource;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataSource = [[ChatDataSource alloc]initWithDelegate:self];
//    self.arrayOfMessages = [[NSMutableArray alloc]init];
//    socketChat = [[SRWebSocket alloc]initWithURL:[NSURL URLWithString:urlChat]];
//    socketChat.delegate = self;
//    [socketChat open];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector (keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector (keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

- (void)dealloc {
    socketChat.delegate = nil;
    [socketChat close];
}

#pragma mark - Actions

- (IBAction)sendMessage:(id)sender {
    NSString *messageString = [NSString stringWithFormat:@"{\"message\":true,\"message_text\":\"%@\",\"recipient_id\":\"%@\",\"user_id\":%@,\"user_name\":\"%@\",\"user_lastname\":\"%@\"}", self.textField.text, recipient_id, user_id, name, lastName];
    
    [socketChat send:messageString];
    
    self.textField.text = @"";
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

- (void)dataWasChanged {
    [self.tableView reloadData];
}

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


#pragma mark - UITextField Delegate Methods


- (BOOL)textFieldShouldReturn:(UITextField*)textField {
    [self.textField resignFirstResponder];
    return YES;
}


#pragma mark - UITableView Delegate Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataSource countOfModels];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ChatCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    MessageObject *message = [self.dataSource modelAtIndex:indexPath.row];
    cell.labelCell.text = message.messageText ;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    ChatCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    [cell loadWithFrame:tableView.frame];
    return [cell heightForRowFromMessageObject:[self.dataSource modelAtIndex:indexPath.row]].height+16+1;
    
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(ChatCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    [cell loadWithFrame:tableView.frame];
    [cell loadWithMessageObject:[self.dataSource modelAtIndex:indexPath.row]];
    
}


@end
