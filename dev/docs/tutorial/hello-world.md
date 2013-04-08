---
layout: tutorial
title: Bender Tutorial
---
#Display "Hello World!" with Bender

-----
Application to be created by this tutorial : [Display "Hello World"](../../dom/runtime.html?href=../docs/tutorial/hello-world.xml)

To show string, "Hello world!", actual code is as follows:


<blockquote class="code">
</blockquote>
<script>
flexo.ez_xhr("hello-world.xml", { responseType: "text" }, function (req) {
  document.querySelector("blockquote").appendChild(flexo.$pre(req.response));
});
</script>

Since it is rendered as HTML, namespace should be specified as "html:" for HTML elements.
Both "component" and "view" elements (namespace not specified) are Bender specific elements.
In addition to HTML, such as SVG can be used for rendering Bender component. In those cases, please do not forget to specify appropreate namespace with XMLNS.

<!--
For more information about Bender element, please refer [API reference](../reference/reference.html).
-->

Write above code, and save it as "hello-world.xml".

In Basics section of this tutorial, the "run.html" is used for
running sample Bender application.
The "run.html" is the basic Bender runtime which Bender provides.

    http://[server_address]/bender/runtime.html?href=[work_directory]/hello-world.xml

Run above url with your Browser.

Set your Bender application to *href* with relative path from `runtime.html`.

> __NOTE__
>
> Basically, paths described in this Tutorial is relative path
> from the Bender root.
>
> Also, Bender application in this Tutorial can be located in arbitrary
> directory.

In the [next step](external-component.md), we will use a component and react to user input.
