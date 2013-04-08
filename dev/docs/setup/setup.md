---
layout: setup
title: Bender Environement Setup
---
#Setting up the Bender application development environment.

-----

Follow these steps to create a Bender application development environment.

##1. Download Bender

[Download Bender version 0.8](https://github.com/bendr/bender/archive/v0.8.zip) and unzip it into any directory.

<br>
##2. Prepare a Web server (optional)
Since the Bender runtime uses XMLHttpRequest to load components and resources,
you may want to serve the Bender runtime and components through a Web server.
If you have already installed and set up a Web server, you only have to make
sure the Bender directory setup in step 1 above is accessible.

<br>
##3. Install a RelaxNG validator (optional)

Bender components are saved as XML and their syntax can be checked against a
Relax NG grammar found in `spec/bender.rng`. You may want to install a Relax NG
validator such as [Jing](http://www.thaiopensource.com/relaxng/jing.html) to
validate your content.

<br>
After you have completed the setup above, you can check that Bender is running
by visiting the URL
[dev/dom/runtime.svg?href=test/logo.xml](../../dom/runtime.svg?href=test/logo.xml)
in your browser (the URL should be prefixed by the location where Bender was
installed.) The Bender logo should appear. Your next step is to go to the
[tutorial page](../tutorial/tutorial.html), which will get your started with Web
application development with Bender.
