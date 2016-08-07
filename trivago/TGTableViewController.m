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
#import "TGLoadingTableViewCell.h"
#import "TGMovie.h"


@interface TGTableViewController ()
@property (nonatomic, strong) TGServicesFacade *serviceManager;
@property (nonatomic, strong) NSMutableArray *movies;
@property (nonatomic, strong) NSArray *searchResultsMovies;
@property (nonatomic, strong) NSCache *cache;
@property (nonatomic, assign) NSInteger currentPage;
@property (nonatomic, assign) NSInteger searchCurrentPage;
@property (nonatomic, strong) NSString *searchQuerry;
@property (nonatomic, assign) BOOL searching;
@end

@implementation TGTableViewController

static NSString * const movieCellReuseIdentifier = @"MovieTableViewCell";
static NSString * const loadingCellReuseIdentifier = @"LoadingCell";


- (void)viewDidLoad {
    [super viewDidLoad];
    self.movies = [NSMutableArray new];
    self.cache = [NSCache new];
    self.serviceManager = [TGServicesFacade new];
    self.currentPage = 1;
    self.searchCurrentPage = 1;
    [self loadMoviesForPage:self.currentPage withLimit:TGLimit searchText:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadMoviesForPage:(NSInteger)page withLimit:(NSInteger)limit searchText:(NSString *)searchText {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self.serviceManager fetchMoviesForPage:page limit:limit searchText:searchText success:^(NSArray *moviesNew) {
            if (self.searching) {
                self.searchResultsMovies = moviesNew;
            } else {
                [self.movies addObjectsFromArray:moviesNew];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
            });
        } failure:^(NSError *error) {
            NSLog(@"Error: %@", [error localizedDescription]);
        }];
    });
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger rows = 0;
    if (self.searching) {
        rows = self.searchResultsMovies.count + 1;
    } else {
        rows = self.movies.count + 1;
    }
    return rows;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.searching) {
        if (indexPath.row == [self.searchResultsMovies count] - 1 ) {
            [self loadMoviesForPage:++self.searchCurrentPage withLimit:TGLimit searchText:self.searchQuerry];
        }
    } else {
        if (indexPath.row == [self.movies count] - 1 ) {
            [self loadMoviesForPage:++self.currentPage withLimit:TGLimit searchText:nil];
        }
    }
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == [self.movies count]) {
        TGLoadingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:loadingCellReuseIdentifier forIndexPath:indexPath];
        [cell.loadingActivity startAnimating];
        return cell;
    } else {
        TGMovieTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:movieCellReuseIdentifier forIndexPath:indexPath];
        TGMovie *movie;
        if (self.searching) {
            movie = self.searchResultsMovies[indexPath.row];
        } else {
            movie = self.movies[indexPath.row];
        }
        
        cell.title.text = movie.title;
        cell.year.text = movie.year;
        cell.overview.text = movie.overview;
        
        NSString *keyString = [NSString stringWithFormat:@"movie-%@", movie.movieId];
        if ([self.cache objectForKey:keyString]) {
            cell.image.image = [self.cache objectForKey:keyString];
        } else {
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                [self.serviceManager fetchImageFromURLString:movie.imageURL onDidLoad:^(UIImage *image) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        TGMovieTableViewCell *updateCell = [tableView cellForRowAtIndexPath:indexPath];
                        if (updateCell && image) {
                            updateCell.image.image = image;
                            [self.cache setObject:image forKey:keyString];
                        }
                    });
                }];
            });
        }
        return cell;
    }
}

#pragma mark - SearchBar delegate

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    if (searchText.length >0) {
        self.searching = YES;
        self.searchQuerry = searchText;
        [self loadMoviesForPage:self.searchCurrentPage withLimit:TGLimit searchText:self.searchQuerry];
    }
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    self.searching = YES;
    self.searchQuerry = searchBar.text;
    [self loadMoviesForPage:self.searchCurrentPage withLimit:TGLimit searchText:self.searchQuerry];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    self.searching = NO;
}

@end
