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
    _sexes = [NSMutableSet setWithCapacity:2];
    _sizes = [NSMutableSet setWithCapacity:4];
    _ages = [NSMutableSet setWithCapacity:4];
    _options = [NSMutableSet setWithCapacity:2];
  }
  
  return self;
}


- (NSString *)typeString
{
  if (self.type == PetTypeDog)
  {
    return @"Dog";
  }
  
  return @"Cat";
}

- (NSString *)sexesString
{
  if ([self.sexes count] == 0)
  {
    return @"Any Sex";
  }
  
  NSMutableString * result = [@"" mutableCopy];
  
  if ([self.sexes containsObject:[NSNumber numberWithInteger:PetSexMale]])
  {
    [result appendString:@"Male "];
  }
  
  if ([self.sexes containsObject:[NSNumber numberWithInteger:PetSexFemale]])
  {
    [result appendString:@"Female "];
  }
  
  return result;
}

- (NSString *)sizesString
{
  // TODO: This
  
  return @"Extra Large";
}

- (NSString *)agesString
{
  // TODO: This
  
  return @"Senior";
}

- (NSString *)optionsString
{
  NSMutableString * result = [@"" mutableCopy];
  
  // TODO: This
  
  return result;
}

@end
