//
//  Contact.m
//  AdoptAPet
//
//  Created by Ryan Maksymic on 2018-02-07.
//  Copyright © 2018 Ryan Maksymic. All rights reserved.
//

#import "Contact.h"

@implementation Contact

- (instancetype)init
{
  self = [super init];
  
  if (self)
  {
    _phone = @"";
    _email = @"";
    _address1 = @"";
    _address2 = @"";
    _state = @"";
    _zip = @"";
  }
  
  return self;
}

@end
