//
//  SecondViewController.m
//  CustomTextField
//
//  Created by Bitcode Technologies on 09/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()

@end

@implementation SecondViewController
@synthesize text1;
@synthesize text2;
@synthesize text3;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
     
        
        self.title = @"IB";

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    text1.bcDelegate = self;
    
    text2.type = BCTextFieldTypePicker;
    text2.items = [NSArray arrayWithObjects:@"Red",@"Green",@"Blue",@"Black",@"White", nil];
    text2.bcDelegate = self;
    
    text3.type = BCTextFieldTypeDatePicker;
    text3.datePickerMode = UIDatePickerModeDateAndTime; 
    text3.bcDelegate = self;
    
    // Do any additional setup after loading the view from its nib.
}

-(void)next:(BCTextField *)textField
{
    if(textField == text1)
    {
        [text2 becomeFirstResponder];
    }
    else if(textField == text2)
    {
        [text3 becomeFirstResponder];
    }
}
-(void)previous:(BCTextField *)textField
{
    if(textField == text2)
    {
        [text1 becomeFirstResponder];
    }
    else if(textField == text3)
    {
        [text2 becomeFirstResponder];
    }
}


- (void)viewDidUnload
{
    [self setText1:nil];
    [self setText2:nil];
    [self setText3:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
