# CMaker Ruby Gem
A ruby gem to create C++ projects that run [Google Test](https://github.com/google/googletest) and use [CMake](https://cmake.org/) as a project model.  
This gem is an automation of [CLion's Google Test setup process](https://blog.jetbrains.com/clion/2015/10/new-clion-1-2-eap-build-brings-you-google-test/).  

## Mac Install
Run the following command in Terminal:
```
$ sudo gem install cmaker
```

## Usage
Run the following command in Terminal, substituting your project name:
```
$ cmaker makeproject [PROJECT_NAME]
```
This creates a C++ project that uses [CMake](https://cmake.org/) and [Google Test](https://github.com/google/googletest).  
If you use [CLion](https://www.jetbrains.com/clion/), you can open the created project and run the sample unit test by running the ```run[PROJECT_NAME]Tests``` configuration. 
