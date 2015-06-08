//
//  ImageManager.h
//  SimpleTable
//
//  Created by Rishabh Jain on 6/5/15.
//  Copyright (c) 2015 Rishabh Jain. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ImageManagerDelegate <NSObject>
- (void)tableViewReload;
@end

@interface ImageManager : UIImageView{
}

@property (assign, nonatomic) id <ImageManagerDelegate> delegate;
- (id)initWithDelegate:(id <ImageManagerDelegate>) delegatedItem;

- (UIImage *) returnImageAtIndex:(int) index;
- (void) initializeImages;
+ (id) sharedManager;
@end
