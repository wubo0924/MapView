//
//  TSViewController.h
//  iTranSafe
//
//  Created by Nishant Sony on 10/03/2014.
//  Copyright (c) 2014 ENVIS. All rights reserved.
//

#import <MapKit/MapKit.h>
#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <Security/Security.h>

@interface TSViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate,CLLocationManagerDelegate,UIAlertViewDelegate>

@property(nonatomic,strong)CLLocation *currentLocation;


@end

