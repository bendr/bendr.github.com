---
layout: tutorial.ja
title: Bender チュートリアル
---
#Hello World!を表示する

-----

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
ネームスペースが明記されていないcomponentやviewはBender独自の要素です。  
HTMLの他にSVGなども利用することが可能です。その場合はXMLNSでネームスペースを宣言することを忘れないでください。  

※ Bender要素の詳細に関しては[API リファレンス](../reference/reference.ja.html)を参照してください。

上記のコードを記述し、ファイル名をhello-world.xmlとして保存します。

チュートリアルの基本編では、作成したBenderアプリケーション
を実行する際に、run.htmlを使用します。
run.htmlはBenderが提供する基本的なBender runtimeです。

	  http://[server_address]/bender/run.html?href=[work_directory]/hello-world.xml

を、ブラウザから[実行](../../run.html?href=docs/tutorial/hello-world.xml)します。

*href*にはrun.htmlからの相対パスでBenderアプリケーションを指定します。

> __補足__
>
> チュートリアル内の説明時のpathはダウンロードしたBender
> のルートからの相対pathで表記します。
>
> また、作成するBenderアプリケーションは、任意のディレクトリ配下に作成する
> ことが可能です。

