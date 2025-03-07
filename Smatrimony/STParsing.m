//
//  STParsing.m
//  SteelonCall
//
//  Created by administrator on 30/11/16.
//  Copyright © 2016 com.SteelonCall. All rights reserved.
//

#import "STParsing.h"
#import "URLS.h"
static STParsing *sharedWSHelperObj = nil;
@implementation STParsing
@synthesize HUD;



+ (STParsing *)sharedWebServiceHelper
{
    static dispatch_once_t once;
    
    dispatch_once(&once, ^
                  {
                      sharedWSHelperObj = [[STParsing alloc] init];
                  });
    
    return sharedWSHelperObj;
}


-(void)requesting_GET_ServiceWithString:(NSString *)requestedString requestNumber:(int)reqNo showProgress:(BOOL)progress withHandler:(completionHandler)responseData
{
    
    // [self cancelBeforeOperations];
    
    NSString *network=[self dataNetworkTypeFromStatusBar];
    
    if([network  isEqual: @"no network"])
    {
        UIWindow *window = [[[UIApplication sharedApplication] windows] lastObject];
        
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:window animated:YES];
        
        hud.userInteractionEnabled = NO;
        
        hud.mode = MBProgressHUDModeText;
        
        hud.labelText = @"No Internet Connection";
        
        //  hud.labelFont = [UIFont fontWithName:engFontDesc size:14];
        
        hud.margin = 10.f;
        
        hud.yOffset = 98;
        
        hud.removeFromSuperViewOnHide = YES;
        
        [hud hide:YES afterDelay:2];
        responseData (NO,nil);

    }
    else
    {
        //if (!requestInProcess)
        // {
        UIWindow *window = [[[UIApplication sharedApplication] windows] lastObject];
        
        if (progress)
        {
            [HUD removeFromSuperview];
            HUD = [MBProgressHUD showHUDAddedTo:window animated:YES];
            HUD.hidden =NO;
            HUD.mode = MBProgressHUDAnimationFade;
            
            HUD.labelText = @"Loading";
            
            HUD.userInteractionEnabled = YES;
        }
        else
            HUD.hidden =YES;
        
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        AFJSONResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
        responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
        manager.responseSerializer =responseSerializer;
        //[manager invalidateSessionCancelingTasks:YES];
        
        NSString *urlString;
        
        switch (reqNo)
        {
            case WS_MAIN:
            {
                urlString= [NSString stringWithFormat:@"%@%@",MAIN_Url,requestedString];
                //HUD.userInteractionEnabled = YES;
            }
                break;
                
            case WUS_getPopUPData:
            {
                urlString= [NSString stringWithFormat:@"%@%@",register_Url,requestedString];
                //HUD.userInteractionEnabled = YES;
            }
                break;

                
            case WUS_S_story:
            {
                urlString= [NSString stringWithFormat:@"%@%@",MAIN_Url,requestedString];
                //HUD.userInteractionEnabled = YES;
            }
                break;
            default:
                break;
        }
        
        requestInProcess = YES;
        NSLog(@"url string %@",urlString);
        
        [manager GET:urlString parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject)
         
         {
             
             NSLog(@"%@",responseObject);
             
             [HUD removeFromSuperview];
             HUD.hidden =YES;
             requestInProcess = NO;
             
             responseData (YES,responseObject);
             
         }
             failure:^(NSURLSessionTask *operation, NSError *error)
         {
             
             responseData (NO,error);
             
             [HUD removeFromSuperview];
             
             /*  UIWindow *window = [[[UIApplication sharedApplication] windows] lastObject];
              
              MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:window animated:YES];
              
              hud.userInteractionEnabled = NO;
              
              hud.mode = MBProgressHUDModeText;
              
              hud.labelText = @"Network error";
              
              //   hud.labelFont = [UIFont fontWithName:engFontDesc size:14];
              
              hud.margin = 10.0f;
              
              hud.yOffset = 98;
              
              hud.removeFromSuperViewOnHide = YES;
              
              [hud hide:YES afterDelay:2];
              */
             requestInProcess = NO;
             HUD.hidden =YES;
             NSLog(@"Error: %@", error);
             
         }];
        
        //}
    }
}

