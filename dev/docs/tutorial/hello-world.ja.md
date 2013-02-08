---
layout: tutorial.ja
title: Bender チュートリアル
---
#Hello World!を表示する

-----
このチュートリアルで出来るアプリケーション : [Hello Worldの表示](../../run.html?href=docs/tutorial/hello-world.xml)


"Hello world!"を表示するには、以下の様にコードを記述します:

<blockquote class="code">
</blockquote>
<script src="../../flexo.js">
</script>
<script>
flexo.ez_xhr("hello-world.xml", { responseType: "text" }, function (req) {
  document.querySelector("blockquote").appendChild(flexo.$pre(req.response));
});
</script>

HTMLを使用して表示するため、HTMLの要素には"html:"のようにネームスペースを明記する必要があります。  
ネームスペースが明記されていない<tt>component</tt>や<tt>view</tt>はBender独自の要素です。  
HTMLの他にSVGなども利用することが可能です。その場合はXMLNSでネームスペースを宣言することを忘れないでください。  

※ Bender要素の詳細に関しては[API Reference](../reference/reference.html)を参照してください。

上記のコードを記述し、ファイル名を*hello-world.xml*として保存します。

チュートリアルの基本編では、作成したBenderアプリケーションを実行する際に、*run.html*を使用します。
*run.html*はBenderが提供する基本的なBenderランタイムです。

	  http://[server_address]/bender/run.html?href=[work_directory]/hello-world.xml

を、ブラウザから実行します。

<tt>href</tt>には*run.html*からの相対パスでBenderアプリケーションを指定します。

> __補足__
>
> チュートリアル内の説明時のパスはダウンロードしたBender
> のルートからの相対パスで表記します。
>
> また、作成するBenderアプリケーションは、任意のディレクトリ配下に作成する
> ことが可能です。

