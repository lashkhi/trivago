//
//  TGNetworkManager.h
//  trivago
//
//  Created by David Lashkhi on 05/08/16.
//  Copyright © 2016 David Lashkhi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface TGNetworkManager : NSObject

- (void)fetchMoviesForURLString:(NSString *)urlString withSuccess:(void (^)(NSArray * jsonArray))success failure:(void (^)(NSError *error))failure;

- (void)fetchImageFromURLString:(NSString *)urlString onDidLoad:(void (^)(UIImage *image))onImageDidLoad;


@end
