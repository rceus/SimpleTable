//
//  SimpleTableCellTableViewCell.h
//  
//
//  Created by Rishabh Jain on 6/3/15.
//
//

#import <UIKit/UIKit.h>

@interface SimpleTableCellTableViewCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel *nameLabel;
@property (nonatomic, weak) IBOutlet UILabel *prepTimeLabel;
@property (nonatomic, weak) IBOutlet UIImageView *thumbnailImageView;

- (void)initializeNib ;

@end
