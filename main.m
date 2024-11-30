#import <Foundation/Foundation.h>
#import <AppKit/AppKit.h>
#import "TranFace.h"

int main (void)
{ 
  ENTER_POOL;
  TranFace *face;
  NSApplication *app;

  app = [NSApplication sharedApplication];
  face = [TranFace new]; 
  [app setDelegate: face];
  
  [app run];
  LEAVE_POOL;
  return 0;
}
