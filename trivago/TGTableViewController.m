//
//  TGTableViewController.m
//  trivago
//
//  Created by David Lashkhi on 05/08/16.
//  Copyright © 2016 David Lashkhi. All rights reserved.
//

#import "TGTableViewController.h"
#import "TGServicesFacade.h"
#import "TGMovieTableViewCell.h"
#import "TGMovie.h"


@interface TGTableViewController ()
@property (nonatomic, strong) TGServicesFacade *serviceManager;
@property (nonatomic, strong) NSMutableArray *movies;
@end

@implementation TGTableViewController

static NSString * const reuseIdentifier = @"MovieTableViewCell";


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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.movies.count) {
        return self.movies.count;
    } else {
        return 0;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TGMovieTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
    TGMovie *movie = self.movies[indexPath.row];
    cell.title.text = movie.title;
    cell.year.text = movie.year;
    cell.overview.text = movie.overview;
    
    return cell;
}


@end
