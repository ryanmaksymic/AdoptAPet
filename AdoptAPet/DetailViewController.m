//
//  DetailViewController.m
//  AdoptAPet
//
//  Created by Ryan Maksymic on 2018-02-07.
//  Copyright © 2018 Ryan Maksymic. All rights reserved.
//

#import "DetailViewController.h"
#import "DetailCollectionViewCell.h"
#import "NetworkManager.h"
#import "DataManager.h"
#import "Pet.h"
#import "Contact.h"

@interface DetailViewController () <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

//@property (strong, nonatomic) NSArray<NSString *> *detailPhotos;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *breadLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *sexLabel;
@property (weak, nonatomic) IBOutlet UILabel *sizeLabel;
@property (weak, nonatomic) IBOutlet UILabel *optionsLabel;
@property (weak, nonatomic) IBOutlet UILabel *contactLabel;
// TODO: Add ageLabel
// TODO: Add "more..." button to expand extra-long descriptions (?)

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *favButton = [[UIBarButtonItem alloc]
                                   initWithImage:[UIImage imageNamed:@"fav_button"]
                                   style:UIBarButtonItemStyleDone
                                   target:self
                                  action:@selector(favorite)];
    self.navigationItem.rightBarButtonItem = favButton;
    


    [self loadInfo];
}

- (void)favorite {
    [DataManager savePet:self.pet];
    self.navigationItem.rightBarButtonItem.image = [UIImage imageNamed:@"fav_button2"];
}

- (void)loadInfo {
    
    self.collectionView.delegate = self;
    self.descriptionLabel.text = self.pet.petDescription;
    self.sizeLabel.text = [self.pet sizeString];
    self.sexLabel.text = [self.pet sexString];
    self.breadLabel.text = [NSString stringWithFormat:@"%@ %@", [self.pet breedsString], self.pet.mix ? @" | Mixed" : @""];
    self.locationLabel.text = [NSString stringWithFormat:@"%@, %@", self.pet.contact.city, self.pet.contact.state];
    self.dateLabel.text = [NSString stringWithFormat:@"Last updated: %@", [self.pet lastUpdatedString]];
    self.optionsLabel.text = [self.pet optionsString];
    self.contactLabel.text = [self.pet contactString];
    

}

- (void)setPet:(Pet *)pet {
    _pet = pet;

    self.navigationItem.title = pet.name;
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    DetailCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"imageCell" forIndexPath:indexPath];
    
    if (self.pet.photos.count-1 < indexPath.item) {
        [NetworkManager fetchImageFileFromURL:self.pet.photoURLs[indexPath.row] completionHandler:^(UIImage * image) {
            self.pet.photos[indexPath.row] = image;

            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                
                cell.photo.image = self.pet.photos[indexPath.item];
                
                
            }];
        }];
    } else {
        cell.photo.image = self.pet.photos[indexPath.item];
    }
    
    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSLog(@"TOTAL: %li", self.pet.photoURLs.count ? self.pet.photoURLs.count : 1);
    return self.pet.photoURLs.count ? self.pet.photoURLs.count : 1;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return self.collectionView.frame.size;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0.0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0.0;
}

@end
