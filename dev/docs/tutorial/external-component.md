---
layout: tutorial
title: Bender Tutorial 
---
# Use external components

-----
Application to be created in this tutorial : [Display alert by pressing button](../../dom/runtime.html?href=../docs/tutorial/welcome.xml)

The written code of "Hello World" in previous section is also one component. 
With Bender framework, it is possible to create large application compositing multiple small components.

In this section, the sample application uses a component created in another file.
The sample application uses Button component provided by Bender.


<blockquote class="code">
</blockquote>
<script>
flexo.ez_xhr("welcome.xml", { responseType: "text" }, function (req) {
  document.querySelector("blockquote").appendChild(flexo.$pre(req.response));
});
</script>


Execution manner is the same as the sample in the previous section (Hello World).
Save the above code as "welcome.xml", and run with "runtime.html".
A label "Welcome to Bender!" and blue button with string "Thanks" should be displayed.
When click the button, alert dialog sould be diplayed.
<br>
<br>

In addition to the Button component, Bender provides some controls as components.
We are planning to provide more libraries to use with Bender in the future.
<br>
<br>

     <component id="thanks-button" href="../../dom/lib/button.xml">
       <view>
         Thanks
       </view>
     </component>

In the above code, "button.xml" is an XML file which Button component is defined.
By setting external component file to href of the component element, the component is set in the target document.
<br>
<br>

In the sample code, "view" and "watch" elements are defined in the "component" element.  
The "view" element, which was also used in the previous section, defines contents to display. It includes layout and content information of the document described in HTML or SVG.

The "watch" element watches instances or objects which were defined in the "view" element.  
The "watch" element has "get" and "set" element as child elements.  
In this section, we describe about "get" element. About the use of "set" element will be described in the following section.  
<br>
<br>

     <get component="thanks-button" event="!pushed">

The "get" element, which is used in our sample code, can define event handling process of instance specified by the "instance" when event specified by the "event" had occured.
In the above sample, it is defined to display an alert dialog if !pushed event had occured in thanks-button(Button).

<!---
For further information about each element and event type, please refer <a href="../reference/reference.html">API Reference</a>. 
--->


