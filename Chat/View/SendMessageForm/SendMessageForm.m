//
//  SendMessageForm.m
//  Chat
//
//  Created by Maks on 11/25/15.
//  Copyright © 2015 Maks. All rights reserved.
//

#import "SendMessageForm.h"
#import "APIRequestManager.h"
#import "ConstantsOfAPI.h"

static int kCornerRadiusOfElementsMessageForm = 5;

@interface SendMessageForm()<UITextViewDelegate>

@property (nonatomic, weak) IBOutlet UITextView *messageTextView;
@property (nonatomic, weak) IBOutlet UIImageView *userAvatar;
@property (nonatomic, weak) IBOutlet UILabel *userNameLabel;
@property (nonatomic, weak) IBOutlet UIButton *sendButton;
@property (nonatomic, weak) IBOutlet UIButton *cancelButton;


@property IBOutlet NSLayoutConstraint *imageViewConstraint;
@property IBOutlet NSLayoutConstraint *userNameLabelConstraint;
@property IBOutlet NSLayoutConstraint *sendButtonConstraint;


@property (nonatomic, weak) NSString *user_id;

@end

@implementation SendMessageForm {
    CGFloat startSizeOfImageConstraint;
    CGFloat startSizeOfSendButtonConstraint;
}

- (instancetype)initOnView:(UIView *)view withUser:(User *)user{
    self = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil]firstObject];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector (keyboardWillShow:)
                                                     name:UIKeyboardWillShowNotification
                                                   object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector (keyboardWillHide:)
                                                     name:UIKeyboardWillHideNotification
                                                   object:nil];
        self.frame = view.frame;
        self.userNameLabel.layer.cornerRadius = kCornerRadiusOfElementsMessageForm;
        self.sendButton.layer.cornerRadius = kCornerRadiusOfElementsMessageForm;
        self.cancelButton.layer.cornerRadius = kCornerRadiusOfElementsMessageForm;
        self.messageTextView.layer.cornerRadius = kCornerRadiusOfElementsMessageForm;
        [self.sendButton setEnabled:NO];
        self.user_id = user.userID;
        self.userNameLabel.text = user.userName;
        [self.userAvatar setImageWithURL:[NSURL URLWithString:[self checkForImageAvatarPath:user.userThumbnailAvatar]] placeholderImage:[UIImage placeholderImage]];
        [view addSubview:self];
        [self showWithDuration:0.25 withAlpha:1];
    }
    return self;
}

- (void)showWithDuration:(CGFloat)duration withAlpha:(CGFloat)alpha {
    [UIView animateWithDuration:duration animations:^{
        self.alpha = alpha;
    }];
}

#pragma mark - Actions

- (IBAction)cancelButton:(id)sender {
    [self removeFromSuperview];
}

- (IBAction)sendButtonAction:(id)sender {

    NSDictionary *parametrs = @{@"message" : self.messageTextView.text};
    [[APIRequestManager sharedInstance] POSTConnectionWithURLString:[NSString stringWithFormat:@"%@%@%@", kURLServer, kSendmessage, self.user_id] parameters:parametrs classMapping:nil requestSerializer:YES showProgressOnView:nil response:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"Message send %@", responseObject);
        
    }fail:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", error);
    }];
    [self cancelButton:nil];
}



#pragma mark - UITextView delegate Methods

- (void)textViewDidChange:(UITextView *)textView {
    if ([self checkForSymbolsInString:self.messageTextView.text]) {
        [self.sendButton setEnabled:YES];
    }else{
        [self.sendButton setEnabled:NO];
    }
}

#pragma mark - Keyboard notifications Methods

- (void)keyboardWillShow:(NSNotification*)notification {
    NSDictionary *keyboardInfo = [notification userInfo];
    NSValue *keyboardFrameBegin = [keyboardInfo valueForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardFrameBeginRect = [keyboardFrameBegin CGRectValue];
    startSizeOfImageConstraint = self.imageViewConstraint.constant;
    startSizeOfSendButtonConstraint = self.sendButtonConstraint.constant;
    self.sendButtonConstraint.constant = keyboardFrameBeginRect.size.height+5;
    self.imageViewConstraint.constant = self.frame.origin.x;
    self.userNameLabelConstraint.constant = self.frame.origin.x;
    
    [self layoutIfNeeded];
}

- (void)keyboardWillHide:(NSNotification*)notification {

    self.imageViewConstraint.constant =   startSizeOfImageConstraint;
    self.userNameLabelConstraint.constant = startSizeOfImageConstraint;
    self.sendButtonConstraint.constant = startSizeOfSendButtonConstraint;
    [self layoutIfNeeded];
}

- (void)touchesEnded: (NSSet *) touches withEvent: (UIEvent *) event {
    [self.messageTextView resignFirstResponder];
}





@end
