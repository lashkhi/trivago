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
@end

@implementation TGNetworkManager


- (void)fetchMoviesForURLString:(NSString *)urlString
                           page:(NSInteger)page
                          limit:(NSInteger)limit
                    withSuccess:(void (^)(NSArray * jsonArray))success
                        failure:(void (^)(NSError *error))failure {
    NSURL *url = [NSURL URLWithString:[urlString stringByAppendingString:TGMoviesURL]];
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    config.HTTPAdditionalHeaders = @{TGHeaderApiVersionName:@(TGApiClientVersion),
                                     TGHeaderApiKeyName:TGClientId};
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
    self.dataTask = [session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
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
}


@end
