//
//  TSVenueSurveyViewController.m
//  iTranSafe
//
//  Created by Nishant Sony on 16/03/2014.
//  Copyright (c) 2014 ENVIS. All rights reserved.
//

#import "TSVenueSurveyViewController.h"
#import "TSComfortViewController.h"
@interface TSVenueSurveyViewController ()
@property (nonatomic, strong) NSMutableData *responseData;

@end

NSString *returnData;

@implementation TSVenueSurveyViewController

@synthesize nameStr;
@synthesize foursquareID;

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
    [self.VenueLabel setText:@"Tell us how you feel here?"];
    self.navigationItem.title=self.nameStr;
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)Submit:(id)sender {
    
    //NSLog(@"%d",(int)[self.sad_happy value]);
    //NSLog(@"%d",(int)[self.bored_excited value]);
    //NSLog(@"%d",(int)[self.scared_safe value]);
    //NSLog(@"%d",(int)[self.angry_peaceful value]);
   // NSLog(@"%d",(int)[self.hot_cold value]);
   // NSLog(@"%d",(int)[self.crowded_empty value]);
    //NSLog(@"%d",(int)[self.noisy_quiet value]);
    //NSLog(@"%d",(int)[self.overallcomfort value]);
    //NSLog(@"%d",(int)[self.sad_happy value]);
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    NSDate *myDate = [[NSDate alloc] init];

    [dateFormat setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
    NSString *timestamp = [dateFormat stringFromDate:myDate];
    
    
    NSLog(@"%@",timestamp);
    int sad = 0;
    int happy=0;
    
    if((int)[self.sad_happy value] > 5)
    {
        happy = (5 - (int)[self.sad_happy value]);
        sad = 0;
    }
    else if((int)[self.sad_happy value] < 5)
    {
        sad = (int)[self.sad_happy value];
        happy =0;
        
    }
    
    int bored = 0;
    int excited = 0;
    
    if((int)[self.bored_excited value] > 5)
    {
        excited = (5 - (int)[self.bored_excited value]);
        bored = 0;
    }
    else if((int)[self.bored_excited value] < 5)
    {
        bored = (int)[self.bored_excited value];
        excited =0;
        
    }
    
    int scared=0;
    int safe=0;
    if((int)[self.scared_safe value] > 5)
    {
        safe = (5 - (int)[self.scared_safe value]);
        scared = 0;
    }
    else if((int)[self.scared_safe value] < 5)
    {
        scared = (int)[self.scared_safe value];
        safe =0;
        
    }
    int angry = 0;
    int peaceful = 0;
    if((int)[self.angry_peaceful value] > 5)
    {
        peaceful = (5 - (int)[self.angry_peaceful value]);
        angry = 0;
    }
    else if((int)[self.angry_peaceful value] < 5)
    {
        angry = (int)[self.angry_peaceful value];
        peaceful =0;
        
    }

    
    NSString *url = [NSString stringWithFormat: @"****",timestamp,self.foursquareID,sad,happy,bored,excited,scared,safe,angry,peaceful];
    NSLog(@"%@",url);
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
            NSLog(@"%@",substring);
            returnData = substring;
        }
   // }
    
    NSLog(@"ekjlwkjkljwelklke");
    // [self performSegueWithIdentifier:@"comfort" sender:self];
    
    if ([returnData hasPrefix:@"s"])
    {
        [self performSegueWithIdentifier:@"comfort" sender:self];
        
        
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Connnection Failure" message:@"A Problem occured while sending your survey data,Please try again." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:@"Cancel", nil];
        [alert show];
    }

    
    
    
}



- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"comfort"]) {
        
        TSComfortViewController *vc = [segue destinationViewController];
        
    
        vc.surveyID = returnData;
        vc.namestr = self.nameStr;
        vc.locationID=self.foursquareID;
    }
}




@end
