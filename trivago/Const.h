//
//  Const.h
//  trivago
//
//  Created by David Lashkhi on 05/08/16.
//  Copyright © 2016 David Lashkhi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Const : NSObject

extern NSString *const TGAPIURL;
extern NSString *const TGMoviesURL;
extern NSString *const TGClientId;
extern NSInteger const TGLimit;
extern NSInteger const TGApiClientVersion;

extern NSString *const TGHeaderApiVersionName;
extern NSString *const TGHeaderApiKeyName;

#pragma mark - TGMovie parsing keys
extern NSString *const TGMovieTitleField;
extern NSString *const TGMovieYearField;
extern NSString *const TGMovieOverviewField;
extern NSString *const TGMovieImageDictionaryField;
extern NSString *const TGMovieLogoField;
extern NSString *const TGMovieImageDictionaryFullField;
@end
