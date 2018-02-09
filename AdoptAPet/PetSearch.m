//
//  PetSearch.m
//  AdoptAPet
//
//  Created by Ryan Maksymic on 2018-02-09.
//  Copyright © 2018 Ryan Maksymic. All rights reserved.
//

#import "PetSearch.h"

@implementation PetSearch

- (instancetype)init
{
  self = [super init];
  
  if (self)
  {
    _sexes = [@[] mutableCopy];
    _sizes = [@[] mutableCopy];
    _ages = [@[] mutableCopy];
    _options = [@[] mutableCopy];
  }
  
  return self;
}

@end
