//
//  MoviesListViewController.m
//  MoviesGallery
//
//  Created by Jeffrey on 10/2/2016.
//  Copyright © 2016 jeffreyleeon. All rights reserved.
//

#import "MoviesListViewController.h"
#import "MovieTableViewCell.h"

@interface MoviesListViewController ()

@end

@implementation MoviesListViewController

- (void)viewDidLoad {
    [self.tableView setBackgroundColor: [UIColor blackColor]];
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

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
    [label setText:string];
    [view addSubview:label];
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
    return 10;
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
    
    return cell;
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
