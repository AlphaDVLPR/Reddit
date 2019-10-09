//
//  JRC_Post.m
//  RedditStarteriOS29
//
//  Created by AlphaDVLPR on 10/9/19.
//  Copyright © 2019 Jesse Rae. All rights reserved.
//

#import "JRC_Post.h"

static NSString * const kTitle = @"title";
static NSString * const kThumbnail = @"thumbnail";

@implementation JRC_Post

- (instancetype)initWithTitle:(NSString *)title thumbnail:(NSString *)thumbnail
{
    self = [super init];
    if (self) {
        //What you are initializing example: _name = name
        _title = title;
        _thumbnail = thumbnail;
}
    return self;
}

@end

@implementation JRC_Post (JSONConvertable)

- (instancetype)initWithDictionary:(NSDictionary<NSString *,id> *)dictionary
{
    NSString *title = dictionary[kTitle];
    NSString *thumbnail = dictionary[kThumbnail];
    
    return [self initWithTitle:title thumbnail:thumbnail];
}

@end
