//
//  Const.m
//  trivago
//
//  Created by David Lashkhi on 05/08/16.
//  Copyright © 2016 David Lashkhi. All rights reserved.
//

#import "Const.h"

@implementation Const

NSString *const TGAPIURL = @"https://api.trakt.tv";
NSString *const TGMoviesURL = @"/movies/popular?extended=full,images";
NSString *const TGSearchMoviesURL = @"/search/movie?extended=full,images&query=";
NSString *const TGClientId = @"ad005b8c117cdeee58a1bdb7089ea31386cd489b21e14b19818c91511f12a086";
NSInteger const TGApiClientVersion = 2;


NSString *const TGHeaderApiVersionName = @"trakt-api-version";
NSString *const TGHeaderApiKeyName = @"trakt-api-key";

NSInteger const TGLimit = 10;


NSString *const TGMovieTitleKey = @"title";
NSString *const TGMovieYearKey = @"year";
NSString *const TGMovieOverviewKey = @"overview";
NSString *const TGMovieImageDictionaryKey = @"images";
NSString *const TGMovieLogoKey = @"poster";
NSString *const TGMovieImageDictionaryFullKey = @"thumb";
NSString *const TGMovieIdDictionaryIdsKey = @"ids";
NSString *const TGMovieIdDictionaryIMDBKey = @"imdb";
NSString *const TGMovieDictionaryMovieKey = @"movie";


@end
