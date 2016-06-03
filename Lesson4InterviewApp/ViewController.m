//
//  ViewController.m
//  Lesson4InterviewApp
//
//  Created by Frederik Nygaard on 02.06.16.
//  Copyright (c) 2016 Frederik Nygaard. All rights reserved.
//

#import "ViewController.h"
#define KEY_SEGMENTED_CONTROL @"KeySegCtrl"
#define KEY_TEXT_FIELD @"KeyTextField"
#define KEY_SLIDER @"KeySlider"
#define KEY_SWITCH @"KeySwitch"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UISegmentedControl *mySegmentControl;
@property (weak, nonatomic) IBOutlet UITextField *myTextField;
@property (weak, nonatomic) IBOutlet UISlider *mySlider;
@property (weak, nonatomic) IBOutlet UISwitch *mySwitch;
@property (weak, nonatomic) IBOutlet UITextView *myTextView;

@end



@implementation ViewController

-(NSString *)pathname {
    return [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/myfile.txt"];
}

- (IBAction)doSaveTextToFile:(id)sender {
    NSError *error = nil;
    
    [self.myTextView.text writeToFile:[self pathname] atomically:YES encoding:NSUTF8StringEncoding  error:&error];
    
    if (error) {
        self.myTextView.text = [error localizedDescription];
    }
    else{
        self.myTextView.text = @"Data written";
    }

    
    
}
- (IBAction)doReadTextFromFile:(id)sender {
    NSError *error = nil;
    NSString *s = [NSString stringWithContentsOfFile:[self pathname] encoding:NSUTF8StringEncoding error:&error];
    if(error ) {
        self.myTextView.text = [error localizedDescription];
    }
    else  {
        self.myTextView.text = s;

    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.mySegmentControl.selectedSegmentIndex = [[NSUserDefaults standardUserDefaults] integerForKey:KEY_SEGMENTED_CONTROL];
    self.myTextField.text = [[NSUserDefaults standardUserDefaults] stringForKey:KEY_TEXT_FIELD];
    self.mySlider.value = [[NSUserDefaults standardUserDefaults]floatForKey:KEY_SLIDER];
    self.mySwitch.on = [[NSUserDefaults standardUserDefaults]boolForKey:KEY_SWITCH];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(saveValues:) name:UIApplicationDidEnterBackgroundNotification object:nil];
    
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"readme" withExtension:@"txt"];
    
    NSError *error = nil;
    self.myTextView.text = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:&error];
    
    if (error){
        self.myTextView.text = [error localizedDescription];
    }
    
}
-(void)saveValues:(NSNotification *)notification {
    [[NSUserDefaults standardUserDefaults] setInteger:self.mySegmentControl.selectedSegmentIndex forKey:KEY_SEGMENTED_CONTROL];
    [[NSUserDefaults standardUserDefaults]setObject:self.myTextField.text forKey:KEY_TEXT_FIELD];
    [[NSUserDefaults standardUserDefaults]setFloat:self.mySlider.value forKey:KEY_SLIDER];
    [[NSUserDefaults standardUserDefaults]setBool:self.mySwitch.on forKey:KEY_SWITCH];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
