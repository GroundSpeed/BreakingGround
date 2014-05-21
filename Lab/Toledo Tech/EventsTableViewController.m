//
//  EventsTableViewController.m
//  Toledo Tech
//
//  Created by Don Miller on 5/16/14.
//  Copyright (c) 2014 GroundSpeed. All rights reserved.
//

#import "EventsTableViewController.h"
#import "Constants.h"
#import "GlobalFunctions.h"
#import "Event.h"

@interface EventsTableViewController ()
{
    NSMutableArray *arrayEventModel;
}
@end

@implementation EventsTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setNeedsStatusBarAppearanceUpdate];    
    arrayEventModel = [[NSMutableArray alloc] initWithObjects:nil];
    [self parseJSON];
}

-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [arrayEventModel count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    Event *event = arrayEventModel[indexPath.row];
    
    UILabel *lblDate = (UILabel *)[cell viewWithTag:2];
    lblDate.backgroundColor = kBlueColor;
    lblDate.textColor = kGreenColor;
    lblDate.text = [GlobalFunctions formatDateString:event.startTime];
    
    UILabel *lblTitle = (UILabel *)[cell viewWithTag:1];
    lblTitle.backgroundColor = kBlueColor;
    lblTitle.textColor = kGreenColor;
    lblTitle.text = event.title;

    tableView.backgroundColor = kBlueColor;
    tableView.separatorColor = kGreenColor;
    cell.backgroundColor = kBlueColor;
    
    return cell;
}

-(void)parseJSON
{
    NSError *error = nil;
    NSData *jsonData = [NSData dataWithContentsOfURL:[NSURL URLWithString:kEventsURL]];
    
    if (jsonData)
    {
        id jsonObjects = [NSJSONSerialization JSONObjectWithData:jsonData
                                                         options:NSJSONReadingMutableContainers
                                                           error:&error];
        
        NSArray *arrayEvents = [[NSArray alloc] initWithArray:jsonObjects];

        if (error)
        {
            NSLog(@"error is %@", [error localizedDescription]);
            
            // Handle Error and return
            return;
        }
        
        for (NSDictionary *dictEvent in arrayEvents)
        {
            Event *event = [Event alloc];
            
            event.title = [dictEvent objectForKey:@"title"];
            event.startTime = [dictEvent objectForKey:@"start_time"];
            event.description = [dictEvent objectForKey:@"description"];
            event.endTime = [dictEvent objectForKey:@"end_time"];
            event.eventId = [dictEvent objectForKey:@"id"];
            event.rsvpUrl = [dictEvent objectForKey:@"rsvp_url"];
            event.url = [dictEvent objectForKey:@"url"];
            event.venueDetails = [dictEvent objectForKey:@"venue_id"];
            
            [arrayEventModel addObject:event];
        }
    }
    else
    {
        // Handle Error
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"eventDetail"])
    {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        [_detailViewController setEvent:arrayEventModel[indexPath.row]];
        Event *event = arrayEventModel[indexPath.row];
        [[segue destinationViewController] setEvent:event];
    }
}

@end
