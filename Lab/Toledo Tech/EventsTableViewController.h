//
//  EventsTableViewController.h
//  Toledo Tech
//
//  Created by Don Miller on 5/16/14.
//  Copyright (c) 2014 GroundSpeed. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EventsDetailViewController.h"

@interface EventsTableViewController : UITableViewController

@property (nonatomic, strong) EventsDetailViewController *detailViewController;

@end
