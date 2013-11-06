//
//  KNSecondViewController.h
//  Kanobu
//
//  Created by Admin on 01.11.13.
//  Copyright (c) 2013 Denis Zamataev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KNLoginViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITextField *loginTextField;
@property (strong, nonatomic) IBOutlet UITextField *passwordTextField;
@property (strong, nonatomic) IBOutlet UILabel *loginResultLabel;
- (IBAction)login:(id)sender;

@end
