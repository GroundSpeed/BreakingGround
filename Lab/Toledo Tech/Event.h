//
//  Event.h
//  Toledo Tech
//
//  Created by Don Miller on 5/16/14.
//  Copyright (c) 2014 GroundSpeed. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Event : NSObject

@property (nonatomic,retain) NSString *description;
@property (nonatomic,retain) NSString *endTime;
@property (nonatomic,retain) NSNumber *eventId;
@property (nonatomic,retain) NSString *rsvpUrl;
@property (nonatomic,retain) NSString *startTime;
@property (nonatomic,retain) NSString *title;
@property (nonatomic,retain) NSString *url;
@property (nonatomic,retain) NSString *venueDetails;

@end
