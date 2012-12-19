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

上記のコードを記述し、ファイル名をhello.xmlとして保存します。
  
  
  
  
チュートリアルの基本編では、作成したBenderアプリケーション
を実行する際に、run.htmlを使用します。
run.htmlはBenderが提供する基本的なBender runtimeです。

	  http://[server_address]/bender/run.html?href=work/hello.xml

を、ブラウザから実行します。

*href*にはrun.htmlからの相対パスでBenderアプリケーションを指定します。



> __補足__
>
> チュートリアル内の説明時のpathはダウンロードしたBender
> のルートからの相対pathで表記します。
>
> また、作成したBenderアプリケーションは、Benderのルート直下に
> 任意に作成したworkディレクトリ配下に保存します。

