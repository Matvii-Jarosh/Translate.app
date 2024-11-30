#import <Foundation/Foundation.h>
#import <AppKit/AppKit.h>
#import "Speech.h"

@implementation Speech
- (NSTask *) _task
{
  return _task;
}

- (void) _setTask: (NSTask *) task
{
  if (_task != task)
    {
      [_task release];
      _task = [task retain]; 
    }
}

+ (void) playSpeech: (id) sender text: (NSString *) text
{
  Speech *speechInstance = [[Speech alloc] init];

  NSString *espeakCommand = [NSString stringWithFormat:@"espeak \"%@\"", text];
  NSTask *task = [[NSTask alloc] init];
  [task setLaunchPath:@"/bin/sh"];
  [task setArguments: [[NSArray alloc] initWithObjects: @"-c", espeakCommand, nil]];

  [speechInstance _setTask:task];
  [task launch];
  [task release]; 

  [NSThread detachNewThreadSelector:@selector(waitForTaskCompletion:) 
			   toTarget:speechInstance 
			 withObject:sender];

  [speechInstance release]; 
}

- (void) waitForTaskCompletion: (id) sender
{
  ENTER_POOL;

  [_task waitUntilExit];
  
  LEAVE_POOL;
}

- (void) dealloc
{
  [self _setTask:nil]; 
  [super dealloc];
}

@end
