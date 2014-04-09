//
//  TSViewController.m
//  iTranSafe
//
//  Created by Nishant Sony on 10/03/2014.
//  Copyright (c) 2014 ENVIS. All rights reserved.
//

#import "TSViewController.h"
#import "TSVenueSurveyViewController.h"
#import "KeychainItemWrapper.h"

@interface TSViewController ()

@property (nonatomic, strong) NSMutableData *responseData;



@end

@implementation TSViewController
//@synthesize tableView=_tableView;
NSMutableArray *tableData;
NSMutableArray *venueFSQID;
NSString *venuename;
NSString *venueID;
NSMutableArray *distance;

CLLocationManager *locationManager;



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [locationManager startUpdatingLocation];
    
    
    
    
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button1 setFrame:CGRectMake(0, 0, 40, 40)];
    [button1 setBackgroundImage:[UIImage imageNamed:@"icon_listview_new.png"] forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(displayView:) forControlEvents:UIControlEventTouchUpInside];
    [button1 setTag:1];
    
    UIButton *button2= [UIButton buttonWithType:UIButtonTypeCustom];
    [button2 setFrame:CGRectMake(0, 0, 40, 40)];
    [button2 setBackgroundImage:[UIImage imageNamed:@"icon_mapview.png"] forState:UIControlStateNormal];
    [button2 addTarget:self action:@selector(displayView:) forControlEvents:UIControlEventTouchUpInside];
    [button2 setTag:2];
    
    UIButton *button3= [UIButton buttonWithType:UIButtonTypeCustom];
    [button3 setFrame:CGRectMake(0, 0, 40, 40)];
    [button3 setBackgroundImage:[UIImage imageNamed:@"icon_login.png"] forState:UIControlStateNormal];
    [button3 addTarget:self action:@selector(displayView:) forControlEvents:UIControlEventTouchUpInside];
    [button3 setTag:3];
    
    UIButton *button4= [UIButton buttonWithType:UIButtonTypeCustom];
    [button4 setFrame:CGRectMake(0, 0, 40, 40)];
    [button4 setBackgroundImage:[UIImage imageNamed:@"icon_info.png"] forState:UIControlStateNormal];
    [button4 addTarget:self action:@selector(displayView:) forControlEvents:UIControlEventTouchUpInside];
    [button4 setTag:4];
    
    UIBarButtonItem *listButton = [[UIBarButtonItem alloc] initWithCustomView:button1];
    UIBarButtonItem *mapButton = [[UIBarButtonItem alloc] initWithCustomView:button2];
    UIBarButtonItem *loginButton=[[UIBarButtonItem alloc] initWithCustomView:button3];
    UIBarButtonItem *infoButton=[[UIBarButtonItem alloc] initWithCustomView:button4];
    
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:infoButton,loginButton,mapButton,listButton,nil];
    
    
    //NSLog(@"viewdidload");
    tableData = [[NSMutableArray alloc] init];
    venueFSQID = [[NSMutableArray alloc] init];
    self.responseData = [NSMutableData data];
    
    
    
    
  
    
	
}
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    //NSLog(@"didReceiveResponse");
    [self.responseData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [self.responseData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    //NSLog(@"didFailWithError");
    //NSLog([NSString stringWithFormat:@"Connection failed: %@", [error description]]);
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    
    
    /***add by BO***/
    [venueFSQID removeAllObjects];
    [tableData removeAllObjects];
    /***before add remove all***/
    
    // convert to JSON
    NSError *myError = nil;
    NSDictionary *res = [NSJSONSerialization JSONObjectWithData:self.responseData options:NSJSONReadingMutableLeaves error:&myError];
    
    // show all values
    for(id key in res) {
        
        id value = [res objectForKey:key];
        
        NSString *keyAsString = (NSString *)key;
        NSString *valueAsString = (NSString *)value;
        
        //NSLog(@"key: %@", keyAsString);
        //NSLog(@"value: %@", valueAsString);
    }
    
//    // extract specific value...
    NSArray *results = [res valueForKeyPath:@"response.venues"];
    //NSLog(@"%lu",sizeof(results));
    
    
    for (NSDictionary *result in results) {
        NSString *name = [result objectForKey:@"name"];
        NSString *vid = [result objectForKey:@"id"];
        //NSLog(@"id: %@",vid);
        
        
        
        [venueFSQID addObject:vid];
        [tableData addObject:name];
        //NSLog(@"name: %@", name);
       // NSLog(@"id: %@",vid);
    }
    NSLog(@"venueFSQID length:%i",[venueFSQID count]);
    NSLog(@"tableData length:%i",[tableData count]);
    [[self tableView] reloadData];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [tableData count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    cell.textLabel.text = [tableData objectAtIndex:indexPath.row];
    //cell.detailTextLabel =
    return cell;
}

- (void) tableView: (UITableView *) tableView didSelectRowAtIndexPath: (NSIndexPath *) indexPath {
    
    
    venuename = [tableData objectAtIndex:indexPath.row];
    venueID = [venueFSQID objectAtIndex:indexPath.row];

    

    [self performSegueWithIdentifier:@"venueSurvey" sender:self];

}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"venueSurvey"]) {
        
        // Get destination view
        TSVenueSurveyViewController *vc = [segue destinationViewController];
        
        
        vc.nameStr = venuename;
        //NSLog(@"venueID:%@",venueID);
        vc.foursquareID = venueID;
    }
}

