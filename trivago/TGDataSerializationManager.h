//
//  TGDataSerializationManager.h
//  trivago
//
//  Created by David Lashkhi on 05/08/16.
//  Copyright © 2016 David Lashkhi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TGDataSerializationManager : NSObject

- (NSArray *)createMoviesFromJSONDictionary:(NSArray *)jsonArray;

@end
