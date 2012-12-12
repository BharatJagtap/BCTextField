//
//  ViewController.m
//  CustomTextField
//
//  Created by Bitcode Macmini 2 on 06/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FirstViewController.h"

@implementation FirstViewController

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Programatically";
    
    /* Normal text field */

    text1 = [[BCTextField alloc]init];
    text1.borderStyle = UITextBorderStyleRoundedRect;
    text1.frame = CGRectMake(10, 50, 300, 30);
    text1.bcDelegate = self; // setting the bcDelegate will allow you to handle next and previous button action on the keyboard
    
    [self.view addSubview:text1];
    
    
     /* Picker text field */   
    
    text2 = [[BCTextField alloc]init];
    text2.borderStyle = UITextBorderStyleRoundedRect;
    text2.frame = CGRectMake(10, 100, 300, 30);
    text2.bcDelegate = self;
    text2.type = BCTextFieldTypePicker;
    text2.items = [NSArray arrayWithObjects:@"Red",@"Green",@"Blue",@"Black",@"White", nil];
    text2.placeholder = @"Color"; // placeholder text will appear as a poover title on iPad
    
    [self.view addSubview:text2];
    
    
    
    /* Date Picker text field */
    
    text3 = [[BCTextField alloc]init];
    text3.borderStyle = UITextBorderStyleRoundedRect;
    text3.frame = CGRectMake(10, 150, 300, 30);
    text3.bcDelegate = self;
    text3.type = BCTextFieldTypeDatePicker;
    
    // setting the datePickerMode
    text3.datePickerMode = UIDatePickerModeDateAndTime;    
    
    
    // You can even set the dateformatter . the text displayed in the text field after selecting the date would be formatted using this date formatter object. ( Optional )
    NSDateFormatter * dtFormatter = [[NSDateFormatter alloc]init];
    [dtFormatter setDateFormat:@"dd-MM-yyyy"];
    text3.dateFormatter = dtFormatter;
    [self.view addSubview:text3];

    
    // When you are submitting the form , you can access the actual date object by accessing date property on the text field
    // NSDate * date = text3.date;
       
    

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
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

@end
