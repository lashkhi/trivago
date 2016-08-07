//
//  TGServicesFacade.m
//  trivago
//
//  Created by David Lashkhi on 05/08/16.
//  Copyright © 2016 David Lashkhi. All rights reserved.
//

#import "TGServicesFacade.h"
#import "TGNetworkManager.h"
#import "TGDataSerializationManager.h"

@interface TGServicesFacade ()
@property (nonatomic, strong) TGNetworkManager *networkManager;
@property (nonatomic, strong) TGDataSerializationManager *serializationManager;


@end

@implementation TGServicesFacade

- (instancetype)init {
    if (self = [super init]) {
        _networkManager = [TGNetworkManager new];
        _serializationManager = [TGDataSerializationManager new];
    }
    return self;
}

- (void)fetchMoviesForPage:(NSInteger)page
                     limit:(NSInteger)limit
                searchText:(NSString *)searchText
                   success:(void (^)(NSArray * movies))success
                   failure:(void (^)(NSError *error))failure {
    NSString *urlString;
    if (searchText) {
        urlString = [NSString stringWithFormat:@"%@%@%@&page=%ld&limit=%ld", TGAPIURL, TGSearchMoviesURL, searchText, page, limit];
        [self.networkManager cancelLoadingWithCompletion:^{
            [self sendRequestForURL:urlString forPage:page limit:limit searchText:searchText success:^(NSArray *movies) {
                if (success) {
                    success(movies);
                }
            } failure:^(NSError *error) {
                //
            }];
        }];
    } else {
        urlString = [NSString stringWithFormat:@"%@%@&page=%ld&limit=%ld", TGAPIURL, TGMoviesURL, page, limit];
        [self sendRequestForURL:urlString forPage:page limit:limit searchText:searchText success:^(NSArray *movies) {
            if (success) {
                success(movies);
            }
        } failure:^(NSError *error) {
            //
        }];
    }
    

}

- (void)sendRequestForURL:(NSString *)urlString
                  forPage:(NSInteger)page
                    limit:(NSInteger)limit
               searchText:(NSString *)searchText
                  success:(void (^)(NSArray * movies))success
                  failure:(void (^)(NSError *error))failure {
    BOOL isSearch = searchText ? YES : NO;
    [self.networkManager fetchMoviesForURLString:urlString withSuccess:^(NSArray *jsonArray) {
        [self serializeMoviesFromJSONDictionary:jsonArray isSearch:isSearch withSuccess:success];
    } failure:failure];
}

- (void)serializeMoviesFromJSONDictionary:(NSArray *)jsonArray isSearch:(BOOL)isSearch withSuccess:(void (^)(NSArray *movies))success {
    NSArray *moviesArray;
    if (isSearch) {
        moviesArray = [self.serializationManager createSearchMoviesResultsFromJSON:jsonArray];
    } else {
        moviesArray = [self.serializationManager createMoviesFromJSON:jsonArray];
    }
    if (success) {
        success(moviesArray);
    }
}

- (void)fetchImageFromURLString:(NSString *)urlString onDidLoad:(void (^)(UIImage *image))onImageDidLoad {
    [self.networkManager fetchImageFromURLString:urlString onDidLoad:onImageDidLoad];
}

@end
