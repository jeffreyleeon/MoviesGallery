//
//  MoviesListViewController.m
//  MoviesGallery
//
//  Created by Jeffrey on 10/2/2016.
//  Copyright © 2016 jeffreyleeon. All rights reserved.
//

#import "MoviesListViewController.h"
#import "MovieTableViewCell.h"
#import "Models/Movie.h"

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
    NSString* string = [self sectionHeaderTitleForSection: section];
    [label setText: string];
    [view addSubview: label];
    [view setBackgroundColor:[UIColor whiteColor]];
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
    
    NSData* posterData = [movie getPosterImageData];
    if ([posterData isKindOfClass: [NSData class]]) {
        [cell.image setImage: [UIImage imageWithData: posterData]];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
