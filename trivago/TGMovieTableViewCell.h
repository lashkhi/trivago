//
//  TGMovieTableViewCell.h
//  trivago
//
//  Created by David Lashkhi on 06/08/16.
//  Copyright © 2016 David Lashkhi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TGMovieTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *year;
@property (weak, nonatomic) IBOutlet UILabel *overview;
@property (weak, nonatomic) IBOutlet UIImageView *image;

@end
