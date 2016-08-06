//
//  TGTableViewController.m
//  trivago
//
//  Created by David Lashkhi on 05/08/16.
//  Copyright © 2016 David Lashkhi. All rights reserved.
//

#import "TGTableViewController.h"
#import "TGServicesFacade.h"

@interface TGTableViewController ()
@property (nonatomic, strong) TGServicesFacade *serviceManager;
@property (nonatomic, strong) NSMutableArray *movies;
@end

@implementation TGTableViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.movies = [NSMutableArray new];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        self.serviceManager = [TGServicesFacade new];
        [self.serviceManager fetchMoviesForPage:1 limit:TGLimit success:^(NSArray *moviesNew) {
            [self.movies addObjectsFromArray:moviesNew];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
            });
        } failure:^(NSError *error) {
            //
        }];
    });
}

@end
