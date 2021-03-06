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

#import "EDHTMLTidy.h"
#import "EDEditor.h"
#import "EDUtil.h"

////////////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                                //
//                                           EDHTMLTidy                                           //
//                                                                                                //
////////////////////////////////////////////////////////////////////////////////////////////////////

@implementation EDHTMLTidy

+ (void)tidy:(NSData *)input isXHTML:(BOOL)isXHTML editor:(EDEditor *)editor
  completion:(void (^)(NSData *output, NSError *error))completion
{
    __block NSData *output = nil;
    __block NSError *error = nil;
    [editor.system runInBackground: ^{
        DFError *dferr = NULL;
        DFBuffer *inbuf = DFBufferNew();
        DFBuffer *outbuf = DFBufferNew();
        DFBufferAppendData(inbuf,input.bytes,input.length);
        if (!DFHTMLTidy(inbuf,outbuf,isXHTML,&dferr))
            DFErrorReleaseToNSError(dferr,&error);
        else
            output = [NSData dataWithBytes: outbuf->data length: outbuf->len];
        DFBufferRelease(inbuf);
        DFBufferRelease(outbuf);
    } completion:^{
        completion(output,error);
    }];
}

@end
