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
    _city = @"";
    _state = @"";
    _zip = @"";
  }
  
  return self;
}

- (instancetype)initWithJSON:(NSDictionary *)json {
    self = [super init];
    if (self) {
        _phone = [json[@"phone"] count] > 0 ? json[@"phone"][@"$t"] : @"";
        _email = [json[@"email"] count] > 0 ? json[@"email"][@"$t"] : @"";
        _address1 = [json[@"address1"] count] > 0 ? json[@"address1"][@"$t"] : @"";
        _address2 = [json[@"address2"] count] > 0 ? json[@"address1"][@"$t"] : @"";
        _city = [json[@"city"] count] > 0 ? json[@"city"][@"$t"] : @"";
        _state = [json[@"state"] count] > 0 ? json[@"state"][@"$t"] : @"";
        _zip = [json[@"zip"] count] > 0 ? json[@"zip"][@"$t"] : @"";
        _title = [json[@"name"] count] > 0 ? json[@"name"][@"$t"] : @"";
        _idNumber = json[@"id"][@"$t"];

        CLLocationDegrees lat = [[json[@"latitude"] count] > 0 ? json[@"latitude"][@"$t"] : @"" doubleValue];
        CLLocationDegrees lon = [[json[@"longitude"] count] > 0 ? json[@"longitude"][@"$t"] : @"" doubleValue];
        _coordinate = CLLocationCoordinate2DMake(lat, lon);
    }
    return self;
}

@end
