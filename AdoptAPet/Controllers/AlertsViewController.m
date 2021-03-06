//
//  AlertsViewController.m
//  AdoptAPet
//
//  Created by Ryan Maksymic on 2018-02-10.
//  Copyright © 2018 Ryan Maksymic. All rights reserved.
//

#import "AlertsViewController.h"
#import "PetSearch.h"
#import "SearchViewController.h"
#import "DataManager.h"

@interface AlertsViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView * tableView;

@property (nonatomic) NSMutableArray<PetSearch *> * alerts;

@end


@implementation AlertsViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  self.alerts = [DataManager getSavedSearches];
}


#pragma mark - Button actions

- (IBAction)done:(UIBarButtonItem *)sender
{
  [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)addAlert:(UIBarButtonItem *)sender
{
  if (![self alertAlreadyExists:self.currentSearch])
  {
    [self.alerts addObject:self.currentSearch];
    
    [self.tableView reloadData];
    
    [DataManager saveSearch:self.currentSearch];
  }
}

- (BOOL)alertAlreadyExists:(PetSearch *)currentPetSearch
{
  for (PetSearch * petSearch in self.alerts)
  {
    if ((petSearch.idPetSearch == currentPetSearch.idPetSearch) ||
        (petSearch.type == currentPetSearch.type && petSearch.sex == currentPetSearch.sex && petSearch.size == currentPetSearch.size && petSearch.age == currentPetSearch.age))
    {
      return YES;
    }
  }
  
  return NO;
}


#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return [self.alerts count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"alertCell"];
  
  cell.textLabel.text = [self.alerts[indexPath.row] searchTermsString];
  
  return cell;
}


#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  PetSearch * selectedAlert = self.alerts[indexPath.row];
  
  [self.delegate alertsViewController:self didSelectAlert:selectedAlert];
  
  [self dismissViewControllerAnimated:YES completion:nil];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
  return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
  if (editingStyle == UITableViewCellEditingStyleDelete)
  {
    PetSearch * alert = self.alerts[indexPath.row];
    
    [DataManager deleteSearch:alert.idPetSearch];
    
    [self.alerts removeObjectAtIndex:indexPath.row];
    
    [tableView reloadData];
  }
}

@end
