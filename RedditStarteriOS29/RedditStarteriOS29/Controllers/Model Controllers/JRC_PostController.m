//
//  JRC_PostController.m
//  RedditStarteriOS29
//
//  Created by AlphaDVLPR on 10/9/19.
//  Copyright © 2019 Jesse Rae. All rights reserved.
//

#import "JRC_PostController.h"

static NSString * const kBaseUrlString = @"https://www.reddit.com";
static NSString * const kRComonentString = @"r";
static NSString * const KFunnyComponentString = @"funny";
static NSString * const KJsonExtension = @"json";

@implementation JRC_PostController

+ (instancetype)shared
{
    static JRC_PostController *shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared = [JRC_PostController new];
    });
    return shared;
}

- (void)fetchPosts:(void (^)(BOOL))completion
{
    //Build the URL
    NSURL * url = [NSURL URLWithString:kBaseUrlString];
    NSURL * rUrl = [url URLByAppendingPathComponent:kRComonentString];
    NSURL * funnyUrl = [rUrl URLByAppendingPathComponent:KFunnyComponentString];
    NSURL * finalUrl = [funnyUrl URLByAppendingPathExtension:KJsonExtension];
    
    //Start the URL Session
    [[[NSURLSession sharedSession] dataTaskWithURL:finalUrl completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        //Error handling
        if (error) {
            NSLog(@"%@", error.localizedDescription);
            completion(false);
            return;
        }
        //Response handling
        if (response) {
            NSLog(@"%@", response);
        }
        //Data handling
        if (!data) {
            NSLog(@"Error with fetched post data");
            completion(false);
            return;
        }
        
        //Parse through the data
        NSDictionary * topLevelJSON = [NSJSONSerialization JSONObjectWithData:data options:2 error:&error];
        
        if(error) {
            NSLog(@"Error parsing JSON data: %@", [error localizedDescription]);
            completion(false);
            return;
        }
        
        NSDictionary * secondLevelJSON = topLevelJSON[@"data"];
        NSArray <NSDictionary *> * thirdLevelJson = secondLevelJSON[@"children"];
        NSMutableArray * arrayOfPost = [NSMutableArray new];
        
        for (NSDictionary * currentDictionary in thirdLevelJson) {
            NSDictionary * postDictionary = currentDictionary[@"data"];
            JRC_Post * post = [[JRC_Post alloc] initWithDictionary:postDictionary];
            [arrayOfPost addObject:post];
        }
        if (arrayOfPost.count != 0) {
            JRC_PostController.shared.posts = arrayOfPost;
            completion(true);
        } else {
            completion(false);
        }
        
    }] resume];
}

- (void)fetchImage:(JRC_Post *)post completion:(void (^)(UIImage * _Nullable))completion
{
    //The image url
    NSURL * imageUrl = [NSURL URLWithString:post.thumbnail];
    
    //Start the URL Session
    [[[NSURLSession sharedSession] dataTaskWithURL:imageUrl completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            NSLog(@"There was an error in %s: %@: %@", __PRETTY_FUNCTION__, error, [error localizedDescription]);
            completion(nil);
            return;
        }
        
        if (response) {
            NSLog(@"%@", response);
        }
        
        if (data) {
            UIImage * image = [UIImage imageWithData:data];
            completion(image);
        }
    }] resume];
}

@end
