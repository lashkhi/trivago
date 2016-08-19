//
//  TGNetworkManager.m
//  trivago
//
//  Created by David Lashkhi on 05/08/16.
//  Copyright © 2016 David Lashkhi. All rights reserved.
//

#import "TGNetworkManager.h"
#import "Const.h"


@interface TGNetworkManager ()
@property (nonatomic, strong) NSURLSessionDataTask *dataTask;
@property (nonatomic, strong) NSURLSession *session;
@end

@implementation TGNetworkManager

- (instancetype)init {
    if (self = [super init]) {
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        config.HTTPAdditionalHeaders = @{TGHeaderApiVersionName:@(TGApiClientVersion),
                                         TGHeaderApiKeyName:TGClientId};
        _session = [NSURLSession sessionWithConfiguration:config];
    }
    return self;
}



- (void)fetchMoviesForURLString:(NSString *)urlString
                    withSuccess:(void (^)(NSArray * jsonArray))success
                        failure:(void (^)(NSError *error))failure {
    NSURL *url = [NSURL URLWithString:urlString];
    self.dataTask = [self.session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (data) {
            NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
            if (jsonArray) {
                success (jsonArray);
            } else {
                failure(error);// no downloading
            }
            
        } else if (error) {
            //handle error
        }
    }];
    
    [self.dataTask resume];
    NSLog(@"request sent");
}

- (void)fetchImageFromURLString:(NSString *)urlString onDidLoad:(void (^)(UIImage *image))onImageDidLoad {
    NSURL *URL = [NSURL URLWithString:urlString];
    NSLog(@"%@", urlString);
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDownloadTask *task = [session downloadTaskWithURL:URL completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSData *imageData = [NSData dataWithContentsOfURL:location];
        UIImage *image = [UIImage imageWithData:imageData];
        onImageDidLoad(image);
    }];
    [task resume];
}



@end
