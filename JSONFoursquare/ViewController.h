//
//  ViewController.h
//  JSONFoursquare
//
//  Created by Волк on 06.11.12.
//  Copyright (c) 2012 BI. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableData *jsonData;
    NSArray *venues;
}

@property (nonatomic, retain) NSMutableData *jsonData;
@property (nonatomic, retain) NSArray *venues;
@property (weak, nonatomic) IBOutlet UITableView *myTable;

@end
