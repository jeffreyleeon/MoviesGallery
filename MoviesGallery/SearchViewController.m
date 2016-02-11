//
//  SearchViewController.m
//  MoviesGallery
//
//  Created by Jeffrey on 11/2/2016.
//  Copyright © 2016 jeffreyleeon. All rights reserved.
//

#import "SearchViewController.h"

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController.navigationBar setTintColor: [UIColor whiteColor]];
    
    _movieStore = [MovieStore sharedInstance];
}

@end
