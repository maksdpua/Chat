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
#import "MessageEntity.h"

static NSUInteger kCornerRadius = 5;
static NSString *kPhotoAdded = @"photoAdded";

@interface DialogVC ()<UITableViewDelegate, UITableViewDelegate, UITextViewDelegate, UIScrollViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (nonatomic, weak) IBOutlet UITextView *textView;
@property IBOutlet NSLayoutConstraint *textFieldConstraint;
@property IBOutlet NSLayoutConstraint *textViewHeightCosntraint;
@property IBOutlet NSLayoutConstraint *textViewBottomCosntraint;
@property (nonatomic, strong)NSMutableArray *messagesArray;
@property (nonatomic, weak) IBOutlet UIButton *sendButton;
@property (nonatomic, strong) IBOutlet UIView *messageView;
@property (nonatomic, strong) UIImagePickerController *imagePicker;

@end

@implementation DialogVC {
    
    CGFloat startHeightOfTextView;
    NSNumber *keyboardAnimationDuration;
    BOOL scrollHidesKeyboard;
    CGFloat keyboardHeight;
    UIImage *messagaPhoto;
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
                                             selector:@selector (didRecieveMessage:)
                                                 name:kMessage
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector (addPhotoImageInMessageView)
                                                 name:kPhotoAdded
                                               object:nil];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)settingsForVC {
    scrollHidesKeyboard = NO;
    self.textView.layer.cornerRadius = kCornerRadius;
    startHeightOfTextView = self.textView.frame.size.height;
    self.tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeInteractive;
    [self.sendButton setEnabled:NO];
}

- (void)didRecieveMessage:(NSNotification *)notification {
    [[APIRequestManager sharedInstance] GETConnectionWithURLString:[NSString stringWithFormat:@"%@messages/%@?limit=20&offset=0", kURLServer, self.userData.userID] classMapping:[MessageEntity class] requestSerializer:YES showProgressOnView:nil response:^(AFHTTPRequestOperation *operation, id responseObject){
        DialogEntity *dialog = [DialogEntity MR_findFirstByAttribute:@"dialogID" withValue:self.userData.dialogID];
        
        NSArray *sortedArray = [self sortAndAddNewMessagesWithArray:dialog.messageRS.allObjects];
        
        [self reverseAllmessagesToMessageArrayWithArray:sortedArray];
        [self insertNewRowInTableView];
        [self scrollToTheLastRowWithAnimation:YES];
    }fail:^(AFHTTPRequestOperation *operation, NSError *error){
        NSLog(@"%@", error);
    }];
}

- (void)getMessages {
    [[APIRequestManager sharedInstance] GETConnectionWithURLString:[NSString stringWithFormat:@"%@messages/%@?limit=20&offset=0", kURLServer, self.userData.userID] classMapping:[MessageEntity class] requestSerializer:YES showProgressOnView:nil response:^(AFHTTPRequestOperation *operation, id responseObject){
        DialogEntity *dialog = [DialogEntity MR_findFirstByAttribute:@"dialogID" withValue:self.userData.dialogID];
        NSArray *allMessages =  dialog.messageRS.allObjects;
        NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"messageDate" ascending:YES];
        NSArray *array = [allMessages sortedArrayUsingDescriptors:@[sortDescriptor]];
        self.messagesArray = [NSMutableArray arrayWithArray:array];

        [self.tableView reloadData];
        [self scrollToTheLastRowWithAnimation:NO];
    }fail:^(AFHTTPRequestOperation *operation, NSError *error){
        NSLog(@"%@", error);
    }];
}

- (NSArray *)sortAndAddNewMessagesWithArray:(NSArray*)array {
    
    NSMutableArray *arrayDialog = [NSMutableArray arrayWithArray:array];
    [arrayDialog removeObjectsInArray:self.messagesArray];
    [self.messagesArray addObjectsFromArray:arrayDialog];
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"messageDate" ascending:NO];
    
    return [self.messagesArray sortedArrayUsingDescriptors:@[sortDescriptor]];
}

- (void)insertNewRowInTableView {
    NSInteger index = self.messagesArray.count - 1;
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
}

- (void)scrollToTheLastRowWithAnimation:(BOOL)animation {
    if (self.messagesArray.count) {
        NSInteger countCells = [self.tableView numberOfRowsInSection:0];
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:countCells - 1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:animation];
    }
}

- (void)reverseAllmessagesToMessageArrayWithArray:(NSArray *)array {
    self.messagesArray = [NSMutableArray new];
    for (id element in [array reverseObjectEnumerator]) {
        [self.messagesArray addObject:element];
    }
}

- (void)addPhotoImageInMessageView {
    
    CGRect frame = CGRectMake(self.textView.frame.origin.x, self.textView.frame.origin.y+self.textView.frame.size.height+4, 30, 30);
    UIImageView *messagePhotoImage = [[UIImageView alloc]initWithFrame:frame];
    messagePhotoImage.image = messagaPhoto;
    messagePhotoImage.layer.masksToBounds = YES;
    messagePhotoImage.layer.cornerRadius = 8;
    
    [self.view setNeedsDisplay];
    [UIView animateWithDuration:5 delay:20 options:UIViewAnimationOptionBeginFromCurrentState animations:^(void){
        self.textViewBottomCosntraint.constant = self.textViewBottomCosntraint.constant + 35;
        [self.view layoutIfNeeded];
        [self.messageView addSubview:messagePhotoImage];
        [self.messageView bringSubviewToFront:messagePhotoImage];
        
    }completion:^(BOOL finished){
        
    }];
}

