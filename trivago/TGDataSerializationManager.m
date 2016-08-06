//
//  TGDataSerializationManager.m
//  trivago
//
//  Created by David Lashkhi on 05/08/16.
//  Copyright © 2016 David Lashkhi. All rights reserved.
//

#import "TGDataSerializationManager.h"
#import "TGMovie.h"

@implementation TGDataSerializationManager

- (NSArray *)createMoviesFromJSONDictionary:(NSArray *)jsonArray {
    NSMutableArray *newMovies = [NSMutableArray new];
    for (NSDictionary *movie in jsonArray) {
        //
    }
    return newMovies;
}

@end
