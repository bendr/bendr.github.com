---
layout: tutorial
title: DOM event and property
---
#DOM event and property

-----
Application to be created in this tutorial : [Free hand drawing(mouse event only)](../../run.html?href=docs/tutorial/canvas_and_property/draw.xml)

This section describes how to use DOM event and property using CANVAS as an example.

CANVAS is the HTML5 specification to draw figures on Browser.
It has become possible to draw figures in JavaScript thanks to this specification.

Please refer to HTML5 specification for further information about CANVAS.
This tutorial describes only layout of CANVAS and how to implement free hand drawing with mouse events.

## Sample Code

Source code is as follows:

<blockquote class="code" id="draw-xml">
</blockquote>
<script src="../../flexo.js">
</script>
<script>
flexo.ez_xhr("canvas_and_property/draw.xml", { responseType: "text"}, function (req) {
  document.querySelector("#draw-xml").appendChild(flexo.$pre(req.response));
});
</script>

## Style Sheet
The code for "draw.css" is as follows:  
It displays frame border for easy to find the position and size of CANVAS.

<blockquote class="code" id="draw-css">
</blockquote>
<script src="../../flexo.js">
</script>
<script>
flexo.ez_xhr("canvas_and_property/draw.css", {responseType: "text"}, function (req){
  document.querySelector("#draw-css").appendChild(flexo.$pre(req.response));
});
</script>

## Source Code Description
Explanation of sample code in order.

     <link rel="stylesheet" href="draw.css" />
Load style sheet.
Description format is the same as normal link element.
If you load multiple style sheets, those are loaded in order from the bottom.(maybe change...)
<br>
<br>
<br>

    <property name="context" as="dynamic"
        value="this.views.$root.getContext('2d')" />
    <property name="down" as="boolean" value="false" />

This "property" element is the element to define properties which the component have.

The first property defines "context" property. Set 2D context object obtained by DOM method of CANVAS, getContext('2d'), to the "value" as an initial value.  
The second property defines "down" property.
This property is used to judge whether execute drawing or not. Set false to the "value" as an initial value because drawing should not be executed before user operation. 
<br>
<br>
<br> 

Define canvas as a HTML element in the "view" element. The "width" and the "height" define size of CANVAS.
<br>
<br>
<br>

    <get view="$root" dom-event="mousedown" />
    <set instance="$self" property="down">
      value.preventDefault();
      this.properties.context.beginPath();
      var p = flexo.event_offset_pos(value, this.views.$root);
      this.properties.context.moveTo(p.x, p.y);
      return true;
    </set>

For explanation of the mouse event handling, "mousedown" event is used as an example.

"$root", specified in the "view" of the "get" element, means the first element defined in the "view" element ("canvas" in this case).  
Set DOM event which should be handled in the target element to "dom-event" ("mousedown" in this case).  
Now it is possible to get an event that the mouse button is pressed on canvas.

When the "set" element return a value, the returned value is set to property ("down" in this case) of the specified component ("$self" represent the component itself).  
It is also possible to write event handling operation for "mousedown" event here.  
Whether event handling operation should be written in the "get" element or in the "set" element, can be considered based on the necessity of setting operation.  
The attributes, "view" and "instance", can be used in both "get" and "set" element. The "view" is used to specify element, and the "instance" is used to specify component.
<br>
<br>
<br>

##DOM event

3 DOM events (mousedown / mouseup / mousemove) are used in this sample.

mousedown:event occurs when mouse button is pressed  
mouseup:event occurs when mouse button is depressed  
mousemove:event occurs when mouse pointer is moved  

It is necessary to watch each DOM event by using the "watch" elements.
The operations for each event are as follows:

<strong>mousedown</strong>
<ul class="item">
<li>Prevent default event behavior(preventDefault())</li>
<li>Reset current path(beginPath())</li>
<li>Adjust position of mouse cursor(flexo.event_offset_pos())</li>
<li>Create new sub path on specified position(moveTo())</li>
<li>Set draw flag ON</li>
</ul>


<strong>mousemove</strong>
<ul class="item">
<li>In case draw flag was ON</li>
<li>Adjust position of mouse cursor(flexo.event_offset_pos())</li>
<li>Add specified position to current path, and connect previous position with straight line(lineTo())</li>
<li>Draw line to sub path with current stroke-style(stroke())</li>
<li>Return flag as is</li>
<li>In case draw flag was OFF</li>
<li>Return flag as is</li>
</ul>


<strong>mouseup</strong>
<ul class="item">
<li>Set draw flag OFF</li>
</ul>
<br>
<br>

##Execution
Save sample source code as "draw.xml" and style sheet as "draw.css".  
As before, run it with your browser using "run.html".  
Drawing area with border frame should be displayed and should be able to draw on canvas with mouse.

