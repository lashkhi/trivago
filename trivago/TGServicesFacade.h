//
//  TGServicesFacade.h
//  trivago
//
//  Created by David Lashkhi on 05/08/16.
//  Copyright © 2016 David Lashkhi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Const.h"

@interface TGServicesFacade : NSObject

- (void)fetchMoviesForPage:(NSInteger)page limit:(NSInteger)limit success:(void (^)(NSArray * movies))success failure:(void (^)(NSError *error))failure;

- (void)fetchImageFromURLString:(NSString *)urlString onDidLoad:(void (^)(UIImage *image))onImageDidLoad;

@end
