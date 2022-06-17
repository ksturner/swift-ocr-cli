# swift-ocr-cli

## Purpose

This is a simple swift cli app that takes an image, runs it through Apple's native
OCR (Optical Character Recognition) engine and prints the text tokens it finds
to stdout. Simple. It probably could benefit from a lot more command line
options for controlling IO. One such example of an improvement would be the
option to dump the text to a same-named file as the image with a `.txt`
extension. In this way, you could more conveniently batch up multiple images
(even if you can to invoke this cli app once per image) and associate the text
to image after all were completed.

## Background on Project

A while back I was exploring options for OCR for a set of images I had. I looked into
many of the popular open source options out there and they did ok. However, the text
recognition from my iPhone was always better.

I decided I was going to write an iOS app to utilize the built-in OCR engine of iOS
to batch process these images. Along the way, the idea came to me that if the framework
was available for iOS, there was a chance it was available on the desktop and if so,
I could make a command line app for my needs.

After a bit of digging, it turned out that all of this was possible. Here is the
result of a few different iterations of this code as it traveled from iOS, then to
a typical XCode Command Line project, until it landed here as a swift cli package.

If you're wondering what I'm referring to by `swift cli package`, it's simply a Mac
Swift project that I've initialized via the swift command line tools, like:

> $ swift package init --type executable

That command will setup a basic project structure and allow you to issue build
commands from the terminal with a simple `swift build`.

There were some nice things about this approach. There was less overhead to setup
code signing, or reconfigure the XCode project to more conveniently output the
compiled executable, etc. In the end, I love using VSCode, so this cli approach
to coding Swift cli applications allows me to use my favorite IDE to also build
Swift cli apps. Obviously there are limitations to what you can build this way,
and there are times I have to use XCode. In the meantime, this is a pleasant way
to build apps like this, or even for just learning Swift (even though there are
a number of other low barrier to entry ways to do this).

## Getting Started

You'll need to be on macOS 10.15 or higher. If so, install XCode command line tools
and then you can execute the following build command (`swift build`) and find
the built executable for your architecture. You'll notice the build output is
within a hidden folder called `.build`. Just be aware of that if you are looking
for the `.build` folder from the Finder, for example.

Example terminal output from build:

```bash
kevin|main #:~/src/ksturner/swift-ocr-cli $ swift build
Building for debugging...
[3/3] Linking swift-ocr-cli
Build complete! (0.79s)
kevin|main #:~/src/ksturner/swift-ocr-cli $ find . -iname swift-ocr-cli
./.build/arm64-apple-macosx/debug/swift-ocr-cli
./Sources/swift-ocr-cli
kevin|main #:~/src/ksturner/swift-ocr-cli $
```

The previous build command generates a debug version. When you are ready to
build a production or release build, you can issue the following build command:

> $ swift build -c release

This will produce a smaller, faster version of the executable within a release
folder under the .build folder. This file can be copied wherever you need it to
be at this point.
