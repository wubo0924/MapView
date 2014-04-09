//
//  TSComfortViewController.m
//  iTranSafe
//
//  Created by Nishant Sony on 23/03/2014.
//  Copyright (c) 2014 ENVIS. All rights reserved.
//

#import "TSComfortViewController.h"
#import "TSPieChartTabViewController.h"
#import "PieChartTabBarController.h"

@interface TSComfortViewController ()

@end

@implementation TSComfortViewController

@synthesize locationID;

NSString *returnData;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
   
    
	// Do any additional setup after loading the view.
    self.navigationItem.title=self.namestr;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)submitButton:(id)sender {
    /*
    NSLog(@"%d",(int)[self.hot_cold value]);
    NSLog(@"%d",(int)[self.crowded_empty value]);
    NSLog(@"%d",(int)[self.noisy_quiet value]);
    NSLog(@"%d",(int)[self.overallcomfort value]);*/
    
    int hot = 0;
    int cold = 0;
    
    if((int)[self.hot_cold value] > 5)
    {
        cold = (5 - (int)[self.hot_cold value]);
        hot = 0;
    }
    else if((int)[self.hot_cold value] < 5)
    {
        hot = (int)[self.hot_cold value];
        cold = 0;
        
    }
    
    int crowded = 0;
    int empty = 0;
    
    if((int)[self.crowded_empty value] > 5)
    {
        empty = (5 - (int)[self.crowded_empty value]);
        crowded = 0;
    }
    else if((int)[self.crowded_empty value] < 5)
    {
        crowded = (int)[self.crowded_empty value];
        empty = 0;
        
    }
    
    int noisy=0;
    int quiet=0;
    if((int)[self.noisy_quiet value] > 5)
    {
        quiet = (5 - (int)[self.noisy_quiet value]);
        noisy = 0;
    }
    else if((int)[self.noisy_quiet value] < 5)
    {
        noisy = (int)[self.noisy_quiet value];
        quiet =0;
        
    }
    
    int overall_comfort = (int)[self.overallcomfort value];
    NSString *comments = @"Nice Place";
    
    NSString *url = [NSString stringWithFormat: @"****",self.surveyID,hot,cold,noisy,quiet,crowded,empty,overall_comfort,comments];
    //NSLog(@"%@",url);
    //
   NSString *encodedUrl = [url stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
    //
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:
                                    [NSURL URLWithString:encodedUrl]];

    
    
    NSData *data_rcv = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    returnData=[[NSString alloc]initWithData:data_rcv encoding:NSUTF8StringEncoding];
    
    NSScanner *scanner = [NSScanner scannerWithString:returnData];
    [scanner scanUpToString:@"<ns:return>" intoString:nil]; // Scan all characters before #
    
    
    //  while(![scanner isAtEnd]) {
    NSString *substring = nil;
    [scanner scanString:@"<ns:return>" intoString:nil]; // Scan the # character
    if([scanner scanUpToString:@"</ns:return>" intoString:&substring]) {
        // If the space immediately followed the #, this will be skipped
        // [substrings addObject:substring];
        //NSLog(@"%@",substring);
        returnData = substring;
    }
    // }
    
    // [self performSegueWithIdentifier:@"comfort" sender:self];
    
    if ([returnData isEqualToString:@"Success"])
    {
        [self performSegueWithIdentifier:@"piechart" sender:self];
        
        
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Connnection Failure" message:@"A Problem occured while sending your survey data,Please try again." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:@"Cancel", nil];
        [alert show];
    }
    
    // [request setHTTPMethod:@"GET"];
    // [request setValue:@"application/json" forKey:<#(NSString *)#>]
    
   // [[NSURLConnection alloc] initWithRequest:request delegate:self];

}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
   
    if ([[segue identifier] isEqualToString:@"piechart"]) {
        
        
        //PieChartViewController2 *pieChartView=[segue destinationViewController];
        
        PieChartTabBarController *tabBarController = [segue destinationViewController];
        [tabBarController setLocation:self.locationID];
        
        // vc.surveyID = returnData;
       // vc.namestr = self.nameStr;
        
    }
}


@end
