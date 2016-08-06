//
//  TGMovie.h
//  trivago
//
//  Created by David Lashkhi on 05/08/16.
//  Copyright © 2016 David Lashkhi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TGMovie : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *year;
@property (nonatomic, strong) NSString *overview;
@property (nonatomic, strong) NSString *imageURL;
@property (nonatomic, strong) NSString *movieId;

@end
