//
//  PetTableViewCell.h
//  AdoptAPet
//
//  Created by Ryan Maksymic on 2018-02-07.
//  Copyright © 2018 Ryan Maksymic. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PetTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView * petImageView;
@property (weak, nonatomic) IBOutlet UILabel * nameLabel;
//@property (weak, nonatomic) IBOutlet UILabel * sizeLabel;
//@property (weak, nonatomic) IBOutlet UILabel * ageLabel;
//@property (weak, nonatomic) IBOutlet UILabel * sexLabel;
@property (weak, nonatomic) IBOutlet UILabel * sizeAgeSexLabel;
@property (weak, nonatomic) IBOutlet UILabel * breedsLabel;
@property (weak, nonatomic) IBOutlet UILabel * locationLabel;
@property (weak, nonatomic) IBOutlet UILabel * lastUpdatedLabel;

@end
