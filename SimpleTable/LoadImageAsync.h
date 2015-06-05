//
//  LoadImageAsync.h
//  SimpleTable
//
//  Created by Rishabh Jain on 6/5/15.
//  Copyright (c) 2015 Rishabh Jain. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LoadImageAsyncDelegate <NSObject>
- (void)imageFinishedDownloading:(int)atIndex image:(UIImage *)loadedImage;
@end

@interface LoadImageAsync : UIImageView{
    NSURLConnection *connection;
    NSMutableData *data;
}

- (id)initWithDelegate:(id <LoadImageAsyncDelegate>) delegatedItem;
@property (assign, nonatomic) id <LoadImageAsyncDelegate> delegate;

- (void)loadImageAsyncFromURL:(NSURL *)url atIndex:(int)i;
- (void)testMethod;


@end