-(IBAction)displayView:(id)sender
{
    NSInteger tag = [sender tag];
    if(tag==2){
        [self performSegueWithIdentifier:@"mapViewSegue" sender:sender];
        return;
    }
    if(tag==4){
        /*UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"INFO" message:@"LIST VIEW - to fill out a survey\nMAP VIEW - to see other places that have been surveyed\nView Participant Terms & Conditions? Clicking YES will open a PDF, please allow pop-ups to view it." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
         [alert show];*/
        [self performSegueWithIdentifier:@"infoViewSegue" sender:sender];
        return;
    }
    if(tag==3){
        
        KeychainItemWrapper *keychain =[[KeychainItemWrapper alloc] initWithIdentifier:@"au.edu.rmit.s3363780.MapView" accessGroup:nil];
        NSString *secattrValue=[keychain objectForKey:(__bridge id)kSecAttrService];
        NSString *secvaluedata=[keychain objectForKey:(__bridge id)kSecValueData];
        NSString *secattraccount=[keychain objectForKey:(__bridge id)kSecAttrAccount];
        
        
        
        if(secattraccount!=nil && ![secattraccount isEqualToString:@""]){
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"User Identify" message:@"You have logged in already\n Do you want to log off?" delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
            [alert show];
        }else{
            [self performSegueWithIdentifier:@"loginViewSegue" sender:sender];
        }
        
        return;
    }
    
    
}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError: %@", error);
    UIAlertView *errorAlert = [[UIAlertView alloc]
                               initWithTitle:@"Error" message:@"Failed to Get Your Location" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [errorAlert show];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    float oldLatitude=[[NSString stringWithFormat:@"%.2f", oldLocation.coordinate.latitude] floatValue];
    float oldLongitude=[[NSString stringWithFormat:@"%.2f", oldLocation.coordinate.longitude] floatValue];
    float newLatitude=[[NSString stringWithFormat:@"%.2f", newLocation.coordinate.latitude] floatValue];
    float newLongitude=[[NSString stringWithFormat:@"%.2f", newLocation.coordinate.longitude] floatValue] ;
    
    
    
    if(oldLatitude!=newLatitude || oldLongitude!=newLongitude){
        //NSLog(@"Location changed....");
        NSLog(@"oldLat TO newLat:(%.2f----%.2f)",oldLatitude,newLatitude);
        NSLog(@"oldLon TO newLon:(%.2f----%.2f)",oldLongitude,newLongitude);
        
        
        self.currentLocation = newLocation;
        
        //NSString *url = [NSString stringWithFormat: @"https://api.foursquare.com/v2/venues/search?ll=-24.9333,152.3667&client_id=FHGRALBMIKR04JREC02GPFOJFXNEDXVFJ0LCUM5J025YRFHY&client_secret=2BTYTCA4NIKM0EXVVKQ2NFQRXYPJ252RO4EDB0GVLTLMOLBI&v=20140130"];
        
        NSMutableString *url = [NSMutableString stringWithFormat: @"https://api.foursquare.com/v2/venues/search?ll="];
        [url appendString:[NSString stringWithFormat:@"%.4f", self.currentLocation.coordinate.latitude]];
        [url appendString:@","];
        [url appendString:[NSString stringWithFormat:@"%.4f", self.currentLocation.coordinate.longitude]];
        [url appendString:@"&client_id=FHGRALBMIKR04JREC02GPFOJFXNEDXVFJ0LCUM5J025YRFHY&client_secret=2BTYTCA4NIKM0EXVVKQ2NFQRXYPJ252RO4EDB0GVLTLMOLBI&v=20140130"];
        
        NSString *encodedUrl = [url stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
        
        NSURLRequest *request = [NSURLRequest requestWithURL:
                                 [NSURL URLWithString:encodedUrl]];
        [[NSURLConnection alloc] initWithRequest:request delegate:self];
        
    }
    /*
    if (currentLocation != nil) {
        self.currentLongitude = [NSString stringWithFormat:@"%.8f", currentLocation.coordinate.longitude];
        self.currentLatitude = [NSString stringWithFormat:@"%.8f", currentLocation.oldLocation];
        //NSLog(@"current latitude::%@",self.currentLatitude);
        //NSLog(@"current longitude::%@",self.currentLongitude);
    }*/
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"%i",buttonIndex);
    if(buttonIndex==1){
        KeychainItemWrapper *keychain =[[KeychainItemWrapper alloc] initWithIdentifier:@"au.edu.rmit.s3363780.MapView" accessGroup:nil];
        [keychain resetKeychainItem];
    }
}

@end
