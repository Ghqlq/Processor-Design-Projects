## Make Note
**cmake Version:** 4.1.1

**command:** make help
* hello_world - creates executable file
* hello.o - [unsure]
* hello.i - [unsure]
* hello.s - builds .s file (assembly)
* all - builds .cpp all files
* clean - deletes all build files

## Answer the following
1. The paths used by target_sources and target_include_directories are relative, not absolute. What file or folder are they relative to?
    - They are relative to the project directory that contains the CMakeLists.txt file.

2. What are some differences between cmake and ninja?
    - cmake: creates build files 
    - ninja: executes build files

3. Why is it important to run cmake in its own directory?
    - cmake generates a lot of files -> makes project directory messy