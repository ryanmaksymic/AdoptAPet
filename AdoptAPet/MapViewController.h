//
//  MapViewController.h
//  AdoptAPet
//
//  Created by Fernando Zanei on 2018-02-08.
//  Copyright © 2018 Ryan Maksymic. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Pet;

@interface MapViewController : UIViewController

@property (nonatomic, copy) NSString * locationZip;
@property (strong, nonatomic) NSArray<Pet *> * pets;

@end
