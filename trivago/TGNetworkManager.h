//
//  TGNetworkManager.h
//  trivago
//
//  Created by David Lashkhi on 05/08/16.
//  Copyright © 2016 David Lashkhi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TGNetworkManager : NSObject

- (void)fetchMoviesForURLString:(NSString *)urlString page:(NSInteger)page limit:(NSInteger)limit withSuccess:(void (^)(NSArray * jsonArray))success failure:(void (^)(NSError *error))failure;

@end
