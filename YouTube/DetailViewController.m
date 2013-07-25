//
//  DetailViewController.m
//  YouTube
//
//  Created by Ryo Suzuki on 7/19/13.
//  Copyright (c) 2013 Ryo Suzuki. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()
@end

@implementation DetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSLog(@"%@", self.url);

    NSString *videoURL = self.url;
    NSString *videoHTML = [NSString stringWithFormat:@"\
                           <html><body>\
                           <embed src=\"%@\" type=\"application/x-shockwave-flash\" wmode=\"transparent\" width=\"310\" height=\"180\">\
                           </embed>\
                           </body></html>", videoURL];
    
    UIWebView* webView = [[UIWebView alloc] initWithFrame: CGRectMake(0, 0, 310, 180)];
    [webView loadHTMLString: videoHTML baseURL: nil];
    [self.view addSubview: webView];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
