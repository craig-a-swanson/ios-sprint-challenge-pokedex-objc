# Manual Reference Counting

Answer the following questions inline with this document.

1. Are there memory leaks with this code? (If so, where are the leaks?)

	```swift
	NSString *quote = @"Your work is going to fill a large part of your life, and the only way to be truly satisfied is to do what you believe is great work. And the only way to do great work is to love what you do. If you haven't found it yet, keep looking. Don't settle. As with all matters of the heart, you'll know when you find it. - Steve Jobs";

	NSCharacterSet *punctuationSet = [[NSCharacterSet punctuationCharacterSet] retain];

	NSString *cleanQuote = [[quote componentsSeparatedByCharactersInSet:punctuationSet] componentsJoinedByString:@""];
	NSArray *words = [[cleanQuote lowercaseString] componentsSeparatedByString:@" "];

	NSMutableDictionary<NSString *, NSNumber *> *wordFrequency = [[NSMutableDictionary alloc] init];

	for (NSString *word in words) {
		NSNumber *count = wordFrequency[word];
		if (count) {
			wordFrequency[word] = [NSNumber numberWithInteger:count.integerValue + 1];
		} else {
			wordFrequency[word] = [[NSNumber alloc] initWithInteger:1];
		}
	}

	printf("Word frequency: %s", wordFrequency.description.UTF8String);
	```

	2. Rewrite the code so that it does not leak any memory with ARC disabled
    ```swift
    NSString *quote = @"Your work is going to fill a large part of your life, and the only way to be truly satisfied is to do what you believe is great work. And the only way to do great work is to love what you do. If you haven't found it yet, keep looking. Don't settle. As with all matters of the heart, you'll know when you find it. - Steve Jobs";
    
    NSCharacterSet *punctuationSet = [[NSCharacterSet punctuationCharacterSet] retain];
    
    NSString *cleanQuote = [[quote componentsSeparatedByCharactersInSet:punctuationSet] componentsJoinedByString:@""];
    NSArray *words = [[cleanQuote lowercaseString] componentsSeparatedByString:@" "];
    
    NSMutableDictionary<NSString *, NSNumber *> *wordFrequency = [[[NSMutableDictionary alloc] init] autorelease];
    
    for (NSString *word in words) {
    NSNumber *count = wordFrequency[word];
    if (count) {
    wordFrequency[word] = [NSNumber numberWithInteger:count.integerValue + 1];
    } else {
    wordFrequency[word] = [[[NSNumber alloc] initWithInteger:1] autorelease];
    }
    }
    
    printf("Word frequency: %s", wordFrequency.description.UTF8String);
    
    - (void)dealloc 
    {
    [punctuationSet release];
    [super dealloc];
    }
    ```
    
    
    

2. Which of these objects is autoreleased?  Why?

	1. `NSDate *yesterday = [NSDate date];`
    YES, system takes care of it.
	
	2. `NSDate *theFuture = [[NSDate dateWithTimeIntervalSinceNow:60] retain];`
    NO, we called retain so we are responsible for it.
	
	3. `NSString *name = [[NSString alloc] initWithString:@"John Sundell"];`
    NO, uses init so we are responsible for it.
	
	4. `NSDate *food = [NSDate new];`
    NO, uses new so we are responsible for it.
	
	5. `LSIPerson *john = [[LSIPerson alloc] initWithName:name];`
    NO, usues init so we are responsible for it.
	
	6. `LSIPerson *max = [[[LSIPerson alloc] initWithName:@"Max"] autorelease];`
    YES, autorelease explicitly called.

3. Explain when you need to use the `NSAutoreleasePool`.
When you are dealing with either a large amount of temporary objects, or very large temporary objects it can make the application rapidly approach the memory high-water mark; using the NSAutoreleasePool drains the temporary objects from memory and helps make memory usage more efficient.  I common application would be in a loop that creates many objects or very large objects.


4. Implement a convenience `class` method to create a `LSIPerson` object that takes a `name` property and returns an autoreleased object.

```swift
@interface LSIPerson: NSObject

@property (nonatomic, copy) NSString *name;

- (instancetype)initWithName:(NSString *)name;

@end

@implementation LSIPerson+Convenience

- (LSIPerson)createNewPerson:(NSString *)name {
LSIPerson *newPerson = [[[LSIPerson alloc] initWithName:name] autorelease];
return newPerson;
}
```
