//
//  ViewController.m
//  MapView
//
//  Created by Bo Wu on 4/03/2014.
//  Copyright (c) 2014 rmit. All rights reserved.
//

#import "MapViewController.h"
#import "WebServiceRequest.h"
#import "KeychainItemWrapper.h"

@interface MapViewController ()
{
    
}

@end

@implementation MapViewController
{
    GMSMapView *mapView_;
    GMSCameraPosition *camera;
    NSURLConnection *currentConnection;
    CLLocationManager *locationManager;
    double currentLatitude;
    double currentLongitude;
    WebServiceRequest *wsr;
}

@synthesize mapOnScreen;



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    wsr = [WebServiceRequest new];
    
    /********/
    
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

    
    /********/
    
    
    mapView_ =[GMSMapView mapWithFrame:self.mapOnScreen.bounds camera:nil];
    mapView_.myLocationEnabled = YES;
    mapView_.settings.myLocationButton=YES;
    mapView_.settings.zoomGestures=YES;
    mapView_.delegate = self;
    //self.view = mapView_;
    [self.mapOnScreen addSubview:mapView_];
    
    //add observer
    [mapView_ addObserver:self forKeyPath:@"myLocation" options:0 context:nil];
    
    /*
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:-33.0
                                                            longitude:151.20
                                                                 zoom:6];
    
    map3 = [GMSMapView mapWithFrame:self.mapOnScreen.bounds camera:nil];
    map3.myLocationEnabled=YES;
    map3.settings.myLocationButton=YES;
    [self.mapOnScreen addSubview:map3];*/
    
}

-(void)viewDidAppear:(BOOL)animated
{
    camera = [GMSCameraPosition cameraWithLatitude:currentLatitude
                                         longitude:currentLongitude
                                              zoom:14];
    [mapView_ animateToCameraPosition:camera];
    
    NSDictionary *loctionCollection=[wsr surveyLocaions:[NSString stringWithFormat:@"%f", currentLatitude]longtitude:[NSString stringWithFormat:@"%f", currentLongitude]];
    
    NSDictionary *surveyDic = [loctionCollection objectForKey:@"survey"];
    NSDictionary *nonsurveyDic = [loctionCollection objectForKey:@"nonsurvey"];
    
    if([surveyDic count]>0){
        NSArray *surveyInfo;
        for(id key in surveyDic){
            surveyInfo = [surveyDic objectForKey:key];
            
            GMSMarker *marker = [[GMSMarker alloc] init];
            marker.position = CLLocationCoordinate2DMake([[surveyInfo objectAtIndex:1] doubleValue], [[surveyInfo objectAtIndex:2] doubleValue]);
            marker.title=[surveyInfo objectAtIndex:0];
            marker.icon=[UIImage imageNamed:@"yellowmarker.png"];
            marker.map = mapView_;
        }
        

    }
    if([nonsurveyDic count]>0){
        NSArray *nonsurveyInfo;
        for(id key in nonsurveyDic){
            nonsurveyInfo = [nonsurveyDic objectForKey:key];
            
            GMSMarker *marker = [[GMSMarker alloc] init];
            marker.position = CLLocationCoordinate2DMake([[nonsurveyInfo objectAtIndex:1] doubleValue], [[nonsurveyInfo objectAtIndex:2] doubleValue]);
            marker.title=[nonsurveyInfo objectAtIndex:0];
            marker.icon=[UIImage imageNamed:@"bluemarker.png"];
            marker.map = mapView_;
        }

    }
    //NSLog(@"count:::::%i",(int)[loctionCollection count]);
    
    //[self foursquareRequest:@(currentLatitude).stringValue longtitude:@(currentLongitude).stringValue];
    
   
}


