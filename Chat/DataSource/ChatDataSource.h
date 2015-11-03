//
//  ChatDataSource.h
//  Chat
//
//  Created by Maks on 10/11/15.
//  Copyright © 2015 Maks. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DataSourceDelegate;

@interface ChatDataSource : NSObject

@property (nonatomic, weak) id<DataSourceDelegate>delegate;

- (instancetype)initWithDelegate:(id<DataSourceDelegate>)delegate;
- (NSUInteger)countOfModels;
- (MessageObject *)modelAtIndex:(NSInteger)index;
- (void)sendMessageWithString:(NSString *)messageText;

@end

@protocol DataSourceDelegate <NSObject>

@optional

- (void)dataWasChanged;

@end




