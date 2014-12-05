FluentNode &nbsp;&nbsp;&nbsp;[![Build Status](https://travis-ci.org/o2platform/fluentnode.svg?branch=master)](https://travis-ci.org/o2platform/fluentnode)
==========

[![NPM](https://nodei.co/npm/fluentnode.png)](https://nodei.co/npm/fluentnode/)

[![NPM](https://nodei.co/npm-dl/fluentnode.png)](https://nodei.co/npm/fluentnode/)

**FluentNode** are a set of Fluent apis for node applications (based on the concepts used in [O2 Platforms](http://blog.diniscruz.com/p/owasp-o2-platform.html) C#'s [FluentSharp](https://github.com/o2platform/FluentSharp) APIs

## Install on Node.js
```
npm install fluentnode --save
```

## FluentNode API

#### fluent-array

* **{array}.add()**
* **{array}.contains()**
* **{array}.empty()**  - true if array is empty
* **{array}.first()**  - first element of an array same as array[0]
* **{array}.forth()**  - forth element of an array same as array[3]
* **{array}.last()**
* **{array}.log)**
* **{array}.not_Contains()**
* **{array}.second()** - second element of an array same as array[1]
* **{array}.starts_With()**
* **{array}.size()**   - size  of the array
* **{array}.take()**
* **{array}.third()**  - third element of an array same as array[2]
* **{array}.unique()**


#### fluent-assert
* array
  * **{array}.assert_Is_Array()**
  * **{array}.assert_Contains()**
  * **{array}.assert_Empty()**
  * **{array}.assert_Not_Contains()**
  * **{array}.assert_Not_Empty()**
  * **{array}.assert_Size_Is()**
  * **{array}.assert_Size_Is_Bigger_Than()**
  * **{array}.assert_Size_Is_Not()**
* boolean
  * **{boolean}.assert_Is_True()**
  * **{boolean}.assert_Is_False()**
* function
  * **{function}.assert_Throws()**
  * **{function}.assert_Not_Throws()**
  * **{function}.assert_Is_Function()**
* number
  * **{number}.assert_Is()**
  * **{number}.assert_Is_Equal_To()**
  * **{number}.assert_Is_Not()**
  * **{number}.assert_Is_Not_Equal_To()**
  * **{number}.assert_Is_Number()**
* object
  * **{object}.assert_Instance_Of()**
  * **{object}.assert_Is()**
  * **{object}.assert_Is_Equal_To()**
  * **{object}.assert_Is_Instance_Of()**
  * **{object}.assert_Is_Null()**
  * **{object}.assert_Is_Not()**
  * **{object}.assert_Is_Not_Equal_To()**
  * **{object}.assert_Is_Not_Null()** 
  * **{object}.assert_Is_Object()**
  * **{object}.assert_Is_Undefined()**
  * **{object}.assert_Is_Not_Undefined()**
* string
  * **{string}.assert_Contains()**
  * **{string}.assert_Equals()**
  * **{string}.assert_Is()**
  * **{string}.assert_Is_Not()**
  * **{string}.assert_Is_Equal_To()**
  * **{string}.assert_Is_Not_Equal_To()**
  * **{string}.assert_Is_Json()**
  * **{string}.assert_Is_String()**
  * **{string}.assert_File_Exists()**
  * **{string}.assert_File_Not_Exists()**
  * **{string}.assert_Length_Is()**
  * **{string}.assert_Length_Is_Not()**
  * **{string}.assert_Not_Contains()**
  * **{string}.assert_Size_Is()**
  * **{string}.assert_Size_Is_Not()**
  * **{string}.assert_That_File_Exists()**
  * **{string}.assert_That_File_Not_Exists()**
  * **{string}.assert_That_Folder_Exists()**
  * **{string}.assert_That_Folder_Not_Exists()**
        
#### fluent-boolean
* **{boolean}.is_True()**
* **{boolean}.is_False()**

#### fluent-console
* **{object}.log()**          - log to console
* **{object}.console_log()**  - log to console

####  fluent-function
* **{function}.ctor()**
* **{function}.invoke()**
* **{function}.new()**
 
####  fluent-fs
* **{string}.exists()**            - same as {object}.fileExists()
* **{string}.is_Directory()**      - same as {string}.is_Folder()
* **{string}.is_Folder()**         - same as fs.lstatSync({string}).isDirectory()
* **{string}.is_File()**           - same as fs.lstatSync({string}).isFile()
* **{string}.file_Exists()**       - true if a file called {string} exists (same as fs.existsSync)
* **{string}.file_Not_Exists()**   - false if a file called {string} exists (same as not fs.existsSync)
* **{string}.file_Write()**
* **{string}.files_and_Folders()** - list of files and folders from folder (returns full path)
* **{string}.files()**             - list of files from folder (returns full path)
* **{string}.files_Recursive**
* **{string}.files(extension)**    - list of files from folder with extension (returns full path)
* **{string}.folders()**           - list of folders from folder (returns full path)

####  fluent-http
* **{server}.add_Sockets_Close_Suport()**
* **{server}.close_And_Destroy_Sockets()**
* **{server}.listen_OnPort_Saying()**
* **{server}.respond_With_String_As_Text()**
* **{server}.respond_With_Object_As_Json()**
* **{string}.http_Status()**
* **{string}.http_GET()**
* **{string}.GET()**
* **{string}.GET_Json()**

####  fluent-number
* **{number}.random_String()**
* **{number}.random_Letters()**
* **{number}.str()**

####  fluent-path
* **{pathA}.path.join({pathA}**   - same as path.join(pathA, pathB)
* **{pathA}.path_Combine({pathA}** - same as path.join(pathA, pathB)
* **{path}.append_To_Process_Cwd_Path** -
* **{path}.file_Parent_Folder**
* **{path}.file_Dir_Name**
* **{path}.file_Name_Without_Extension**
* **{path}.file_Name()** - extracts last part of the path (same as ***path.basename({path}***)
* **{path}.file_Names()** - extracts last part of the path (uses ***{path}.file_Name()***)
* **{string}.file_Parent_Folder**

####  fluent-object
* **{object}.call_Function({function})** calls function with current object passed the first parameter
* **{object}.json_pretty()**  - same as JSON.stringify({object}, null, ' ' )
* **{object}.json_inspect()** - same as util.inspect({object})   (handles circlar references)
* **{object}.keys()**
* **{object}.keys_All()**
* **{object}.repl_Me(onExit)**  - starts an node('repl') with the {object} object mapped as the 'that' variable (inside the repl)
* **{object}.str()**          - same as {object}.toString()

####  fluent-process_Name
* **{string}.start_Process(args...)**
* **{string}.start_Process_Redirect_Console(args...)**
* **{string}.start_Process(args..., callback)**

####  fluent-string
* **{string}.append({stringToAppend})**              - same as {string} + {stringToAppend}
* **{string}.add_5_Random_Letters()**
* **{string}.add_Random_Chars({stringToAppend})**    - adds a number of chars {stringToAppend}
* **{string}.add_Random_Letters**
* **{string}.add_Random_String({stringToAppend})**   - adds a number of letters and/or numbers to {stringToAppend}
* **{string}.add_Random_Numbers()**
* **{string}.after()**
* **{string}.after_Last()**
* **{string}.before()**
* **{string}.before_Last()**
* **{string}.contains()**
* **{string}.lower()**
* **{string}.not_Contains()**
* **{string}.size({string})**                        - same as {string}.length
* **{string}.upper()**

All methods and tests are written in CoffeScript

##Contribute

As you can see the descriptions above are not in a complete state. See [see Add method descriptions to README.md help](https://github.com/o2platform/fluentnode/issues/3) for how to help

If you want more prototype methods, please fork this repo and send a PR with  the implementation :)

##Projects using FluentNode
* TeamMentor 4.0 GraphDB - https://github.com/TeamMentor/TM_4_0_GraphDB
