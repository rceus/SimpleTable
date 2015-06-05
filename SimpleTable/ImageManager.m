//
//  ImageManager.m
//  SimpleTable
//
//  Created by Rishabh Jain on 6/5/15.
//  Copyright (c) 2015 Rishabh Jain. All rights reserved.
//

#import "ImageManager.h"
#import "LoadImageAsync.h"

@implementation ImageManager{
    NSArray *thumbnailUrl;
    NSMutableArray *images;
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

- (UIImage *) returnImageAtIndex:(int)index{
    return ((LoadImageAsync *) images[index]).image;
}

@end
