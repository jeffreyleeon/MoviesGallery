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
    
    [self fetchPopularMovies];
    
    [self scheduleAutoScrolling];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfItemsInSwipeView:(SwipeView *) swipeView {
    return [_popularMovies count];
}

- (UIView *)swipeView:(SwipeView *)swipeView viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view {
    Movie* movie = [_popularMovies objectAtIndex: index];
    return [self viewOfSwipeViewForMovie: movie];
}

- (UIView*)viewOfSwipeViewForMovie:(Movie*) movie {
    UIView* _view = [[UIView alloc] init];
    [_view setBackgroundColor: [UIColor blackColor]];
    
    CGRect imageViewFrame = CGRectMake(0, 0, _swipeView.frame.size.width, _swipeView.frame.size.height);
    UIImage* img = [UIImage imageWithData: [movie getPosterImageData]];
    UIImageView* imageView = [[UIImageView alloc] initWithFrame: imageViewFrame];
    [imageView setImage: img];
    [imageView setContentMode: UIViewContentModeScaleAspectFit];
    [_view addSubview: imageView];
    
    return _view;
}

- (CGSize)swipeViewItemSize:(SwipeView *) swipeView {
    return _swipeView.bounds.size;
}

- (void) fetchPopularMovies {
    [_movieStore fetchPopularMoviesWithCallback: ^(NSMutableArray* movies) {
        _popularMovies = [[NSArray alloc] initWithArray: movies];
        [_swipeView reloadData];
    }];
}

- (void) scheduleAutoScrolling {
    [NSTimer scheduledTimerWithTimeInterval: 10.0
                                     target: self
                                   selector: @selector(nextPopularMovie)
                                   userInfo: NULL
                                    repeats: YES];
}

- (void) nextPopularMovie {
    // First page is at index 0
    NSInteger currentPage = [_swipeView currentPage];
    NSInteger nextPage = currentPage + 1;
    if (nextPage == [_popularMovies count]) {
        nextPage = 0;
    }
    [_swipeView scrollToPage: nextPage duration: 0.5];
}

@end
