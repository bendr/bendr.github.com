---
layout: tutorial
title: Bender Tutorial
---
#Display "Hello World!" with Bender Framwork.

-----
Application to be created be this tutorial : [Display "Hello World"](../../run.html?href=docs/tutorial/hello-world.xml)

To display string  "Hello world!", code is written as follows:


<blockquote class="code">
</blockquote>
<script src="../../flexo.js">
</script>
<script>
flexo.ez_xhr("hello-world.xml", { responsType: "text" }, function (req) {
  document.querySelector("blockquote").appendChild(flexo.$pre(req.response));
});
</script>

Since it is rendered as HTML, namespace should be specified as "html:" in HTML element.
Both component and view elements (namespace not specified) are Bender specific elements.
In addition to HTML, such as SVG can be used for rendering Bender component. In those cases, please do not forget to specify appropreate namespace with XMLNS.

For more information about Bender element, please refer [API reference](../reference/reference.html).

Write above code, and save as "hello-world.xml".

In Basics section of this Tutorial, we use "run.html" for
running sample Bender application.
"run.html" is the basic Bender runtime which Bender provides.

    http://[server_address]/bender/run.html?href=[work_directory]/hello-world.xml

Run above url with your Browser.

Set your Bender application to *href* with relative path from "run.html".

> __NOTE__
>
> Basically, paths described in this Tutorial is relative path
> from the Bender root.
>
> Also, Bender application in this Tutorial can be located in arbitrary
> directory.

