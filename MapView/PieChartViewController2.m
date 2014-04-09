/**
 * Copyright (c) 2011 Muh Hon Cheng
 * Created by honcheng on 28/4/11.
 *
 * Permission is hereby granted, free of charge, to any person obtaining
 * a copy of this software and associated documentation files (the
 * "Software"), to deal in the Software without restriction, including
 * without limitation the rights to use, copy, modify, merge, publish,
 * distribute, sublicense, and/or sell copies of the Software, and to
 * permit persons to whom the Software is furnished to do so, subject
 * to the following conditions:
 *
 * The above copyright notice and this permission notice shall be
 * included in all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT
 * WARRANTY OF ANY KIND, EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
 * MERCHANTABILITY, FITNESS FOR A PARTICULAR
 * PURPOSE AND NONINFRINGEMENT. IN NO EVENT
 * SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
 * LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
 * TORT OR OTHERWISE, ARISING FROM, OUT OF OR
 * IN CONNECTION WITH THE SOFTWARE OR
 * THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 *
 * @author 		Muh Hon Cheng <honcheng@gmail.com>
 * @copyright	2011	Muh Hon Cheng
 * @version
 *
 */

#import "PieChartViewController2.h"
#import "PCPieChart.h"
#import "PieChartTabBarController.h"

@implementation PieChartViewController2

@synthesize tabIndex;//means different views: 0.Happy-Sad 1.Bored-Excited 2.Sacred-Safe 3.Angry-Peaceful 4.Comments
//Base on different number, display different pie chart
@synthesize location;//current location will be passed from submit page


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Overriden to allow any orientation.
    return YES;
}


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

-(void)viewDidLoad{
    [super viewDidLoad];
    
    PieChartTabBarController *tabBar = (PieChartTabBarController *)self.tabBarController;
    
    self.location=tabBar.location;
    NSLog(@"%@",self.location);
    self.tabIndex=self.tabBarItem.tag;
    
    
    
    int height = [self.view bounds].size.width/3*2.; // 220;
    int width = [self.view bounds].size.width; //320;
    PCPieChart *pieChart = [[PCPieChart alloc] initWithFrame:CGRectMake(([self.view bounds].size.width-width)/2,([self.view bounds].size.height-height)/2,width,height)];
    [pieChart setShowArrow:NO];
    [pieChart setSameColorLabel:YES];
    [pieChart setAutoresizingMask:UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleBottomMargin];
    [pieChart setDiameter:width/2];
    [self.view addSubview:pieChart];
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button addTarget:self
               action:@selector(backToHome)
     forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:nil forState:UIControlStateNormal];
    [button.layer setBorderWidth:2.0f];
    
    button.frame = CGRectMake(80.0, 70.0, 50.0, 50.0);
    button.center=CGPointMake(80.0, 50.0);
    
    UIImage *buttonImage = [UIImage imageNamed:@"home_100.png"];
    [button setBackgroundImage:buttonImage forState:UIControlStateNormal];
    
    [self.view addSubview:button];
    
    
    if ([[UIDevice currentDevice] userInterfaceIdiom]==UIUserInterfaceIdiomPad)
    {
        pieChart.titleFont = [UIFont fontWithName:@"HelveticaNeue-Bold" size:30];
        pieChart.percentageFont = [UIFont fontWithName:@"HelveticaNeue-Bold" size:50];
    }
    
    NSString *sampleFileName = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:@"sample_linechart_data.json"];
    NSData *sampleFile = [NSData dataWithContentsOfFile:sampleFileName];
    
    NSMutableString *url = [NSMutableString stringWithFormat: @"*********"];
    [url appendString:self.location];
    NSLog(@"%@",url);
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:url]] cachePolicy: NSURLRequestUseProtocolCachePolicy timeoutInterval:15.0];
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSLog(@"%@",[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding]);
    
    NSError *error = nil;
    NSDictionary *sampleInfo = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
    NSMutableArray *components = [NSMutableArray array];
    for (int i=0; i<10; i++)
        
    {
        NSDictionary *item = [[sampleInfo objectForKey:@"Happy-Sad"] objectAtIndex:i];
        PCPieComponent *component = [PCPieComponent pieComponentWithTitle:[item objectForKey:@"title"] value:[[item objectForKey:@"intensity"] floatValue]];
        [components addObject:component];
        
        if (i==0)
        {
            [component setColour:PCColorYellow];
        }
        else if (i==1)
        {
            [component setColour:PCColorGreen];
        }
        else if (i==2)
        {
            [component setColour:PCColorOrange];
        }
        else if (i==3)
        {
            [component setColour:PCColorRed];
        }
        else if (i==4)
        {
            [component setColour:PCColorBlue];
        }
        if (i==5)
        {
            [component setColour:PCColorYellow];
        }
        else if (i==6)
        {
            [component setColour:PCColorGreen];
        }
        else if (i==7)
        {
            [component setColour:PCColorOrange];
        }
        else if (i==8)
        {
            [component setColour:PCColorRed];
        }
        else if (i==9)
        {
            [component setColour:PCColorBlue];
        }
    }
    [pieChart setComponents:components];
    
}

-(void)backToHome
{
    [self performSegueWithIdentifier:@"homeView" sender:nil];
}




@end
