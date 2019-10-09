//
//  JRC_PostController.h
//  RedditStarteriOS29
//
//  Created by AlphaDVLPR on 10/9/19.
//  Copyright © 2019 Jesse Rae. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JRC_Post.h"

NS_ASSUME_NONNULL_BEGIN

@interface JRC_PostController : NSObject

@property (nonatomic, copy) NSArray<JRC_Post *> *posts;

+ (instancetype) shared;

- (void)fetchPosts:(void (^)(BOOL))completion;

- (void)fetchImage:(JRC_Post *)post completion:(void (^) (UIImage * _Nullable))completion;

@end

NS_ASSUME_NONNULL_END
