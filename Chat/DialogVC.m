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
#import "SocketManager.h"
#import "MessageObject.h"
#import "DismissKeyboardTapGesture.h"

static NSUInteger kCornerRadius = 5;

@interface DialogVC ()<UITableViewDelegate, UITableViewDelegate, UITextViewDelegate>

@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (nonatomic, weak) IBOutlet UITextView *textView;
@property IBOutlet NSLayoutConstraint *textFieldConstraint;
@property IBOutlet NSLayoutConstraint *textViewHeightCosntraint;
@property (nonatomic, strong)NSMutableArray *messagesArray;
@property (nonatomic, weak) IBOutlet UIButton *sendButton;
@property (nonatomic, weak) IBOutlet UIView *messageView;

@end

@implementation DialogVC {
    Messages *allMessages;
    CGFloat startHeightOfTextView;
//    DismissKeyboardTapGesture *_dismissKeyboard;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self settingsForVC];
    [self getMessages];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector (keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector (keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardFrameWillChange:)
                                                 name:UIKeyboardWillChangeFrameNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector (didRecieveMessage:)
                                                 name:kMessage
                                               object:nil];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)settingsForVC {
    self.textView.layer.cornerRadius = kCornerRadius;
    startHeightOfTextView = self.textView.frame.size.height;
    [self.sendButton setEnabled:NO];
}

- (void)didRecieveMessage:(NSNotification *)notification {
    MessageObject *messageObject = [[MessageObject alloc]initClassWithDictionary:notification.object];
    [self.messagesArray addObject:messageObject];
    NSInteger index = self.messagesArray.count - 1;
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    [self scrollToTheLastRowWithAnimation:YES];
}

- (void)getMessages {
    [[APIRequestManager sharedInstance] GETConnectionWithURLString:[NSString stringWithFormat:@"%@messages/%@?limit=20&offset=0", kURLServer, self.userData.userID] classMapping:[Messages class] requestSerializer:YES showProgressOnView:nil response:^(AFHTTPRequestOperation *operation, id responseObject){
        allMessages = (Messages *)responseObject;
        [self reverseAllmessages];
        [self.tableView reloadData];
        [self scrollToTheLastRowWithAnimation:NO];
        NSLog(@"%@", responseObject);
    }fail:^(AFHTTPRequestOperation *operation, NSError *error){
        NSLog(@"%@", error);
    }];
}

- (void)scrollToTheLastRowWithAnimation:(BOOL)animation {
    if (self.messagesArray.count>1) {
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.messagesArray.count-1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:animation];
    }
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
    [self updateTextViewHeightConstraint];
}

#pragma mark - Touches

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSSet *allTouches = [event allTouches];
    UITouch *touch = [[allTouches allObjects] objectAtIndex:0];
    CGPoint touchLocation = [touch locationInView:self.view];
    
    if (allTouches.count == 1 && touch.view == self.messageView) {
        
    }
}

#pragma mark - Keyboard notifications Methods

- (void)keyboardWillShow:(NSNotification*)notification {
    NSDictionary *keyboardInfo = [notification userInfo];
    NSValue *keyboardFrameBegin = [keyboardInfo valueForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardFrameBeginRect = [keyboardFrameBegin CGRectValue];
    [self.view setNeedsDisplay];
    
    [UIView animateWithDuration:0.25 animations:^{
        self.textFieldConstraint.constant = keyboardFrameBeginRect.size.height;
        [self.view layoutIfNeeded];
        if (self.messagesArray.count) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:[self.tableView numberOfRowsInSection:0] - 1 inSection:0];
            [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:NO];
        }
    }];
}

- (void)keyboardWillHide:(NSNotification*)notification {
    self.textFieldConstraint.constant = self.view.frame.origin.y;
    [self.view layoutIfNeeded];
    [self scrollToTheLastRowWithAnimation:YES];
}

- (void)keyboardFrameWillChange:(NSNotification *)notification
{
    CGRect keyboardEndFrame = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGRect keyboardBeginFrame = [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    UIViewAnimationCurve animationCurve = [[[notification userInfo] objectForKey:UIKeyboardAnimationCurveUserInfoKey] integerValue];
    NSTimeInterval animationDuration = [[[notification userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] integerValue];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:animationDuration];
    [UIView setAnimationCurve:animationCurve];
    
//    CGRect newFrame = self.view.frame;
//    CGRect keyboardFrameEnd = [self.view convertRect:keyboardEndFrame toView:nil];
//    CGRect keyboardFrameBegin = [self.view convertRect:keyboardBeginFrame toView:nil];
//    
//    newFrame.origin.y -= (keyboardFrameBegin.origin.y - keyboardFrameEnd.origin.y);
//    self.view.frame = newFrame;
    
    [UIView commitAnimations];
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
    [self updateTextViewHeightConstraint];
}

- (void)updateTextViewHeightConstraint {
    [self.view setNeedsDisplay];
    [UIView animateWithDuration:0.25 animations:^{
        CGFloat fixedWidth = self.textView.frame.size.width;
        CGSize newSize = [self.textView sizeThatFits:CGSizeMake(fixedWidth, MAXFLOAT)];
        CGRect newFrame = self.textView.frame;
        newFrame.size = CGSizeMake(fmaxf(newSize.width, fixedWidth), newSize.height);
        self.textViewHeightCosntraint.constant = newFrame.size.height;
        [self.view layoutIfNeeded];
        [self scrollToTheLastRowWithAnimation:NO];
    }];
    
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
    ChatCell *cell = [[ChatCell alloc]init];
    MessageObject *message = [self.messagesArray objectAtIndex:indexPath.row];
    if ([message.userID isEqualToString:[AuthorizeManager userID]]) {
        cell = [tableView dequeueReusableCellWithIdentifier:kUserDialogCell];
    } else if ([message.userID isEqualToString:self.userData.userID]){
        cell = [tableView dequeueReusableCellWithIdentifier:kSpeakerDialogCell];
    } else {
        NSLog(@"Wrong UserID %@",self.userData.userID);
    }
    [cell setupWithModel:message];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    ChatCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//    [cell loadWithFrame:tableView.frame];
//    return [cell heightForRowFromMessageObject:[self.messagesArray objectAtIndex:indexPath.row]].height+16+1;
    ChatCell *cell = [[ChatCell alloc]init];
    MessageObject *message = [self.messagesArray objectAtIndex:indexPath.row];
    if ([message.userID isEqualToString:[AuthorizeManager userID]]) {
        cell = [tableView dequeueReusableCellWithIdentifier:kUserDialogCell];
    } else if ([message.userID isEqualToString:self.userData.userID]){
        cell = [tableView dequeueReusableCellWithIdentifier:kSpeakerDialogCell];
    } else {
        NSLog(@"Wrong UserID %@",self.userData.userID);
    }
    [cell loadWithFrame:tableView.frame];
    return ([cell heightForRowFromMessageObject:message].height+16+1 < cell.cellAvatarImage.frame.size.height+8) ? cell.cellAvatarImage.frame.size.height+8 : [cell heightForRowFromMessageObject:message].height+16+1;
}

//- (void)tableView:(UITableView *)tableView willDisplayCell:(ChatCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
//    [cell loadWithFrame:tableView.frame];
//    [cell loadWithMessageObject:[self.messagesArray objectAtIndex:indexPath.row]];
//}



@end
