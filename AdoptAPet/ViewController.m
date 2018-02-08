//
//  ViewController.m
//  AdoptAPet
//
//  Created by Ryan Maksymic on 2018-02-07.
//  Copyright © 2018 Ryan Maksymic. All rights reserved.
//

#import "ViewController.h"
#import "Pet.h"
#import "NetworkManager.h"

@interface ViewController ()

@property (nonatomic) NSArray<Pet *> * pets;

@end


@implementation ViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  
//  NSURL * url = [NSURL URLWithString:@"http://api.petfinder.com/pet.find?location=M5T2V4&key=67a4b38197ee28774594388ab415505a&format=json"];
//
//  [NetworkManager fetchPetDataFromURL:url completionHandler:^(NSArray<Pet *> *pets) {
//
//    //self.pets = pets;
//
//    NSLog(@"Pet data downloaded!");
//
//  }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"petCell"];
  
  return cell;
}

@end
