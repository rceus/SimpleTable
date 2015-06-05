//
//  SimpleTableCellTableViewCell.m
//  
//
//  Created by Rishabh Jain on 6/3/15.
//
//

#import "SimpleTableCellTableViewCell.h"

@implementation SimpleTableCellTableViewCell

@synthesize nameLabel = _nameLabel;
@synthesize prepTimeLabel = _prepTimeLabel;
@synthesize thumbnailImageView = _thumbnailImageView;


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

- (void)initializeNib {
    //_thumbnailImageView.contentMode = ;
    [_thumbnailImageView setFrame:CGRectMake(0, 0, 20, 20)];
    //[_thumbnailImageView setBackgroundColor:[UIColor redColor]];
}

@end
