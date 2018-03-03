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
#import "Pet.h"

@interface FavouritesViewController ()

@property NSMutableArray<Pet *> *favArray;
@property ListViewController * lvc;

@end

@implementation FavouritesViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo"]];
  
  self.favArray = [[NSMutableArray alloc] init];
  
  self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Clear" style:UIBarButtonItemStyleDone target:self action:@selector(clearFavourites)];
}

- (void)viewDidAppear:(BOOL)animated
{
  self.lvc.pets = [NSArray arrayWithArray:[DataManager getFavourites]];
  [self.lvc.tableView setNeedsDisplay];
  [self.lvc.tableView reloadData];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
  if ([segue.identifier isEqualToString:@"embedList"])
  {
    self.lvc = (ListViewController *)segue.destinationViewController;
    
    self.lvc.pets = [NSArray arrayWithArray:[DataManager getFavourites]];
    
    
  }
}

- (void)clearFavourites {
  [DataManager deleteAllPetsCompletionHandler:^{
    
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
      
      for (Pet *pet in self.lvc.pets) {
        pet.isFavorite = NO;
      }
      self.lvc.pets = @[];
      [self.lvc.tableView setNeedsDisplay];
      [self.lvc.tableView reloadData];
      
    }];
    
  }];
}

@end
