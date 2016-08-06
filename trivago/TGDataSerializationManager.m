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

- (NSArray *)createMoviesFromJSONDictionary:(NSArray *)jsonArray {
    NSMutableArray *newMovies = [NSMutableArray new];
    for (NSDictionary *movieDict in jsonArray) {
        TGMovie *movie = [TGMovie new];
        movie.title = movieDict[TGMovieTitleField];
        movie.year =[NSString stringWithFormat:@"%@", movieDict[TGMovieYearField]];
        movie.overview = movieDict[TGMovieOverviewField];
        movie.imageURL = movieDict[TGMovieImageDictionaryField][TGMovieLogoField][TGMovieImageDictionaryFullField];
        [newMovies addObject:movie];
    }
    return newMovies;
}

@end