-(void)requesting_POST_ServiceWithString1:(NSString *)requestedString parameters :(NSDictionary *)parameters requestNumber:(int)reqNo showProgress:(BOOL)progress withHandler:(completionHandler1)responseData
{
    
    // [self cancelBeforeOperations];
    
    NSString *network=[self dataNetworkTypeFromStatusBar];
    
    if([network  isEqual: @"no network"])
    {
        UIWindow *window = [[[UIApplication sharedApplication] windows] lastObject];
        
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:window animated:YES];
        
        hud.userInteractionEnabled = NO;
        
        hud.mode = MBProgressHUDModeText;
        
        hud.labelText = @"No Internet Connection";
        
        //  hud.labelFont = [UIFont fontWithName:engFontDesc size:14];
        
        hud.margin = 10.f;
        
        hud.yOffset = 98;
        
        hud.removeFromSuperViewOnHide = YES;
        
        [hud hide:YES afterDelay:2];
    }
    else
    {
        //if (!requestInProcess)
        // {
        UIWindow *window = [[[UIApplication sharedApplication] windows] lastObject];
        
        if (progress)
        {
            [HUD removeFromSuperview];
            HUD = [MBProgressHUD showHUDAddedTo:window animated:YES];
            HUD.hidden =NO;
            HUD.mode = MBProgressHUDAnimationFade;
            
            HUD.labelText = @"Loading";
            
            HUD.userInteractionEnabled = YES;
        }
        else
            HUD.hidden =YES;
        
      
        //[manager invalidateSessionCancelingTasks:YES];
        
        NSString *urlString;
        
        switch (reqNo)
        {
            case WS_MAIN:
            {
                urlString= [NSString stringWithFormat:@"%@%@",MAIN_Url,requestedString];
                //HUD.userInteractionEnabled = YES;
            }
                break;
            case WUS_Login:
            {
                urlString= [NSString stringWithFormat:@"%@%@",MAIN_Url,requestedString];
                //HUD.userInteractionEnabled = YES;
            }
                break;
                
            case WUS_Register:
            {
                urlString= [NSString stringWithFormat:@"%@%@",register_Url,requestedString];
                //HUD.userInteractionEnabled = YES;
            }
                break;
                
            case WUS_FPwd:
            {
                urlString= [NSString stringWithFormat:@"%@%@",MAIN_Url,requestedString];
                //HUD.userInteractionEnabled = YES;
            }
                break;
                
            case WUS_Feedback:
            {
                urlString= [NSString stringWithFormat:@"%@%@",MAIN_Url,requestedString];
                //HUD.userInteractionEnabled = YES;
            }
                break;
            case WUS_D_AC:
            {
                urlString= [NSString stringWithFormat:@"%@%@",MAIN_Url,requestedString];
                //HUD.userInteractionEnabled = YES;
            }
                break;
                
            case WUS_Change_pwd:
            {
                urlString= [NSString stringWithFormat:@"%@%@",MAIN_Url,requestedString];
                //HUD.userInteractionEnabled = YES;
            }
                break;
                
            case WUS_logout:
            {
                urlString= [NSString stringWithFormat:@"%@%@",MAIN_Url,requestedString];
                //HUD.userInteractionEnabled = YES;
            }
                break;
                
            case WUS_editProfile:
            {
                urlString= [NSString stringWithFormat:@"%@%@",MAIN_Url,requestedString];
                //HUD.userInteractionEnabled = YES;
            }
                break;
                
            case WUS_Sent_mail:
            {
                urlString= [NSString stringWithFormat:@"%@%@",MAIN_Url,requestedString];
                //HUD.userInteractionEnabled = YES;
            }
                break;
                
            case WUS_Block_list:
            {
                urlString= [NSString stringWithFormat:@"%@%@",MAIN_Url,requestedString];
                //HUD.userInteractionEnabled = YES;
            }
                break;
            case WUS_unblock:
            {
                urlString= [NSString stringWithFormat:@"%@%@",MAIN_Url,requestedString];
                //HUD.userInteractionEnabled = YES;
            }
                break;
            case WUS_PROFILE:
            {
                urlString= [NSString stringWithFormat:@"%@%@",AGENT_MAIN_Url,requestedString];
                //HUD.userInteractionEnabled = YES;
            }
                break;
                     default:
                break;
        }
        
        
        requestInProcess = YES;
        NSLog(@"url string %@",urlString);
        
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        
        // AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        AFJSONResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
        responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json",@"text/html;charset=UTF-8",@"text/html",@"charset=UTF-8", nil];
        
        [manager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        manager.responseSerializer =responseSerializer;
        
        AFSecurityPolicy *policy = [[AFSecurityPolicy alloc] init];
        [policy setAllowInvalidCertificates:NO];
       // [policy setValidatesCertificateChain:NO];
       // [policy setAllowInvalidCertificates:YES];
        [manager setSecurityPolicy:policy];
        [manager POST:urlString
           parameters:parameters
constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData)
{
    
}
         
             progress:nil
              success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                  HUD.hidden =YES;
                  
                  responseData (YES,responseObject);
                  
              }
         
              failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                   responseData (NO,error);
                  HUD.hidden =YES;
                  
                  // Handle your error
              }];
        
    }
}

