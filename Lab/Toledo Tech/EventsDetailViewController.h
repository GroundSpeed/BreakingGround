//
//  EventsDetailViewController.h
//  Toledo Tech
//
//  Created by Don Miller on 5/16/14.
//  Copyright (c) 2014 GroundSpeed. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Event.h"
#import "GlobalFunctions.h"

@interface EventsDetailViewController : UIViewController

@property (strong, nonatomic) IBOutlet UILabel *lblTitle;
@property (strong, nonatomic) IBOutlet UILabel *lblStartDate;
@property (strong, nonatomic) IBOutlet UILabel *lblEndDate;
@property (strong, nonatomic) IBOutlet UITextView *txtDescription;

@property (strong, nonatomic) IBOutlet UIView *vuDetailView;
@property (strong, nonatomic) IBOutlet UIButton *btnClose;
@property (strong, nonatomic) IBOutlet UILabel *lblHdrStartDate;
@property (strong, nonatomic) IBOutlet UILabel *lblHdrEndDate;

@property (nonatomic, strong) Event *event;

-(IBAction)btnClose:(id)sender;

@end
