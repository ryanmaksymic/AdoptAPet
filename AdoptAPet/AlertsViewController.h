//
//  AlertsViewController.h
//  AdoptAPet
//
//  Created by Ryan Maksymic on 2018-02-10.
//  Copyright © 2018 Ryan Maksymic. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AlertsViewController;
@class PetSearch;

@protocol AlertsDelegate

- (void)alertsViewController:(AlertsViewController *)avc didSelectAlert:(PetSearch *)alert;

@end


@class PetSearch;

@interface AlertsViewController : UIViewController

@property (nonatomic) PetSearch * currentSearch;

@property (nonatomic, weak) id<AlertsDelegate> delegate;

@end
