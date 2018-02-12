//
//  FavouritesViewController.m
//  AdoptAPet
//
//  Created by Fernando Zanei on 2018-02-11.
//  Copyright © 2018 Ryan Maksymic. All rights reserved.
//

#import "FavouritesViewController.h"
#import "ListViewController.h"
#import "NetworkManager.h"
#import "DataManager.h"

@interface FavouritesViewController ()

@property NSMutableArray<Pet *> *favArray;

@end

@implementation FavouritesViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  self.favArray = [[NSMutableArray alloc] init];
  
  self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Clear" style:UIBarButtonItemStyleDone target:self action:@selector(clearFavourites)];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
  if ([segue.identifier isEqualToString:@"embedList"])
  {
    ListViewController * lvc = (ListViewController *)segue.destinationViewController;
    
    lvc.pets = [NSArray arrayWithArray:[DataManager getFavourites]];
    
    
  }
}

- (void)clearFavourites {
  [DataManager deleteAllPetsCompletionHandler:^{
//    [lvc.tableView reloadData];
  }]
}

@end
