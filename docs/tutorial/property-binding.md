---
layout: tutorial
title: Bender Tutorial
---
# Property Binding

-----
In this tutorial, a [simple application that counts up and down by clicking
buttons](../../dom/runtime.html?href=../dom/test/sample.xml) is created.

The complete source code is as follows:

<blockquote class="code">
</blockquote>
<script>
flexo.ez_xhr("../../dom/test/sample.xml", { responseType: "text" }, function (req) {
  document.querySelector("blockquote").appendChild(flexo.$pre(req.response));
});
</script>

##Properties of components

Bender components can have properties to manage their state.
A Bender property is similar to a Javascript object property, but has the
additional benefit of being observable with a watch element so that changes can
be triggered whenever the value of a property changes.

In this example, the main component has a <tt>count</tt> that maintains a count
that can go up and down by using two buttons.
The count is also displayed using roman numerals, using another property called
<tt>roman</tt>.

A property is defined by adding a <tt>property</tt> child element to the
<tt>component</tt> element, such as:

	<property name="count" as="number" value="0"/>

The <tt>name</tt> attribute is mandatory and defines the name of the property.
The <tt>value</tt> attribute defines a value for the property; here, the count
will start at zero.
Because attributes in XML are always text strings, the <tt>as</tt> attribute can
give more information about how to interpret the value. Here, the count should
be interpreted as a Javascript number and not a text string. Other values for
<tt>as</tt> are <tt>string</tt>, <tt>boolean</tt> (a Javascript boolean value,
which can be <tt>true</tt> or <tt>false</tt>), <tt>json</tt> (a Javascript
boolean using JSON notation) and <tt>dynamic</tt> (a Javascript expression; this
is the default.)

##Making the count go up and down

The two buttons <tt>button-plus</tt> and <tt>button-minus</tt> will increase or
decrease the count.
In the same manner as in [External Component](external-component.html), a watch
is used to get <tt>pushed</tt> events from the buttons and modify the value of
the <tt>count</tt> property accordingly:

	<watch>
	  <get component="button-plus" event="!pushed"/>
	  <set property="count" value="this.properties.count + 1"/>
	</watch>

The <tt>set</tt> element sets the <tt>value</tt> (which is similar to a property
value) to the specified target (the <tt>count</tt> property in this sample.)
The value is a Javascript expression in which <tt>this</tt> refers to the
current component. <tt>this.properties</tt> is a dictionary of the properties of
the component, so <tt>this.properties.count</tt> refers to the <tt>count</tt>
property of the component.

##Converting the count to a roman number

A second property, called <tt>roman</tt>, is defined as follows:

	<property name="roman" value="flexo.to_roman(`count).toUpperCase()"/>

Notice that the value of this property is a Javascript expression, with one
difference: the character <tt>&#x60;</tt> is used to refer to other properties
of the component. This has two effects:

<ol>
	<li>it is a shortcut to writing <tt>this.properties.count</tt>;</li>
	<li>it creates a watch to make sure that the value of <tt>roman</tt> is updated
  every time the value of <tt>count</tt> changes (for instance, when one of
  the buttons is pushed.)</li>
</ol>

This is called a property binding, as the the <tt>roman</tt> property is now
bound to the <tt>count</tt> property.

The end result of this property definition is that every time <tt>count</tt> is
set to a new number value, <tt>roman</tt> is set to its representation in roman
numerals using the library function <tt>to_roman()</tt> of Flexo, and then
converted to upper case.

##Displaying the count value

The last step is now to display the value of the <tt>roman</tt> property in the
view of the component.
In Bender this can be done by creating a text element in the view, then setting
up a watch so that when the <tt>roman</tt> property changes, the text element is
updated with the new value.
With a text binding, this can be done easily, as shown below:

	<view xmlns:html="http://www.w3.org/1999/xhtml">
	  <html:p>
	    Number of clicks: `roman
	   </html:p>
	 </view>

Once again, notice the <tt>&#x60;</tt> character that introduces the
<tt>roman</tt> property.

##Binding from other components

In this applications, only positive numbers are shown.
This means that when the count is zero, it cannot go down any further, and the
minus button needs to be disabled.
Standard buttons in Bender have an <tt>enabled</tt> property, which is a
boolean.
To disable a button, this property is set to false; to enable a button, this
property is set to true.

To prevent the count from going below zero, the <tt>enabled</tt> property of the
minus button is bound to the <tt>count</tt> property of the main component:

	 <component href="../lib/button.xml" id="button-minus" class="red">
	   <property name="enabled" value="#sample`count &gt; 0"/>
	   <view>
	     -1
	   </view>
	 </component>

The <tt>enabled</tt> property of the minus button shows a more complex binding,
as it is not bound to a property of its own, but of another component (here, the
main component, which has the id <tt>sample</tt>.)
When the property of a different component is referred to, the property name
(including the backtick character) is preceded by the component id, itself
introduced by the <tt>#</tt> mark.
