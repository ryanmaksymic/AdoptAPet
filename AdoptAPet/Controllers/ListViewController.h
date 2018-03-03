//
//  ListViewController.h
//  AdoptAPet
//
//  Created by Ryan Maksymic on 2018-02-07.
//  Copyright © 2018 Ryan Maksymic. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Pet;

@interface ListViewController : UITableViewController

@property (nonatomic) NSArray<Pet *> * pets;

@end
