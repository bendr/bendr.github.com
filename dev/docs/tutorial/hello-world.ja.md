---
layout: tutorial.ja
title: Bender チュートリアル
---
#Hello World!を表示する

-----

表示にHTMLを使用した場合、"Hello world!"は以下の様に記述します:

<blockquote class="code">
</blockquote>
<script src="../../flexo.js">
</script>
<script>
flexo.ez_xhr("hello-world.xml", { responseType: "text" }, function (req) {
  document.querySelector("blockquote").appendChild(flexo.$pre(req.response));
});
</script>

上記のコードを記述し、ファイル名をhello-world.xmlとして保存します。

チュートリアルの基本編では、作成したBenderアプリケーション
を実行する際に、run.htmlを使用します。
run.htmlはBenderが提供する基本的なBender runtimeです。

	  http://[server_address]/bender/run.html?href=[work_directory]/hello.xml

を、ブラウザから[実行](../../run.html?href=docs/tutorial/hello-world.xml)します。

*href*にはrun.htmlからの相対パスでBenderアプリケーションを指定します。



> __補足__
>
> チュートリアル内の説明時のpathはダウンロードしたBender
> のルートからの相対pathで表記します。
>
> また、作成するBenderアプリケーションは、任意のディレクトリ配下に作成する
> ことが可能です。

