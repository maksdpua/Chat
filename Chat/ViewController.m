//
//  ViewController.m
//  Chat
//
//  Created by Maks on 10/11/15.
//  Copyright © 2015 Maks. All rights reserved.
//

#import "ViewController.h"
#import <SRWebSocket.h>

static NSString *urlChat = @"ws://91.239.234.74:5241";

static NSString *user_id = @"6";
static NSString *recipient_id = @"7";
static NSString *name = @"Maks";
static NSString *lastName = @"Shvec";
static NSString *messageText = @"message_text";

static int constantForConstraint = 8;


@interface ViewController ()<UITableViewDelegate, UITableViewDelegate, SRWebSocketDelegate, UITextFieldDelegate>
{
    SRWebSocket *socketChat;
}

@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (nonatomic, weak) IBOutlet UITextField *textField;
@property (nonatomic, strong) NSMutableArray *arrayOfMessages;
@property IBOutlet NSLayoutConstraint *textFieldConstraint;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.arrayOfMessages = [[NSMutableArray alloc]init];
    socketChat = [[SRWebSocket alloc]initWithURL:[NSURL URLWithString:urlChat]];
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


- (void)webSocket:(SRWebSocket *)webSocket didReceiveMessage:(id)message {
    NSData *data = [message dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    
    if (json) {
        NSLog(@"%@", json);
        
        [self.arrayOfMessages addObject:[json valueForKey:messageText]];
        [self.tableView reloadData];
    }
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
    return [self.arrayOfMessages count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                       reuseIdentifier:CellIdentifier];
    }
    cell.textLabel.text = [self.arrayOfMessages objectAtIndex:indexPath.row];
    
    return cell;
}


@end
