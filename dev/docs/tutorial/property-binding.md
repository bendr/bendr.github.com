---
layout: tutorial
title: Bender Tutorial
---
# Property Binding

-----
Application to be created by this tutorial : [Count up by clicking button](../../dom/runtime.html?href=../dom/test/sample.xml)

Source code is as follows:

<blockquote class="code">
</blockquote>
<script>
flexo.ez_xhr("../../dom/test/sample.xml", { responseType: "text" }, function (req) {
  document.querySelector("blockquote").appendChild(flexo.$pre(req.response));
});
</script>


Describe about above sample code.

##Use of property

	<property name="count" as="number" value="0"/>
	<property name="roman" value="flexo.to_roman(`count).toUpperCase()"/>
In this way, property can be stored in component by using <tt>property</tt> elements.
Specify name of the property on <tt>name</tt> attribute, and specify type of the property on <tt>as</tt> attribute.
For the <tt>value</tt> attribute, specify a value of the property.
<tt>count</tt> is set as type of number because it store the value for count up(or down).
Since expression was set for the <tt>value</tt> of <tt>roman</tt>, the type was set as default(dynamic).
<tt>`count</tt> means count property. By prepending &#096;(backquote) to the name of property, bind the properties in each element like <tt>property</tt>, <tt>view</tt>.
(However, property binding in watch element is not supported, yet)

	    <html:p>
	      Number of clicks: `roman
	    </html:p>
In this way, it is possible to use <tt>roman</tt> property in <tt>view</tt> element.
The value <tt>count</tt> is returned in Roman numeral form by setting <tt>`roman</tt>.

##Property of external component

	      <component href="../lib/button.xml" id="button-minus" class="red">
	        <property name="enabled" value="#sample`count &gt; 0"/>
	        <view>
	          -1
	        </view>
	      </component>
2 buttons are used in this sample.
As same as <a href="">External component</a>, implement those buttons with <tt>button.xml</tt>.
For <tt>button-minus</tt>, the value is specified on <tt>value</tt> to set <tt>false</tt> for <tt>enabled</tt> property in case the value of <tt>count</tt> property becomes negative value. That leads the button to be disable.


##Get push event

	  <watch>
	    <get component="button-minus" event="!pushed"/>
	    <set property="count" value="this.properties.count + 1"/>
	  </watch>
It is the same manner as that in <a href="">External Component</a> to get <tt>pushed</tt> event by mouse event. However, <tt>set</tt> element is used in this tutorial where <tt>alert()</tt> is used in <tt>get</tt> element for the last tutorial.
<tt>set</tt> element set <tt>value</tt> to specified target (<tt>count</tt> in this sample).
<tt>this.properties.count</tt> is used to refer <tt>count</tt> property over here.
(because property binding in watch element is not supported, yet)




