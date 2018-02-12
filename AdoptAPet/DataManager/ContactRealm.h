//
//  ContactRealm.h
//  AdoptAPet
//
//  Created by Fernando Zanei on 2018-02-10.
//  Copyright © 2018 Ryan Maksymic. All rights reserved.
//

#import <Realm/Realm.h>

@interface ContactRealm : RLMObject

@property (nonatomic) NSString *phone;
@property (nonatomic) NSString *email;
@property (nonatomic) NSString *address1;
@property (nonatomic) NSString *address2;
@property (nonatomic) NSString *city;
@property (nonatomic) NSString *state;
@property (nonatomic) NSString *zip;
@property (nonatomic) NSString *idNumber;
@property NSString *idPet;

@end

