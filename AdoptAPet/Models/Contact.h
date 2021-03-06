//
//  Contact.h
//  AdoptAPet
//
//  Created by Ryan Maksymic on 2018-02-07.
//  Copyright © 2018 Ryan Maksymic. All rights reserved.
//

#import <Foundation/Foundation.h>
@import MapKit;

@interface Contact : NSObject <MKAnnotation>

@property (nonatomic) NSString * phone;
@property (nonatomic) NSString * email;
@property (nonatomic) NSString * address1;
@property (nonatomic) NSString * address2;
@property (nonatomic) NSString * city;
@property (nonatomic) NSString * state;
@property (nonatomic) NSString * zip;
@property (nonatomic) NSString * idNumber;

@property (assign, nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic, readonly, copy) NSString *title;

- (instancetype)initWithJSON:(NSDictionary *)json;


@end
