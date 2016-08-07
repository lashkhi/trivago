//
//  TGDataSerializationManager.m
//  trivago
//
//  Created by David Lashkhi on 05/08/16.
//  Copyright © 2016 David Lashkhi. All rights reserved.
//

#import "TGDataSerializationManager.h"
#import "TGMovie.h"
#import "Const.h"

@implementation TGDataSerializationManager

- (NSArray *)createMoviesFromJSON:(NSArray *)jsonArray {
    NSMutableArray *newMovies = [NSMutableArray new];
    for (NSDictionary *movieDict in jsonArray) {
        TGMovie *movie = [self createMovieModelFromDictionary:movieDict];
        [newMovies addObject:movie];
    }
    return newMovies;
}

- (NSArray *)createSearchMoviesResultsFromJSON:(NSArray *)jsonArray {
    NSMutableArray *newMovies = [NSMutableArray new];
    for (NSDictionary *movieDict in jsonArray) {
        NSDictionary *resultMovie = movieDict[TGMovieDictionaryMovieKey];
        TGMovie *movie = [self createMovieModelFromDictionary:resultMovie];
        [newMovies addObject:movie];
    }
    return newMovies;
}

- (TGMovie *)createMovieModelFromDictionary:(NSDictionary *)movieDict {
    TGMovie *movie = [TGMovie new];
    movie.title = movieDict[TGMovieTitleKey];
    movie.year =[NSString stringWithFormat:@"%@", movieDict[TGMovieYearKey]];
    movie.overview = movieDict[TGMovieOverviewKey];
    movie.imageURL = movieDict[TGMovieImageDictionaryKey][TGMovieLogoKey][TGMovieImageDictionaryFullKey];
    movie.movieId = movieDict[TGMovieIdDictionaryIdsKey][TGMovieIdDictionaryIMDBKey];
    return movie;
}

@end
