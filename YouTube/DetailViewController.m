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

    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
        self.edgesForExtendedLayout = UIRectEdgeNone;

    NSString *videoURL = @"http://www.youtube.com/v/Lv-sY_z8MNs";
    NSString *videoHTML = [NSString stringWithFormat:@"\
                           <html><body>\
                           <embed src=\"%@\" type=\"application/x-shockwave-flash\" wmode=\"transparent\" width=\"310\" height=\"180\">\
                           </embed>\
                           </body></html>", videoURL];
    
    UIWebView *webView = [[UIWebView alloc] initWithFrame: self.view.frame];
    [webView loadHTMLString: videoHTML baseURL: nil];
    [self.view addSubview: webView];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
