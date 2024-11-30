#import <Foundation/Foundation.h>
#import <AppKit/AppKit.h>
#import "TranModule.h"

@implementation TranModule
+ (NSString *)translate:(NSString *)text fromLang:(NSString *)fromLang toLang:(NSString *)toLang
{ 
  NSString *encodedString = [text stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLPathAllowedCharacterSet]];
  encodedString = [encodedString stringByReplacingOccurrencesOfString:@"/" withString:@"%2F"];
  
  NSArray *sentences = [encodedString componentsSeparatedByString: [NSString stringWithUTF8String: "\n"]];
  NSMutableString *result = [NSMutableString string];
    
  for (NSString *sentence in sentences)
    {
      NSString *trimmedSentence = [sentence stringByTrimmingCharactersInSet:
					      [NSCharacterSet whitespaceAndNewlineCharacterSet]];
      if ([trimmedSentence length] > 0)
	{
	  NSString *urlString = [NSString stringWithFormat:
						   @"https://lingva-translate-eta.vercel.app/api/v1/%@/%@/%@", 
					  fromLang,
					  toLang, 
					  [trimmedSentence stringByAddingPercentEncodingWithAllowedCharacters:
							     [NSCharacterSet URLQueryAllowedCharacterSet]]];
	  NSURL *url = [NSURL URLWithString: urlString];
            
	  if (!url)
	    {
	      NSLog(@"Некорректный URL для предложения: %@", trimmedSentence);
	      continue;
	    }

	  NSURLRequest *request = [[NSURLRequest alloc] initWithURL: url
							cachePolicy: NSURLRequestReloadIgnoringCacheData
						    timeoutInterval: 60];
            
	  NSURLResponse *response = nil;
	  NSError *error = nil;
	  NSData *data = [NSURLConnection sendSynchronousRequest: request
					       returningResponse: &response
							   error:&error];
            
	  if (error)
	    {
	      NSLog(@"Ошибка при загрузке данных: %@", [error localizedDescription]);
	      continue;
	    }
            
	  NSError *jsonError;
	  NSDictionary *json = [NSJSONSerialization JSONObjectWithData: data
							       options: 0
								 error: &jsonError];
	  if (jsonError)
	    {
	      NSLog(@"Ошибка при парсинге JSON: %@", [jsonError localizedDescription]);
	      continue;
	    }
            
	  NSString *translatedText = [json objectForKey: @"translation"];
	  if (translatedText)
	    {
	      [result appendString: translatedText];
	      [result appendString: [NSString stringWithUTF8String: "\n"]];
	    }
	}
    }

  encodedString = [[result stringByTrimmingCharactersInSet:
		   [NSCharacterSet whitespaceAndNewlineCharacterSet]]
			   stringByRemovingPercentEncoding];
  encodedString = [encodedString stringByReplacingOccurrencesOfString:@"%2F" withString:@"/"];
  return encodedString;
}
@end
