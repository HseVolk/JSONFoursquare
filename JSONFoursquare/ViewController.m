//
//  ViewController.m
//  JSONFoursquare
//
//  Created by Волк on 06.11.12.
//  Copyright (c) 2012 BI. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize jsonData;
@synthesize myTable;
@synthesize venues;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSURL *url = [NSURL URLWithString:@"https://api.foursquare.com/v2/venues/search?near=Moscow&client_id=MVHSFE0O533K0IO5DYCSGX2IN0ZNI0EN2FVVQLX5FEIR0N25&client_secret=QQTASZO3QO0MTKAWZX0QXBGLW0EOQWLMZ5TYXAQF4QZKVQV0&v=20121107"];
    
    NSURLRequest *request = [NSURLRequest requestWithURL: url]; 
    
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest: request delegate: self];
    if(connection){
        self.jsonData = [NSMutableData data];
    }
    else{
        NSLog(@"Connection failed;");
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [jsonData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"%@", error);
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    
    NSString *response = [[NSString alloc] initWithBytes:[jsonData mutableBytes] length:[jsonData length] encoding:NSUTF8StringEncoding];
    
    NSLog(@"Succeed with data %@", response);
    
    NSError *error;
        
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:response options:kNilOptions error:&error ];
    
    NSLog(@"-----------------------------%@", [dict objectForKey:@"name"]);
    
    venues = [[NSArray alloc] initWithObjects:[dict objectForKey:@"name"],nil];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return venues.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    
    cell.textLabel.text = [venues objectAtIndex:indexPath.row];
    
    return cell;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
