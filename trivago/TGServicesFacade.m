//
//  TGServicesFacade.m
//  trivago
//
//  Created by David Lashkhi on 05/08/16.
//  Copyright © 2016 David Lashkhi. All rights reserved.
//

#import "TGServicesFacade.h"
#import "TGNetworkManager.h"

@interface TGServicesFacade ()
@property (nonatomic, strong) TGNetworkManager *networkManager;

@end

@implementation TGServicesFacade

- (instancetype)init {
    if (self = [super init]) {
        _networkManager = [TGNetworkManager new];
    }
    return self;
}

- (void)fetchMoviesForPage:(NSInteger)page
                     limit:(NSInteger)limit
                   success:(void (^)(NSArray * movies))success
                   failure:(void (^)(NSError *error))failure {
    [self.networkManager fetchMoviesForURLString:TGAPIURL page:page limit:limit withSuccess:^(NSArray *jsonArray) {
        [self serializeMoviesFromJSONDictionary:jsonArray withSuccess:^(NSArray *movies) {
            if (success) {
                success(movies);
            }
        }];
    } failure:^(NSError *error) {
        //
    }];
}

- (void)serializeMoviesFromJSONDictionary:(NSArray *)jsonArray withSuccess:(void (^)(NSArray *movies))success {
    
}

@end
