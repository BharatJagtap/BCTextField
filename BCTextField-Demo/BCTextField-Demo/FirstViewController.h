//
//  ViewController.h
//  CustomTextField
//
//  Created by Bitcode Macmini 2 on 06/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BCTextField.h"
@interface FirstViewController : UIViewController <BCTextFieldDelegate>
{
    BCTextField * text1;
    BCTextField * text2;
    BCTextField * text3;
}
@end
