//
//  MovieDetailsViewController.m
//  MoviesGallery
//
//  Created by Jeffrey on 11/2/2016.
//  Copyright © 2016 jeffreyleeon. All rights reserved.
//

#import "MovieDetailsViewController.h"

@interface MovieDetailsViewController ()

@end

@implementation MovieDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController.navigationBar setTintColor: [UIColor whiteColor]];
    [self setTitle: [_movie getTitle]];
    
    _movieStore = [MovieStore sharedInstance];
    [_movieStore fetchTrailerOfMovie: _movie withCallback: ^(id hihi) {}];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setMovie:(Movie*) movie {
    _movie = movie;
}

@end
