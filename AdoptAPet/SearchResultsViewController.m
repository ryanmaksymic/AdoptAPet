//
//  SearchResultsViewController.m
//  AdoptAPet
//
//  Created by Ryan Maksymic on 2018-02-08.
//  Copyright © 2018 Ryan Maksymic. All rights reserved.
//

#import "SearchResultsViewController.h"
#import "Pet.h"
#import "ListViewController.h"
#import "MapViewController.h"

@interface SearchResultsViewController ()

@property (weak, nonatomic) IBOutlet UISegmentedControl * viewModeSegmentedControl;
@property (weak, nonatomic) IBOutlet UILabel * searchTermsLabel;
@property (weak, nonatomic) IBOutlet UIView * listView;
@property (weak, nonatomic) IBOutlet UIView * mapView;

@end


@implementation SearchResultsViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  self.searchTermsLabel.text = self.searchTerms;
  
  [self.listView setHidden:NO];
  [self.mapView setHidden:YES];
}

- (IBAction)viewModeSegmentedControlValueChanged:(UISegmentedControl *)sender
{
  if (self.viewModeSegmentedControl.selectedSegmentIndex == 0)
  {
    [self.listView setHidden:NO];
    [self.mapView setHidden:YES];
  }
  else
  {
    [self.listView setHidden:YES];
    [self.mapView setHidden:NO];
  }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
  if ([segue.identifier isEqualToString:@"embedList"])
  {
    ListViewController * lvc = (ListViewController *)segue.destinationViewController;
    
    lvc.pets = self.pets;
  }
  
  if ([segue.identifier isEqualToString:@"embedMap"])
  {
    MapViewController * mvc = (MapViewController *)segue.destinationViewController;
    
    mvc.pets = self.pets;
    mvc.locationZip = self.locationZip;
  }
}

@end
