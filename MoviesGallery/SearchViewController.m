//
//  SearchViewController.m
//  MoviesGallery
//
//  Created by Jeffrey on 11/2/2016.
//  Copyright © 2016 jeffreyleeon. All rights reserved.
//

#import "SearchViewController.h"
#import "MovieTableViewCell.h"

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController.navigationBar setTintColor: [UIColor whiteColor]];
    
    [_searchBar becomeFirstResponder];
    
    _movieStore = [MovieStore sharedInstance];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    [self searchWithText: searchText];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
    [self searchWithText: searchBar.text];
}

- (void) searchWithText:(NSString*)searchText {
    [_movieStore searchMovies: searchText withCallback: ^(NSMutableArray* movies) {
        _searchedMovies = [[NSArray alloc] initWithArray: movies];
        if ([_searchedMovies count]) {
            [_overlay setHidden: TRUE];
            [_tableView reloadData];
        } else {
            [_overlay setHidden: FALSE];
        }
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_searchedMovies count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"movieTableViewCell";
    
    MovieTableViewCell* cell = [tableView
                                dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[MovieTableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:CellIdentifier];
    }
    
    Movie* movie = [self getMovieForIndexPath: indexPath];
    
    cell.image.image = nil;
    NSURL* posterURL = [movie getPosterImageURL];
    if ([posterURL isKindOfClass: [NSURL class]]) {
        [cell.image setImageURL: posterURL];
    } else {
        [cell.image setImage: [UIImage imageNamed: @"poster-placeholder"]];
    }
    [cell.image setContentMode: UIViewContentModeScaleAspectFit];
    
    NSString* title = [movie getTitle];
    [cell.title setText: title];
    
    NSString* popularity = [movie getVoteAverageString];
    [cell.popularity setText: [popularity stringByAppendingString: @" ★"]];
    
    return cell;
}

- (Movie*) getMovieForIndexPath:(NSIndexPath*) indexPath {
    NSInteger row = [indexPath row];
    return _searchedMovies[row];
}

@end
