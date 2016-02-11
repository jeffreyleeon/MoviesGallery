//
//  MovieTableViewCell.h
//  MoviesGallery
//
//  Created by Jeffrey on 10/2/2016.
//  Copyright © 2016 jeffreyleeon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AsyncImageView/AsyncImageView.h>

@interface MovieTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet AsyncImageView* image;
@property (weak, nonatomic) IBOutlet UILabel* title;
@property (weak, nonatomic) IBOutlet UILabel* popularity;

@end
