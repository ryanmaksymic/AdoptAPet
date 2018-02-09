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

@property (nonatomic) PetType type;
@property (nonatomic) NSMutableArray * sexes;
@property (nonatomic) NSMutableArray * sizes;
@property (nonatomic) NSMutableArray * ages;
@property (nonatomic) NSMutableArray * options;

@end