#pragma mark - Actions

- (IBAction)sendMessage:(id)sender {
    NSDictionary *parametrs = @{@"message" : self.textView.text};
    NSString *urlString = [NSString stringWithFormat:@"%@%@%@", kURLServer, kSendmessage, self.userData.userID];
    if (!messagaPhoto) {
        [[APIRequestManager sharedInstance] POSTConnectionWithURLString:urlString parameters:parametrs classMapping:nil requestSerializer:YES showProgressOnView:nil response:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"Message send %@", responseObject);
        }fail:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"%@", error);
        }];
    } else {
        [[APIRequestManager sharedInstance] POSTConnectionWithURLStringAndData:urlString parameters:parametrs key:@"message_photo1" image:messagaPhoto classMapping:nil requestSerializer:YES showProgressOnView:nil response:^(AFHTTPRequestOperation *operation, id responseObject){
            NSLog(@"Message send %@", responseObject);
        }fail:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"%@", error);
        }];
    }
    self.textView.text = @"";
    [self updateTextViewHeightConstraint];
    
}

- (IBAction)addPhoto:(id)sender {
    self.imagePicker = [[UIImagePickerController alloc]init];
    self.imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    self.imagePicker.delegate = self;
    [self presentViewController:self.imagePicker animated:YES completion:nil];
    
}

#pragma mark - UIImagePicker delegate Methods

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    messagaPhoto = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    [picker dismissViewControllerAnimated:YES completion:nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:kPhotoAdded object:nil];
    [self.sendButton setEnabled:YES];
}

#pragma mark - Keyboard notifications Methods

- (void)keyboardWillShow:(NSNotification*)notification {
    NSDictionary *keyboardInfo = [notification userInfo];
    NSValue *keyboardFrameBegin = [keyboardInfo valueForKey:UIKeyboardFrameBeginUserInfoKey];
    CGRect keyboardFrameBeginRect = [keyboardFrameBegin CGRectValue];
    keyboardHeight = keyboardFrameBeginRect.size.height;
    
    [self.view setNeedsDisplay];
    [UIView animateWithDuration:[self keyboardAnimationDurationForNotification:notification].doubleValue animations:^{
        self.textFieldConstraint.constant = keyboardFrameBeginRect.size.height;
        [self.view layoutIfNeeded];
        [self scrollToTheLastRowWithAnimation:NO];
    } completion:^(BOOL finished){
        scrollHidesKeyboard = YES;
    }];
}


- (void)keyboardWillHide:(NSNotification*)notification {
    
    scrollHidesKeyboard = NO;
    
    [self.view setNeedsDisplay];
    self.textFieldConstraint.constant = self.view.frame.origin.y;
    [self.view layoutIfNeeded];
    [self scrollToTheLastRowWithAnimation:NO];
}

- (NSNumber *)keyboardAnimationDurationForNotification: (NSNotification*)notification {
    keyboardAnimationDuration = [NSNumber numberWithDouble:[notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue]];
    return keyboardAnimationDuration;
}


#pragma mark - UIScrollViewDelegate methdods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGPoint positionInView = [scrollView.panGestureRecognizer locationInView:self.view];

    if (scrollHidesKeyboard && positionInView.y > self.view.frame.size.height - keyboardHeight - self.messageView.frame.size.height) {
        [self.view setNeedsDisplay];
        [UIView animateWithDuration:0 animations:^{
            [scrollView resignFirstResponder];
            
            self.textFieldConstraint.constant = self.view.frame.size.height - positionInView.y - self.messageView.frame.size.height;
            [self.view layoutIfNeeded];
        } completion:^(BOOL finished){
        }];
    
        
    }
}


#pragma mark - TextViewConstraintUpdateMethod

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

#pragma mark - UITextView Delegate Methods

- (void)textViewDidEndEditing:(UITextView *)textView {
    [self.textView resignFirstResponder];
}

- (void)textViewDidChange:(UITextView *)textView {
    if ([self checkForSymbolsInString:self.textView.text] || messagaPhoto) {
        [self.sendButton setEnabled:YES];
    } else {
        [self.sendButton setEnabled:NO];
    }
    [self updateTextViewHeightConstraint];
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
    MessageEntity *message = [self.messagesArray objectAtIndex:indexPath.row];
    if ([[message userID] isEqualToString:[AuthorizeManager userID]]) {
        cell = [tableView dequeueReusableCellWithIdentifier:kUserDialogCell];
    } else if ([[message userID] isEqualToString:self.userData.userID]){
        cell = [tableView dequeueReusableCellWithIdentifier:kSpeakerDialogCell];
    } else {
        NSLog(@"Wrong UserID %@",self.userData.userID);
    }
    [cell setupWithModel:message];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    ChatCell *cell = [[ChatCell alloc]init];
    MessageEntity *message = [self.messagesArray objectAtIndex:indexPath.row];
    if ([[message userID] isEqualToString:[AuthorizeManager userID]]) {
        cell = [tableView dequeueReusableCellWithIdentifier:kUserDialogCell];
    } else if ([[message userID] isEqualToString:self.userData.userID]){
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
