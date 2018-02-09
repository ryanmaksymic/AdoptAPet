//
//  SearchViewController.m
//  AdoptAPet
//
//  Created by Ryan Maksymic on 2018-02-07.
//  Copyright © 2018 Ryan Maksymic. All rights reserved.
//

#import "SearchViewController.h"

@interface SearchViewController ()

@property (weak, nonatomic) IBOutlet UISegmentedControl * petTypeSegmentedControl;

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray * sexButtons;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray * sizeButtons;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray * ageButtons;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray * optionsButtons;

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *allFilterButtons;

@end


@implementation SearchViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  
}

- (IBAction)buttonToggled:(UIButton *)sender
{
  sender.selected = !sender.selected;
  
  NSLog(@"Button #%ld", sender.tag);

}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
  if ([segue.identifier isEqualToString:@"showSearchResults"])
  {
    // TODO: Collect search terms
  }
}

@end
