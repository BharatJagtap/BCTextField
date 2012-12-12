//
//  SecondViewController.h
//  CustomTextField
//
//  Created by Bitcode Technologies on 09/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BCTextField.h"

@interface SecondViewController : UIViewController <BCTextFieldDelegate>
@property (weak, nonatomic) IBOutlet BCTextField *text1;
@property (weak, nonatomic) IBOutlet BCTextField *text2;
@property (weak, nonatomic) IBOutlet BCTextField *text3;
@end
