//
//  PetSearch.h
//  AdoptAPet
//
//  Created by Ryan Maksymic on 2018-02-09.
//  Copyright © 2018 Ryan Maksymic. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Pet.h"

@interface PetSearch : NSObject

@property (nonatomic, copy) NSString * locationZip;
@property (nonatomic) PetType type;
@property (nonatomic) NSArray * sexes;
@property (nonatomic) NSArray * sizes;
@property (nonatomic) NSArray * ages;
@property (nonatomic) NSArray * options;

@end
