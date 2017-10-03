//
//  ViewController.m
//  Lesson_15
//
//  Created by maxud on 29.09.17.
//  Copyright © 2017 lesson_1. All rights reserved.
//

#import "ViewController.h"
static NSString *const kWeatherURL = @"http://samples.openweathermap.org/data/2.5/weather?q=Paris,france&appid=b1b15e88fa797225412429c1c50c122a1";
static NSString *const kPUTURL = @"https://httpbin.org/put";
static NSString *const kGETURL = @"https://httpbin.org/get";
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
                                    
}
- (IBAction)sendWeatherButtonAction:(UIButton *)sender
{
//    NSURLRequest *request = [self weatherRequest];
//    NSURLRequest *request = [self getRestRequest];
     NSURLRequest *request = [self putRequest];
    [self sendRequest:request];
}

- (NSURLRequest*)weatherRequest
{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:kWeatherURL]];
    
    return request;
}

-(NSURLRequest*)putRequest
{
    
    NSError *error = nil;
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:[NSURL URLWithString:kPUTURL]];
    
    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    [request setHTTPMethod:@"PUT"];
    
    NSDictionary *mapData = @{@"name" : @"Ivan", @"phone" : @"4536"};
    
    NSData *postData = [NSJSONSerialization dataWithJSONObject:mapData options:0 error:&error];
    [request setHTTPBody:postData];
    
    return  request;
}

   - (void)sendRequest:(NSURLRequest*)request
    {
        NSURLSession *session = [NSURLSession sharedSession];
        NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)
        {
            NSError *jsonError = nil;
            
            NSDictionary *jsonResponse = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
            
            if (jsonError)
            {
                // Error Parsing JSON
                NSLog(@"%@",jsonError.localizedDescription);
            }
            else
            {
                // Success Parsing JSON
                // Log NSDictionary response:
                NSLog(@"%@",jsonResponse);
            }
        }];
        
        [task resume];
    }

@end
