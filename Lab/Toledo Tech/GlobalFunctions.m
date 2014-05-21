//
//  GlobalFunctions.m
//  Toledo Tech
//
//  Created by Don Miller on 5/16/14.
//  Copyright (c) 2014 GroundSpeed. All rights reserved.
//

#import "GlobalFunctions.h"

@implementation GlobalFunctions

+ (NSString *)formatDateString:(NSString *)dateWithInitialFormat
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZZZZZ"];
    NSDate *date = [dateFormatter dateFromString:dateWithInitialFormat];
    
    [dateFormatter setDateFormat:@"MM/dd/yyyy  EEEE  hh:mm a"];
    NSString *dateWithNewFormat = [dateFormatter stringFromDate:date];
    return dateWithNewFormat;
}

@end
