//
//  ViewController.m
//  S3Upload
//
//  Created by Kristopher Amiel A Reyes on 11/3/15.
//  Copyright © 2015 Kristopher Amiel A Reyes. All rights reserved.
//

#import "ViewController.h"
#import "AFAmazonS3Manager.h"
#import "AFAmazonS3ResponseSerializer.h"
#import <CommonCrypto/CommonDigest.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    [self upload];
    
}

- (void)upload{
    
    
    NSString *bucket = @"chowking.assets";
    NSString *folder = @"Users";
    AFAmazonS3Manager *s3Manager = [[AFAmazonS3Manager alloc] initWithAccessKeyID:@"AKIAIMFH3HC6IG4WZJVQ" secret:@"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"];
    s3Manager.requestSerializer.region = AFAmazonS3USWest2Region;
    s3Manager.requestSerializer.bucket = bucket;
    NSString *destinationPath = [NSString stringWithFormat:@"%@/%@.png",folder,[self namefromDate]];

    [s3Manager putObjectWithFileImage:[UIImage imageNamed:@"asdasd.png"]
                  destinationPath:destinationPath
                       parameters:nil
                         progress:^(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite) {
                             NSLog(@"%f%% Uploaded", (totalBytesWritten / (totalBytesExpectedToWrite * 1.0f) * 100));
                         }
                          success:^(AFAmazonS3ResponseObject *responseObject) {
                              NSLog(@"Upload Complete: %@", responseObject.URL);
                          }
                          failure:^(NSError *error) {
                              NSLog(@"Error: %@", error);
                          }];
}
- (NSString *)namefromDate{
    const char *str = [[NSString stringWithFormat:@"%@",[NSDate date]] UTF8String];
    unsigned char result[16];
    CC_MD5(str, strlen(str), result);
    
    return [NSString stringWithFormat:
            @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