- (NSString*)encodeStringTo64:(NSString*)fromString
{
    NSData *plainData = [fromString dataUsingEncoding:NSUTF8StringEncoding];
    NSString *base64String;
    if ([plainData respondsToSelector:@selector(base64EncodedStringWithOptions:)]) {
        base64String = [plainData base64EncodedStringWithOptions:kNilOptions];  // iOS 7+
    } else {
        base64String = [plainData base64Encoding];                              // pre iOS7
    }
    
    return base64String;
}
-(NSString *)dataNetworkTypeFromStatusBar
{
    NSString *network;
    
    GCNetworkReachability *reachability = [GCNetworkReachability reachabilityForInternetConnection];
    
    if ([reachability isReachable])
    {
        // do stuff that requires an internet connection…
    }
    
    switch ([reachability currentReachabilityStatus])
    {
        case GCNetworkReachabilityStatusNotReachable:
        {
            network = @"no network";
        }
            break;
            
        case GCNetworkReachabilityStatusWWAN:
        {
            CTTelephonyNetworkInfo *telephonyInfo = [[CTTelephonyNetworkInfo alloc] init];
            
            NSString *currentRadio = telephonyInfo.currentRadioAccessTechnology;
            
            if ([currentRadio isEqualToString:CTRadioAccessTechnologyLTE])
            {
                // LTE
                network = @"LTE";
            }
            else if([currentRadio isEqualToString:CTRadioAccessTechnologyEdge])
            {
                // EDGE
                network = @"2G";
                
            }
            else if([currentRadio isEqualToString:CTRadioAccessTechnologyWCDMA])
            {
                // 3G
                network = @"3G";
                
            }
            else if ([currentRadio isEqualToString:CTRadioAccessTechnologyGPRS])
            {
                network = @"2G";
            }
            else
            {
                network = @"3G";
            }
            
        }
            break;
        case GCNetworkReachabilityStatusWiFi:{
            network = @"WIFI";
        }
            break;
            
        default:
            break;
    }
    
    return network;
}

-(void)cancelBeforeOperations
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager invalidateSessionCancelingTasks:YES];
}

//Calling
/*
 
 [[ACEParsing sharedWebServiceHelper]requestingServiceWithString:[NSString stringWithFormat:@"events.json?parent_id=%@&session_id=%@&calendar_view=month&calendar_year=%@&calendar_month=%@&onlydates=1",d.userId,d.sessionId,year,month] requestNumber:WS_GETCalenderEvents showProgress:YES withHandler:^(BOOL success, id data)
 {
 
 
 if (success)
 {
 
 
 }
 
 }
 
 //[calendar reset];
 [calendar markDates:calender_eventsArray];
 
 
 
 }
 else
 {
 UIAlertController * alert=   [UIAlertController
 alertControllerWithTitle:@"Alert"
 message:[NSString stringWithFormat:@"%@",[data valueForKey:@"error_message"]]
 preferredStyle:UIAlertControllerStyleAlert];
 
 UIAlertAction* ok = [UIAlertAction
 actionWithTitle:@"OK"
 style:UIAlertActionStyleDefault
 handler:^(UIAlertAction * action)
 {
 [alert dismissViewControllerAnimated:YES completion:nil];
 
 }];
 [alert addAction:ok];
 [self presentViewController:alert animated:YES completion:nil];
 }
 }
 
 
 }];
 
 
 
 
 */


@end
