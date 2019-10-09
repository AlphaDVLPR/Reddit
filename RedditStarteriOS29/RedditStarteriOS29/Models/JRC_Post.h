//
//  JRC_Post.h
//  RedditStarteriOS29
//
//  Created by AlphaDVLPR on 10/9/19.
//  Copyright © 2019 Jesse Rae. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JRC_Post : NSObject

//MARK: - Properties
@property (nonatomic, copy, readonly, nonnull) NSString *title;
@property (nonatomic, copy, readonly, nullable) NSString *thumbnail;

//MARK: - Initializer
- (instancetype)initWithTitle:(NSString *)title
                        thumbnail:(NSString *)thumbnail;

@end

@interface JRC_Post (JSONConvertable)

- (instancetype)initWithDictionary:(NSDictionary<NSString *, id> *)dictionary;

@end
NS_ASSUME_NONNULL_END
