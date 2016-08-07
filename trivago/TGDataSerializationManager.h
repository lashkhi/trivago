//
//  TGDataSerializationManager.h
//  trivago
//
//  Created by David Lashkhi on 05/08/16.
//  Copyright © 2016 David Lashkhi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TGDataSerializationManager : NSObject

- (NSArray *)createMoviesFromJSON:(NSArray *)jsonArray;
- (NSArray *)createSearchMoviesResultsFromJSON:(NSArray *)jsonArray;

@end
