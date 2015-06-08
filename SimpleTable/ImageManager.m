
//
//  ImageManager.m
//  SimpleTable
//
//  Created by Rishabh Jain on 6/5/15.
//  Copyright (c) 2015 Rishabh Jain. All rights reserved.
//

#import "ImageManager.h"
#import "LoadImageAsync.h"
#import "ViewController.h"

@implementation ImageManager{
    NSArray *thumbnailUrl;
    NSMutableArray *images;
}

+ (id)sharedManager {
    static ImageManager *sharedMyManager = nil;
    @synchronized(self) {
        if (sharedMyManager == nil)
            sharedMyManager = [[self alloc] init];
    }
    return sharedMyManager;
}


- (id) initWithDelegate:(id<ImageManagerDelegate>) delegatedItem{
    self = [super init];
    if (self) {
        _delegate = delegatedItem;
    }
    return self;
}


- (void) initializeImages{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"recipes" ofType:@"plist"];
    NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:path];
    thumbnailUrl = [dict objectForKey:@"ThumnailUrl"];
    
    images = [[NSMutableArray alloc]init];
    for (int i = 0; i < thumbnailUrl.count; i++) {
        NSURL *url = [NSURL URLWithString:(NSString *)[thumbnailUrl objectAtIndex:i]];
        images[i] = [[LoadImageAsync alloc] initWithDelegate: (id)((LoadImageAsync *)self)];
        [images[i] loadImageAsyncFromURL:url atIndex:i];
    }

}

- (void)imageFinishedDownloading:(int)atIndex image:(UIImage *)loadedImage{
    //Do Something Here
    //Call reload method
    NSLog(@"Reached Image Finished Downloading in Image manager");
    ((LoadImageAsync *)images[atIndex]).image = loadedImage;
    [_delegate tableViewReload];
}


- (UIImage *) returnImageAtIndex:(int)index{
    return ((LoadImageAsync *) images[index]).image;
}

@end
