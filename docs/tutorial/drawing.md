---
layout: tutorial
title: Bender tutorial
---
# Drawing application

-----
Application to be created in this tutorial : [Drawing application](../../run.html?href=docs/tutorial/draw_app/draw-view.xml)

This section describes how to create simple free hand drawing application utilizing component which is used in [DOM Event and property](canvas.html).  
The sample application will be built by compositing several components, not only canvas component but also other ui components. For more information about compositing component, please refer [External Component](external-component.html).

##Application Overview
Overview of Drawing application is as follows.
<ul class="item">
  <li>Display application title in contents area</li>
  <li>User can set color and thickness of drawing line</li>
  <li>Set line style smooth</li>
</ul>
It may seem the application does not have so much feature, but will be enough to understand basic implementation of compositing components or passing parameter between those components.


##Structure and each component
Sample application will be created by compositing several components. Description for each component is as follows.

<strong><a href="#text-box-title">text-box.xml</a></strong>
Define input text box for setting color and thickness of drawing line.

<strong><a href="#draw-title">draw.xml</a></strong>
Define draw component. This component is based on the drawing component used in previous section. Some properties and operations are added for handling color and thickness of drawing line.

<strong><a href="#draw-view-title">draw-view.xml</a></strong>
Define layout of contents area.
This component defines layout of each components compositing draw component("draw.xml") and text box component("text-box.xml"). This component also handles passing values between components("draw component" and "text box component").

<strong>draw.css</strong>
The style sheet for drawing application. Since there is no difference from the CSS in previous section, description is not provided here.

Main component of this application is defined in "draw-view.xml".
The "draw-view.xml" composits "draw.xml" and "text-box.xml" internally.
Compositing manner is the same as the use of external component. This sample application composit your created components (not component provided by Bender). 
However, you do not have to be particulary aware of it at this moment.

<h2 id="text-box-title">text-box</h2>

<blockquote class="code" id="text-box">
</blockquote>
<script src="../../flexo.js">
</script>
<script>
flexo.ez_xhr("draw_app/text-box.xml", { responseType: "text"}, function (req) {
  document.querySelector("#text-box").appendChild(flexo.$pre(req.response));
});
</script>

Layout input text box. When the value in the input text box has updated, set the value to the "value" property.  
This component is used in "draw-view".


<h2 id="draw-title">draw</h2>

<blockquote class="code" id="draw">
</blockquote>
<script src="../../flexo.js">
</script>
<script>
flexo.ez_xhr("draw_app/draw.xml", { responseType: "text"}, function (req) {
  document.querySelector("#draw").appendChild(flexo.$pre(req.response));
});
</script>

<property name="context" as="dynamic"
  value="this.views.$root.getContext('2d')" />
<property name="width" as="number" />
<property name="height" as="number" />
<property name="down" as="boolean" value="false" />
<property name="size" as="number" />
<property name="color" />
<property name="linejoin" value="round" />
<property name="linecap" value="round" />

Some properties, "width", "height", "size", "color" and "linestyle" are added to the draw component in the previous section.  
The "width" and "height" are added to be set the size of canvas from other component.  
The "size" is a property to set line thickness, and the "color" is a property to set line color.  
The "linejoin" and "linecap" are properties to set line style.  
Since the value of "width", "height", "size" should be treated as type of number, "number" is set to "as" for each.

The watch operations should be added with the "watch" element for each added property.

	<watch>
	  <get instance="$self" property="color">
	    <this.properties.context.strokeStyle = value;
	  </get>
	</watch>
When the "color" property has updated, set the "value" to strokeStyle of canvas context.  
The "value" is set in the form of color code.

	<watch>
	  <get instance="$self" property="size">
	    this.properties.context.lineWidth = value;
	  </get>
	</watch>
When the "size" property has updated, set the "value" to lineWidth.  
The "value" is set in the form of number.

"linejoin" and "linecap" are also set to the canvas context with the "watch" element.
However, these properties will not be updated. (Appropriate solution for loading process will be described separately)

Though the operation for mouse event does not have so much difference from the previous section, "get" elements(touchstart, touchmove, touchend) are added to support touch event.


<h2 id="draw-view-title">draw-view</h2>


<blockquote class="code" id="draw-view">
</blockquote>
<script src="../../flexo.js">
</script>
<script>
flexo.ez_xhr("draw_app/draw-view.xml", { responseType: "text"}, function (req) {
  document.querySelector("#draw-view").appendChild(flexo.$pre(req.response));
});
</script>

As properties, "color" and "size" which are used in draw-view component are defined.

Application layout is defined in the "view" element utilizing external components.  
Title, label + input text box(for setting color and thickness of drawing line) and drawing area are layouted.
Since each component uses html element, description format is the same as HTML. 

This component have an operation to pass the value of input text box component to drawing component.

	<watch>
	  <get instance="color" property="value"/>
	  <set instance="draw" property="color"/>
	</watch>
Set component id(loaded in the "view" element) to "instance". So the "get" element will get the "value" property of the component which has the "color" as id.   
Then, the "set" element pass the value obtained by the "get" element to the "color" property of the component which has the "draw" as id.  
Same operation is added for the "size" property.

As you can see from the above description, drawing application is build up by compositing 3 components.  
Moreover, you can create other UI component and customize at will.


##Execution
When each component is ready, try it with "run.html" as before.


That is all for Basics tutorial of Bender application.
For the next step, [Detail of component]() and [Customize Runtime]() will be described in Advanced topics section.











