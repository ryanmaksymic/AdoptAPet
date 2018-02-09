//
//  SearchViewController.m
//  AdoptAPet
//
//  Created by Ryan Maksymic on 2018-02-07.
//  Copyright © 2018 Ryan Maksymic. All rights reserved.
//

#import "SearchViewController.h"
#import "PetSearch.h"

@interface SearchViewController ()

@property (nonatomic) PetSearch * petSearch;


@property (weak, nonatomic) IBOutlet UISegmentedControl * petTypeSegmentedControl;

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray * sexButtons;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray * sizeButtons;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray * ageButtons;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray * optionsButtons;

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray * allFilterButtons;

@end


@implementation SearchViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  self.petSearch = [[PetSearch alloc] init];
  self.petSearch.type = PetTypeDog;
}

- (void)collectSearchTerms
{
  self.petSearch.type = self.petTypeSegmentedControl.selectedSegmentIndex == 0 ? PetTypeDog : PetTypeCat;
  
  [self.petSearch.sexes removeAllObjects];
  for (UIButton * sexButton in self.sexButtons)
  {
    if (sexButton.isSelected)
    {
      [self.petSearch.sexes addObject:[NSNumber numberWithInteger:sexButton.tag]];
    }
  }
  
  NSLog(@"");
  NSLog(@"Type: %@", [self.petSearch typeString]);
  NSLog(@"Sexes: %@", [self.petSearch sexesString]);
}

- (IBAction)buttonToggled:(UIButton *)sender
{
  sender.selected = !sender.selected;
}

- (IBAction)search:(UIButton *)sender
{
  [self collectSearchTerms];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
  if ([segue.identifier isEqualToString:@"showSearchResults"])
  {
    self.petSearch.locationZip = @"M5T2V4";
    
    // TODO: Use petSearch with NetworkManager method to get array of Pet objects with given search terms
    
    // TODO: Pass Pet array to destination VC
  }
}

@end
