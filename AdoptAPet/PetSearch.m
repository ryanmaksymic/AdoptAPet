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
  if ([self.sexes count] == 0 || [self.sexes count] == 2)
  {
    return @"Any Sex";
  }
  
  NSMutableString * result = [@"" mutableCopy];
  
  if ([self.sexes containsObject:[NSNumber numberWithInteger:PetSexMale]])
  {
    [result appendString:@"Male, "];
  }
  
  if ([self.sexes containsObject:[NSNumber numberWithInteger:PetSexFemale]])
  {
    [result appendString:@"Female, "];
  }
  
  return result;
}

- (NSString *)sizesString
{
  if ([self.sizes count] == 0 || [self.sizes count] == 4)
  {
    return @"Any Size";
  }
  
  NSMutableString * result = [@"" mutableCopy];
  
  if ([self.sizes containsObject:[NSNumber numberWithInteger:PetSizeSmall]])
  {
    [result appendString:@"Small, "];
  }
  
  if ([self.sizes containsObject:[NSNumber numberWithInteger:PetSizeMedium]])
  {
    [result appendString:@"Medium, "];
  }
  
  if ([self.sizes containsObject:[NSNumber numberWithInteger:PetSizeLarge]])
  {
    [result appendString:@"Large, "];
  }
  
  if ([self.sizes containsObject:[NSNumber numberWithInteger:PetSizeExtraLarge]])
  {
    [result appendString:@"Extra Large, "];
  }
  
  return result;
}

- (NSString *)agesString
{
  if ([self.ages count] == 0 || [self.ages count] == 4)
  {
    return @"Any Ages";
  }
  
  NSMutableString * result = [@"" mutableCopy];
  
  if ([self.ages containsObject:[NSNumber numberWithInteger:PetAgeBaby]])
  {
    [result appendString:@"Baby, "];
  }
  
  if ([self.ages containsObject:[NSNumber numberWithInteger:PetAgeYoung]])
  {
    [result appendString:@"Young, "];
  }
  
  if ([self.ages containsObject:[NSNumber numberWithInteger:PetAgeAdult]])
  {
    [result appendString:@"Adult, "];
  }
  
  if ([self.ages containsObject:[NSNumber numberWithInteger:PetAgeSenior]])
  {
    [result appendString:@"Senior, "];
  }
  
  return result;
}

- (NSString *)optionsString
{
  NSMutableString * result = [@"" mutableCopy];
  
  if ([self.options containsObject:[NSNumber numberWithInteger:PetOptionHasShots]])
  {
    [result appendString:@"Has Shots, "];
  }
  
  if ([self.options containsObject:[NSNumber numberWithInteger:PetOptionHousetrained]])
  {
    [result appendString:@"Housetrained, "];
  }
  
  return result;
}

@end
