//
//  SearchViewController.m
//  AdoptAPet
//
//  Created by Ryan Maksymic on 2018-02-07.
//  Copyright © 2018 Ryan Maksymic. All rights reserved.
//

#import "SearchViewController.h"

@interface SearchViewController ()


@end


@implementation SearchViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
}

- (IBAction)buttonToggled:(UIButton *)sender
{
  sender.selected = !sender.selected;
}

@end
