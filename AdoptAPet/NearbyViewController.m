//
//  NearbyViewController.m
//  AdoptAPet
//
//  Created by Ryan Maksymic on 2018-02-09.
//  Copyright © 2018 Ryan Maksymic. All rights reserved.
//

#import "NearbyViewController.h"
#import "Pet.h"
#import "NetworkManager.h"
#import "ListViewController.h"

@interface NearbyViewController ()

@property (weak, nonatomic) IBOutlet UIView * listView;

@end


@implementation NearbyViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  // TODO: Get random dog and cat data and load into listView; alternate between dog and cat (?)
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
  if ([segue.identifier isEqualToString:@"transition"])
  {
    ListViewController * lvc = (ListViewController *)segue.destinationViewController;
    
    NSURL * url = [NSURL URLWithString:@"http://api.petfinder.com/pet.find?location=M5T2V4&key=67a4b38197ee28774594388ab415505a&format=json&count=100"];
    
    [NetworkManager fetchPetDataFromURLs:@[url] completionHandler:^(NSArray<Pet *> *pets) {
      
      lvc.pets = pets;
      
      [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        
        [lvc.tableView reloadData];
        
      }];
      
    }];
  }
}

@end
