//
//  WebServiceRequest.m
//  MapView
//
//  Created by Bo Wu on 14/03/2014.
//  Copyright (c) 2014 rmit. All rights reserved.
//

#import "WebServiceRequest.h"
#import "KeychainItemWrapper.h"


@implementation WebServiceRequest

@synthesize responseData;

-(NSDictionary *)foursquareLocationsAPIRequest:(NSString *)latitude longtitude:(NSString *)longitude
{
    NSMutableString *url=[[NSMutableString alloc] initWithFormat:@"https://api.foursquare.com/v2/venues/search?ll="];
    [url appendFormat:@"%@",latitude];
    [url appendString:@","];
    [url appendFormat:@"%@",longitude];
    [url appendString:@"&client_id=FHGRALBMIKR04JREC02GPFOJFXNEDXVFJ0LCUM5J025YRFHY&client_secret=2BTYTCA4NIKM0EXVVKQ2NFQRXYPJ252RO4EDB0GVLTLMOLBI&v=20140130"];
    //NSLog(@"%@",url);
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:url]] cachePolicy: NSURLRequestUseProtocolCachePolicy timeoutInterval:15.0];
    
    NSData *receiveData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:receiveData options:NSJSONReadingMutableLeaves error:nil];
    
    
    
    NSString *keyAsString;
    NSString *valueAsString;
    
    NSMutableArray *latitudes=[[NSMutableArray alloc]init];
    NSMutableArray *longtitudes=[[NSMutableArray alloc]init];
    NSMutableArray *locationNames=[[NSMutableArray alloc]init];
    NSMutableArray *locationIDs=[[NSMutableArray alloc]init];
    
    
    
    int locationCount=0;
    int nameCount=0;
    int idCount=0;
    
    for (id key in dic) {
        id value = [dic objectForKey:key];
        keyAsString = (NSString *)key;
        valueAsString = (NSString *)value;
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
                           
                           //NSLog(@"KEY:::%@",venueKey);
                           if([venueKey isEqualToString:@"id"]){
                               [locationIDs addObject:[venueDic objectForKey:venueKey]];
                               idCount++;
                           }
                           if([venueKey isEqualToString:@"location"]){
                               NSDictionary *locationDic=[(NSDictionary *)venueDic objectForKey:venueKey];
                                locationCount++;
                                [latitudes addObject:[locationDic objectForKey:@"lat"]];
                                [longtitudes addObject:[locationDic objectForKey:@"lng"]];
                              }
                            if([venueKey isEqualToString:@"name"]){
                                [locationNames addObject:[venueDic objectForKey:venueKey]];
                                nameCount++;
                             }
                        }
                    }
                }
            }
            break;
        }
    }
    NSMutableDictionary *finalDic = [[NSMutableDictionary alloc]init];
    NSMutableArray *relateInfo;
    for(int i=0;i<idCount;i++){
        relateInfo = [[NSMutableArray alloc]init];
        [relateInfo addObject:[locationNames objectAtIndex:i]];
        [relateInfo addObject:[latitudes objectAtIndex:i]];
        [relateInfo addObject:[longtitudes objectAtIndex:i]];
        [finalDic setValue:relateInfo forKey:[locationIDs objectAtIndex:i]];
    }
    //NSLog(@"final count:::%i",[finalDic count]);
    
    return finalDic;
}

-(NSArray *)wsLocationsAPIRequest
{
   
   NSMutableString *url=[[NSMutableString alloc] initWithFormat:@"***"];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:url]] cachePolicy: NSURLRequestUseProtocolCachePolicy timeoutInterval:15.0];
    
    NSURLResponse * response = nil;
    NSError * error = nil;
    NSData * data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    NSDictionary *receive= [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
    NSArray *locations;
    //NSLog(@"count::::%i",(int)[receive count]);
    for(id key in receive){
        //NSLog(@"key is::::%@",(NSString *)key);
        locations=(NSArray *)[receive objectForKey:key];
        
    }
    //NSLog(@"key is::::%i",(int)[locations count]);
    return locations;
}

-(NSDictionary *)surveyLocaions:(NSString *)latitude longtitude:(NSString *)longitude
{
    NSMutableDictionary *foursquareLocaion = [self foursquareLocationsAPIRequest:latitude longtitude:longitude];
    
    NSMutableArray *wsLocationIDs = [self wsLocationsAPIRequest];
    
    NSMutableDictionary *surveyLocations = [[NSMutableDictionary alloc]init];
    NSMutableDictionary *nonsurveyLocations=[[NSMutableDictionary alloc]init];
    for(id key in foursquareLocaion){
        if([wsLocationIDs containsObject:key]){
            [surveyLocations setValue:[foursquareLocaion objectForKey:key] forKey:key];
        }else{
            [nonsurveyLocations setValue:[foursquareLocaion objectForKey:key] forKey:key];
        }
    }
    //NSLog(@"Survey count:::%i",[surveyLocations count]);
    //NSLog(@"Nonsurvey count:::%i",[nonsurveyLocations count]);
    
    NSMutableDictionary *finalDic = [[NSMutableDictionary alloc] init];
    [finalDic setObject:surveyLocations forKey:@"survey"];
    [finalDic setObject:nonsurveyLocations forKey:@"nonsurvey"];
    return finalDic;
}

-(BOOL)wsLoginWithUsername:(NSString *)username password:(NSString *)password
{
    NSMutableString *url=[[NSMutableString alloc] initWithFormat:@"****"];
    [url appendString:username];
    [url appendString:@"&pass="];
    [url appendString:password];
    [url appendString:@"&response=application/json"];
    
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:url]] cachePolicy: NSURLRequestUseProtocolCachePolicy timeoutInterval:15.0];
    
    NSData * data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    NSDictionary *returnJSON = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];;
    
    NSString *returnString = [returnJSON objectForKey:@"return"];
    
    if(![returnString isEqual:@"Invalid User"]){
        KeychainItemWrapper *keychain =[[KeychainItemWrapper alloc] initWithIdentifier:@"au.edu.rmit.s3363780.MapView" accessGroup:nil];
        [keychain resetKeychainItem];
        
        [keychain setObject:@"UserIdentifier" forKey:(__bridge id)kSecAttrService];
        [keychain setObject:returnString forKey:(__bridge id)kSecValueData];
        
        [keychain setObject:username forKey:(__bridge id)kSecAttrAccount];
        //[keychain setObject:password forKey:(__bridge id)kSecValueData];
        
        return YES;
    }
    

    
    return NO;
}



@end
