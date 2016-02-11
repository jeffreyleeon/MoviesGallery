//
//  MoviesListViewController.m
//  MoviesGallery
//
//  Created by Jeffrey on 10/2/2016.
//  Copyright © 2016 jeffreyleeon. All rights reserved.
//

#import "MoviesListViewController.h"
#import "MovieTableViewCell.h"
#import "MovieDetailsViewController.h"
#include "constants.h"

#define GO_TO_DETAILS_SEGUE @"pushFromMoviesListToDetail"

@interface MoviesListViewController ()

@end

@implementation MoviesListViewController

- (void)viewDidLoad {
    [_tableView setBackgroundColor: [UIColor blackColor]];
    [_tableView setBounces: FALSE];
    
    _movieStore = [MovieStore sharedInstance];
    [self fetchCurrentMovies];
    [self fetchComingSoonMovies];
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void) viewWillDisappear:(BOOL)animated {
    [_tableView deselectRowAtIndexPath:[_tableView indexPathForSelectedRow] animated:animated];
    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) fetchCurrentMovies {
    [_movieStore fetchCurrentMoviesWithCallback: ^(NSMutableArray* movies) {
        _currentMovies = [[NSArray alloc] initWithArray: movies];
        [_tableView reloadData];
    }];
}

- (void) fetchComingSoonMovies {
    [_movieStore fetchComingSoonMoviesWithCallback: ^(NSMutableArray* movies) {
        _comingSoonMovies = [[NSArray alloc] initWithArray: movies];
        [_tableView reloadData];
    }];
}

// TableView delegates
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    float height = 44;
    float width = tableView.frame.size.width;
    UIView* view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    
    CGRect labelFrame = CGRectMake(15, 0,
                                   width, height);
    UILabel* label = [[UILabel alloc] initWithFrame: labelFrame];
    [label setFont:[UIFont boldSystemFontOfSize: 20]];
    [label setTextColor: [UIColor whiteColor]];
    NSString* string = [self sectionHeaderTitleForSection: section];
    [label setText: string];
    [view addSubview: label];
    [view setBackgroundColor: YELLOW_COLOR];
    return view;
}

- (NSString*)sectionHeaderTitleForSection:(NSInteger)section {
    NSString* ret;
    if (section == 0) {
        ret = @"Current";
    } else if (section == 1) {
        ret = @"Coming Soon";
    }
    return ret;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger ret = 0;
    if (section == 0 && _currentMovies) {
        ret = [_currentMovies count];
    } else if (section == 1 && _comingSoonMovies) {
        ret = [_comingSoonMovies count];
    }
    return ret;
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
    NSInteger section = [indexPath section];
    NSInteger row = [indexPath row];
    NSArray<Movie*>* array = [self getTargetMoviesArrayForSection: section];
    return array[row];
}

- (NSArray*) getTargetMoviesArrayForSection:(NSInteger) section {
    NSArray* ret;
    if (section == 0) {
        ret = _currentMovies;
    } else if (section == 1) {
        ret = _comingSoonMovies;
    }
    return ret;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    _selectedMovie = [self getMovieForIndexPath: indexPath];
    [self performSegueWithIdentifier: GO_TO_DETAILS_SEGUE sender: self];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString: GO_TO_DETAILS_SEGUE]) {
        MovieDetailsViewController* destinationViewController = segue.destinationViewController;
        [destinationViewController setMovie: _selectedMovie];
    }
}

@end
