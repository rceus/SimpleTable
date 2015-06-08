//
//  ViewController.m
//  SimpleTable
//
//  Created by Rishabh Jain on 6/3/15.
//  Copyright (c) 2015 Rishabh Jain. All rights reserved.
//

#import "ViewController.h"
#import "SimpleTableCellTableViewCell.h"
#import "LoadImageAsync.h"
#import "ImageManager.h"

@interface ViewController (){
    NSArray *recipes;
    NSArray *thumbnails;
    NSArray *prepTime;
    NSArray *thumbnailUrl;
    
    ImageManager* manager;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"recipes" ofType:@"plist"];
    
    NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:path];
    recipes = [dict objectForKey:@"RecipeName"];
    thumbnails = [dict objectForKey:@"Thumbnail"];
    prepTime = [dict objectForKey:@"PrepTime"];
    thumbnailUrl = [dict objectForKey:@"ThumnailUrl"];
    /*myImageView = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < thumbnailUrl.count; i++) {
        NSURL *url = [NSURL URLWithString:(NSString *)[thumbnailUrl objectAtIndex:i]];
        myImageView[i] = [[LoadImageAsync alloc] initWithDelegate: (id)((LoadImageAsync *)self)];
        NSLog(@"URL: %@, INDEX: %d!", url, i);
        NSLog(@"%@", myImageView[i]);
        [myImageView[i] loadImageAsyncFromURL:url atIndex:i];
    }*/
    //manager = [[ImageManager alloc]initWithDelegate:self];
    manager = [ImageManager sharedManager];
    [manager initializeImages];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tableViewReload{
    [self.tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [recipes count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 78;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableCell";
    
    SimpleTableCellTableViewCell *cell = (SimpleTableCellTableViewCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];

    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"SimpleTableCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    [cell initializeNib];
    
    cell.nameLabel.text = [recipes objectAtIndex:indexPath.row];
    cell.prepTimeLabel.text = [prepTime objectAtIndex:indexPath.row];
    UIImage *updatedImage = [manager returnImageAtIndex:(int)indexPath.row];
    
    if ( updatedImage == nil) {
        cell.thumbnailImageView.image = [UIImage imageNamed:@"placeHolder.png"];
    } else {
        cell.thumbnailImageView.image = updatedImage;
    }
    
    return cell;
}

@end


//Synchronous Call
//NSMutableURLRequest *requestWithBodyParams = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:(NSString *)[thumbnailUrl objectAtIndex:indexPath.row]]];
//NSData *imageData = [NSURLConnection sendSynchronousRequest:requestWithBodyParams returningResponse:nil error:nil];

