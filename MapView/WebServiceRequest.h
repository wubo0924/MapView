//
//  WebServiceRequest.h
//  MapView
//
//  Created by Bo Wu on 14/03/2014.
//  Copyright (c) 2014 rmit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Security/Security.h>


@interface WebServiceRequest : NSObject<NSURLConnectionDelegate>

@property(nonatomic,strong)NSDictionary *responseData;

@property(nonatomic,strong)NSMutableData *wsResponseData;
@property(nonatomic,strong)NSMutableData *foursquareResponseData;

-(NSDictionary *)foursquareLocationsAPIRequest:(NSString *)latitude longtitude:(NSString *)longitude;
-(NSArray *)wsLocationsAPIRequest;
-(NSString *)wsRegisterRequest:(NSArray *) parameter;

/*** not implement yet***/
-(NSDictionary *)asyncFoursquareRequestWithLatitude:(NSString *)latitude andLongitude:(NSString *)longitude;
-(NSArray *)asyncWSRequest;
/*** end ***/

-(NSDictionary *)surveyLocaions:(NSString *)latitude longtitude:(NSString *)longitude;

-(BOOL)wsLoginWithUsername:(NSString *)username password:(NSString *)password;

-(BOOL)wsRegisterWithUsername:(NSString *)username password:(NSString *)password email:(NSString *)email gender:(NSString *)gender age:(NSString *)age occupation:(NSString *)occupation commuterType:(int) commuterType studentType:(int) studentType;



@end
