//
//  MasterViewController.m
//  YouTube
//
//  Created by Ryo Suzuki on 7/19/13.
//  Copyright (c) 2013 Ryo Suzuki. All rights reserved.
//

#import "MasterViewController.h"

#import "DetailViewController.h"
#import "ContentView.h"

@interface MasterViewController () {
    NSMutableArray *videos;
    NSMutableData *data;
}
@end

@implementation MasterViewController

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.separatorColor = [UIColor clearColor];
    self.tableView.backgroundColor = [UIColor colorWithWhite:0.8 alpha:1];
    
    NSURL *url = [[NSURL alloc] initWithString:@"http://gdata.youtube.com/feeds/api/videos?author=google&alt=json"];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    [NSURLConnection connectionWithRequest:request delegate:self];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    data = [[NSMutableData alloc] initWithData:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)_data
{
	[data appendData:_data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSString *jsonString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSData *jsonData = [jsonString dataUsingEncoding:NSUnicodeStringEncoding];
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:jsonData options: NSJSONReadingAllowFragments error:nil];
    
    NSDictionary *feed = [[NSDictionary alloc] initWithDictionary:[dict valueForKey:@"feed"]];
    videos = [NSMutableArray arrayWithArray:[feed valueForKey:@"entry"]];
    [self.tableView reloadData];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return videos.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath
{
    return 110;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    ContentView *contentView = [[ContentView alloc] init ];
    contentView.frame = CGRectMake(10, 10, cell.frame.size.width - 20, cell.frame.size.height - 20);
    NSDictionary *video = videos[indexPath.row];
    NSString *title = [video valueForKeyPath:@"title.$t"];
    contentView.textLabel.text = title;
    
    NSArray *thumbnails = [video valueForKeyPath:@"media$group.media$thumbnail"];
    NSString *thumbnailImage = [thumbnails[0] valueForKeyPath:@"url"];
    NSURL *url = [[NSURL alloc] initWithString:thumbnailImage];
    
    NSData *imageData = [[NSData alloc] initWithContentsOfURL:url];
    contentView.imageView.image = [[UIImage alloc] initWithData:imageData];
    
    [cell.contentView addSubview:contentView];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];

    NSDictionary *video = videos[indexPath.row];
    NSDictionary *media = [video valueForKey:@"media$group"];
    NSArray *contents = [media valueForKey:@"media$content"];
    NSDictionary *content = contents[0];
    NSString *url = [content valueForKey:@"url"];

    DetailViewController *detailViewController = [segue destinationViewController];
    detailViewController.url = url;
}

@end
