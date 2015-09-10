// This file is part of the Corinthia project (http://corinthia.io).
//
// See the COPYRIGHT.txt file distributed with this work for
// information regarding copyright ownership.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

// This file comes from the portion of the UX Write editor that
// works on both Apple platforms (that is, it can run on either
// OS X or iOS). It's in the repository for illustrative purposes
// only, to assist with the creation of the framework for the
// Corinthia editor UI. The code does not compile independently in
// its present form.

#import <FileClient/FCOperation.h>

@class EDEditor;

typedef void (^EDSaveCompletion)(BOOL cancelled, NSError *error);

////////////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                                //
//                                         EDSaveOperation                                        //
//                                                                                                //
////////////////////////////////////////////////////////////////////////////////////////////////////

@interface EDSaveOperation : FCOperation

@property (assign, readonly) NSUInteger completionCount;

- (EDSaveOperation *)initWithEditor:(EDEditor *)editor path:(NSString *)path;
- (void)addCompletion:(EDSaveCompletion)completion;

@end
