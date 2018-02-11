//
//  MapViewController.m
//  AdoptAPet
//
//  Created by Fernando Zanei on 2018-02-08.
//  Copyright © 2018 Ryan Maksymic. All rights reserved.
//

#import "MapViewController.h"
#import "NetworkManager.h"
#import "Pet.h"
#import "Contact.h"
#import "ListViewController.h"
@import MapKit;
@import CoreLocation;

@interface MapViewController () <CLLocationManagerDelegate, MKMapViewDelegate>

@property (strong, nonatomic) CLLocationManager *locationManager;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) NSArray<Contact<MKAnnotation> *> *shelters;

@end


@implementation MapViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  self.locationManager = [[CLLocationManager alloc] init];
  
  [self.locationManager requestWhenInUseAuthorization];
  [self.mapView setShowsUserLocation:YES];
  [self.locationManager setDelegate:self];
  [self.mapView setDelegate:self];
  [self.mapView registerClass:[MKMarkerAnnotationView class] forAnnotationViewWithReuseIdentifier:@"reuse"];
  NSString *loc = self.locationZip;
  [self loadFilterLocation:loc];
  [self loadShelters:loc];
}

- (void)getGeoInformations:(NSString *)location completionHandler:(void (^)(CLLocationCoordinate2D))completion {
  CLGeocoder *geoCoder = [[CLGeocoder alloc] init];
  [geoCoder geocodeAddressString:location completionHandler:^(NSArray* placemarks, NSError* error){
    
    if(error) {
      NSLog(@"Error");
      return;
    }
    
    CLPlacemark *placemark = [placemarks lastObject];
    NSString *str_latitude = [NSString stringWithFormat: @"%f", placemark.location.coordinate.latitude];
    NSString *str_longitude = [NSString stringWithFormat: @"%f", placemark.location.coordinate.longitude];
    CLLocationCoordinate2D locationCoordinates = CLLocationCoordinate2DMake([str_latitude floatValue],
                                                                            [str_longitude floatValue]);
    completion(locationCoordinates);
  }];
}

- (void)loadFilterLocation:(NSString *)location {
  [self getGeoInformations:location  completionHandler:^(CLLocationCoordinate2D locationCoordinates) {
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
      [self.mapView setRegion:MKCoordinateRegionMake(locationCoordinates, MKCoordinateSpanMake(0.2, 0.2))];
    }];
  } ];
}

- (void)loadShelters:(NSString *)location {
  [NetworkManager fetchShelterDataFromLocation:location completionHandler:^(NSArray<Contact *> *contacts)
   {
     NSMutableSet * petShelters = [NSMutableSet set];
     
     for (Pet * pet in self.pets)
     {
       [petShelters addObject:pet.shelterID];
     }
     
     NSPredicate * shelterIDInSearchResults = [NSPredicate predicateWithBlock:^BOOL(id  _Nullable evaluatedObject, NSDictionary<NSString *,id> * _Nullable bindings) {
       
       Contact * shelter = (Contact *)evaluatedObject;
       
       if ([petShelters containsObject:shelter.idNumber])
       {
         return YES;
       }
       
       return NO;
       
     }];
     
     NSArray<Contact *> * filteredShelters = [contacts filteredArrayUsingPredicate:shelterIDInSearchResults];
     
     self.shelters = filteredShelters;
     
     [[NSOperationQueue mainQueue] addOperationWithBlock:^{
       //[self.mapView addAnnotations:self.shelters];
       [self.mapView showAnnotations:self.shelters animated:YES];
     }];
     
   }];
}

# pragma mark - Location Manager

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
  if (status == kCLAuthorizationStatusAuthorizedWhenInUse || status == kCLAuthorizationStatusAuthorizedAlways) {
    [self.locationManager requestLocation];
  }
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
  
  if (![annotation isKindOfClass:[Contact class]]) {
    return nil;
  }
  MKMarkerAnnotationView *marker = (MKMarkerAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:@"reuse" forAnnotation:annotation];
  
  if (marker == nil) {
    marker = [[MKMarkerAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"reuse"];
  }
  
  UIButton *button = [UIButton buttonWithType:UIButtonTypeInfoLight];
  marker.rightCalloutAccessoryView = button;
  
  marker.canShowCallout = YES;
  return marker;
}

-(void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {
  [self performSegueWithIdentifier:@"showList" sender:view];
}

# pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  if ([segue.identifier isEqualToString:@"showList"])
  {
    MKAnnotationView * annotationView = (MKAnnotationView *)sender;
    Contact * shelter = (Contact *)annotationView.annotation;
    
    ListViewController * lvc = (ListViewController *)segue.destinationViewController;
    lvc.title = shelter.title;
    
    NSString * shelterID = shelter.idNumber;
    
    NSPredicate * petHasShelterID = [NSPredicate predicateWithBlock:^BOOL(id  _Nullable evaluatedObject, NSDictionary<NSString *,id> * _Nullable bindings) {
      
      Pet * pet = (Pet *)evaluatedObject;
      
      if ([pet.shelterID isEqualToString:shelterID])
      {
        return YES;
      }
      
      return NO;
      
    }];
    
    NSArray * shelterPets = [self.pets filteredArrayUsingPredicate:petHasShelterID];
    
    lvc.pets = shelterPets;
  }
}

@end
