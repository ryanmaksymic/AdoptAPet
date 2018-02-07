//
//  Pet.m
//  AdoptAPet
//
//  Created by Ryan Maksymic on 2018-02-07.
//  Copyright © 2018 Ryan Maksymic. All rights reserved.
//

#import "Pet.h"

@implementation Pet

- (instancetype)initWithJSON:(NSDictionary *)json
{
  self = [super init];
  
  if (self)
  {
    _name = json[@"name"];
  }
  
  return self;
}

@end
