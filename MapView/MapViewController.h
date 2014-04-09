//
//  MapViewController.h
//  MapView
//
//  Created by Bo Wu on 9/03/2014.
//  Copyright (c) 2014 rmit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GoogleMaps/GoogleMaps.h>
#import <Security/Security.h>

@interface MapViewController : UIViewController<GMSMapViewDelegate,NSURLConnectionDelegate>


@property (weak, nonatomic) IBOutlet UIView *mapOnScreen;

-(void)foursquareRequest:(NSString *)latitude longtitude:(NSString *)longitude;


@end
