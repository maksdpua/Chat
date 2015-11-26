//
//  ConstantsOfAPI.h
//  Chat
//
//  Created by Maks on 11/2/15.
//  Copyright © 2015 Maks. All rights reserved.
//

#ifndef ConstantsOfAPI_h
#define ConstantsOfAPI_h

static  NSString *const kURLServer = @"http://dev.join2city.com.ua/api/";
static  NSString *const kRegistrationPath = @"registration";
static  NSString *const kLogin = @"login";
static  NSString *const kToken = @"<684576d7 aca6f450 ed04a006 9bcfdb87 300b1e7d eb3d9be0 c6c30153 65bac418>";

#pragma mark - User method url's
static  NSString *const kMyProfile = @"user/profile";
static  NSString *const kUserProfile = @"user/";

#pragma mark - Friend method url's

static  NSString *const kAddUserToFriends = @"friend/add/";
static  NSString *const kGetUserFrinedList = @"friends/";
static  NSString *const kFriendRequest = @"friends/pending/";
static  NSString *const kFriendAccept = @"friend/accept/";

#pragma mark - Logout method url's

static  NSString *const kLogout = @"user/logout";

#pragma mark - Message method url's

static  NSString *const kSendmessage = @"sendmessage/";
static  NSString *const kDialogsOffeset = @"user/dialogs/?offset=";
static  NSString *const kDialogsLimit = @"&limit=";


//static  NSString *const kUserIDForJC = @"userid";



#endif /* ConstantsOfAPI_h */
