//
//  StringRealm.h
//  AdoptAPet
//
//  Created by Fernando Zanei on 2018-02-10.
//  Copyright © 2018 Ryan Maksymic. All rights reserved.
//

#import <Realm/Realm.h>

@interface StringRealm : RLMObject

@property NSString *string;
@property int integer;
@property NSData *image;

@end
RLM_ARRAY_TYPE(StringRealm)
