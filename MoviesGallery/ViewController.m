//
//  ViewController.m
//  MoviesGallery
//
//  Created by Jeffrey on 31/1/2016.
//  Copyright © 2016 jeffreyleeon. All rights reserved.
//

#import "ViewController.h"
#import "Models/Movie.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [_swipeView setPagingEnabled: YES];
    [_swipeView setScrollEnabled: YES];
    
    _movieStore = [MovieStore sharedInstance];
    [self fetchTopMovies];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfItemsInSwipeView:(SwipeView *) swipeView {
    return [_topMovies count];
}

- (UIView *)swipeView:(SwipeView *)swipeView viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view {
    Movie* movie = [_topMovies objectAtIndex: index];
    return [self viewOfSwipeViewForMovie: movie];
}

- (UIView*)viewOfSwipeViewForMovie:(Movie*) movie {
    NSString* movieName = [movie getTitle];
    
    UIView* _view = [[UIView alloc] init];
    [_view setBackgroundColor: [UIColor blackColor]];
    
    CGRect rect = CGRectMake(0, 20, 200, 50);
    UITextField* textField = [[UITextField alloc] initWithFrame: rect];
    [textField setText: movieName];
    [textField setTextColor: [UIColor whiteColor]];
    [_view addSubview: textField];
    
    return _view;
}

- (CGSize)swipeViewItemSize:(SwipeView *) swipeView {
    return _swipeView.bounds.size;
}

- (void) fetchTopMovies {
    [_movieStore fetchTopMoviesWithCallback: ^(NSMutableArray* movies) {
        _topMovies = [[NSArray alloc] initWithArray: movies];
        [_swipeView reloadData];
    }];
}

@end
