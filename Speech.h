@interface Speech : NSObject
{
  NSTask *_task;
}
- (NSTask *) _task;
- (void) _setTask: (NSTask *) task;
- (void) waitForTaskCompletion: (id) sender;
+ (void) playSpeech: (id) sender text: (NSString *)text;
@end