-(void)dealloc
{
    [mapView_ removeObserver:self forKeyPath:@"myLocation"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if([keyPath isEqualToString:@"myLocation"])
    {
        currentLatitude=mapView_.myLocation.coordinate.latitude;
        currentLongitude=mapView_.myLocation.coordinate.longitude;
    }
    
}

//implement self-define method
-(void)foursquareRequest:(NSString *)latitude longtitude:(NSString *)longitude
{
    /*
    NSMutableString *url=[[NSMutableString alloc] initWithFormat:@"https://api.foursquare.com/v2/venues/search?ll="];
    [url appendFormat:@"%@",latitude];
    [url appendString:@","];
    [url appendFormat:@"%@",longitude];
    [url appendString:@"&client_id=FHGRALBMIKR04JREC02GPFOJFXNEDXVFJ0LCUM5J025YRFHY&client_secret=2BTYTCA4NIKM0EXVVKQ2NFQRXYPJ252RO4EDB0GVLTLMOLBI&v=20140130"];
    //NSLog(@"%@",url);
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:url]] cachePolicy: NSURLRequestUseProtocolCachePolicy timeoutInterval:15.0];
    
    currentConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    */
    
}


#pragma mark - GMSMapViewDelegate

-(void)mapView:(GMSMapView *)mapView didTapInfoWindowOfMarker:(GMSMarker *)marker{
    //NSLog(@"%@ info window has been clicked...",marker.title);
}

- (void)mapView:(GMSMapView *)mapView willMove:(BOOL)gesture {
    
    
    
    //NSLog(@"Latitude::::%f----Longitude::::%f",lat,lnt);
    [mapView_ clear];
    
}

- (void)mapView:(GMSMapView *)mapView idleAtCameraPosition:(GMSCameraPosition *)cameraPosition
{
    
    double lat=(double)cameraPosition.target.latitude;
    double lnt=(double)cameraPosition.target.longitude;
    
    NSDictionary *loctionCollection=[wsr surveyLocaions:[NSString stringWithFormat:@"%f", lat]longtitude:[NSString stringWithFormat:@"%f", lnt]];
    
    NSDictionary *surveyDic = [loctionCollection objectForKey:@"survey"];
    NSDictionary *nonsurveyDic = [loctionCollection objectForKey:@"nonsurvey"];
    
    if([surveyDic count]>0){
        NSArray *surveyInfo;
        for(id key in surveyDic){
            surveyInfo = [surveyDic objectForKey:key];
            
            GMSMarker *marker = [[GMSMarker alloc] init];
            marker.position = CLLocationCoordinate2DMake([[surveyInfo objectAtIndex:1] doubleValue], [[surveyInfo objectAtIndex:2] doubleValue]);
            marker.title=[surveyInfo objectAtIndex:0];
            marker.icon=[UIImage imageNamed:@"yellowmarker.png"];
            marker.map = mapView_;
        }
        
        
    }
    if([nonsurveyDic count]>0){
        NSArray *nonsurveyInfo;
        for(id key in nonsurveyDic){
            nonsurveyInfo = [nonsurveyDic objectForKey:key];
            
            GMSMarker *marker = [[GMSMarker alloc] init];
            marker.position = CLLocationCoordinate2DMake([[nonsurveyInfo objectAtIndex:1] doubleValue], [[nonsurveyInfo objectAtIndex:2] doubleValue]);
            marker.title=[nonsurveyInfo objectAtIndex:0];
            marker.icon=[UIImage imageNamed:@"bluemarker.png"];
            marker.map = mapView_;
        }
        
    }
    
    //[self foursquareRequest:@(lat).stringValue longtitude:@(lnt).stringValue];
    
    GMSMarker *marker = [[GMSMarker alloc] init];
    marker.position = CLLocationCoordinate2DMake(currentLatitude,currentLongitude);
    marker.title=@"You are here!";
    marker.map = mapView_;
    //NSLog(@"Latitude is:::%f----Longitude is:::%f",cameraPosition.target.latitude,cameraPosition.target.longitude);
}


-(BOOL)mapView:(GMSMapView *)mapView didTapMarker:(GMSMarker *)marker
{
    //NSLog(@"%@ marker has been clicked...",marker.title);
    return NO;
}



#pragma mark - NSURLConnectionDelegate
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)d {
    
    NSMutableData *data=[[NSMutableData alloc] init];
    
    /*if(!data)
     {
     data = [[NSMutableData alloc] init];
     }*/
    
    [data appendData:d];
    //NSString *s = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
    
    
    
    NSString *keyAsString;
    NSString *valueAsString;
    
    NSMutableArray *latitude=[[NSMutableArray alloc]init];
    NSMutableArray *longtitude=[[NSMutableArray alloc]init];
    NSMutableArray *locationName=[[NSMutableArray alloc]init];
    
    int locationCount=0;
    int nameCount=0;
    
    for (id key in dic) {
        id value = [dic objectForKey:key];
        
        keyAsString = (NSString *)key;
        valueAsString = (NSString *)value;
        
        //NSLog(@"Key is::::%@",keyAsString);
        //NSLog(@"Value is::::%@",valueAsString);
        
        if([keyAsString isEqualToString:@"response"]){
            NSDictionary *responseDic=(NSDictionary *)value;
            
            for(id responseKey in responseDic){
                if([((NSString *)responseKey) isEqualToString:@"venues"]){
                    NSArray *venuesArray=[responseDic objectForKey:@"venues"];
                    NSEnumerator *enumerator = [venuesArray objectEnumerator];
                    NSDictionary *venueDic;
                    while(venueDic=(NSDictionary *)[enumerator nextObject])
                    {
                        
                        
                        for(NSString *venueKey in venueDic){
                            
                            if([venueKey isEqualToString:@"location"]){
                                
                                NSDictionary *locationDic=[(NSDictionary *)venueDic objectForKey:@"location"];
                                locationCount++;
                                
                                [latitude addObject:[locationDic objectForKey:@"lat"]];
                                [longtitude addObject:[locationDic objectForKey:@"lng"]];
                                
                                
                                /*GMSMarker *marker = [[GMSMarker alloc] init];
                                 marker.position = CLLocationCoordinate2DMake([latitude doubleValue], [longtitude doubleValue]);
                                 marker.map = mapView_;*/
                            }
                            if([venueKey isEqualToString:@"name"]){
                                
                                [locationName addObject:[venueDic objectForKey:@"name"]];
                                nameCount++;
                                //NSLog(@"%@",[venueDic objectForKey:@"name"]);
                                /*
                                 NSDictionary *nameDic=[(NSDictionary *)venueDic objectForKey:@"name"];
                                 locationName=[nameDic objectForKey:@"name"];
                                 marker.title=locationName;*/
                            }
                            
                        }
                    }
                }
            }
            break;
        }
    }
    //NSLog(@"Location count:::%i----Name count:::%i",locationCount,nameCount);
    int count = [latitude count];
    for(int i=0;i<count;i++){
        GMSMarker *marker = [[GMSMarker alloc] init];
        marker.position = CLLocationCoordinate2DMake([[latitude objectAtIndex:i] doubleValue], [[longtitude objectAtIndex:i] doubleValue]);
        marker.title=[locationName objectAtIndex:i];
        marker.icon=[UIImage imageNamed:@"flag.png"];
        marker.map = mapView_;
    }
}


-(IBAction)displayView:(id)sender
{
    NSInteger tag = [sender tag];
    if(tag==1){
        [self performSegueWithIdentifier:@"listViewSegue" sender:sender];
        return;
    }
    if(tag==4){
        /*
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"INFO" message:@"LIST VIEW - to fill out a survey\nMAP VIEW - to see other places that have been surveyed\nView Participant Terms & Conditions? Clicking YES will open a PDF, please allow pop-ups to view it." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
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
        
        return;    }
    
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
