---
layout: tutorial.ja
title: Bender チュートリアル
---
#外部コンポーネントを使う

-----
このチュートリアルで出来るアプリケーション : [ボタンでアラート表示](../../run.html?href=docs/tutorial/welcome.xml)

[Hello World.](./hello-world.ja.html)のページで作成したコードも1つのコンポーネントです。
Benderは小さいコンポーネントを組み合わせて、大きなアプリケーションを作成することが出来ます。

このページでは、別ファイルで作成したコンポーネントを使ってみるということをしたいと思います。
今回は、Benderが用意しているボタン コンポーネントを使ってみることにします。


<blockquote class="code">
</blockquote>
<script src="../../flexo.js">
</script>
<script>
flexo.ez_xhr("welcome.xml", { responseType: "text" }, function (req) {
  document.querySelector("blockquote").appendChild(flexo.$pre(req.response));
});
</script>


実行方法は、Hello World.の時と同じです。
上記のソースコードを"welcome.xml"として保存し、*run.html*を使って実行してみて下さい。
ラベルとグレーのボタンが表示されたかと思います。
ボタンをクリックしてみると、アラートが表示されるので、試してみて下さい。
<br>
<br>

Benderはボタン以外にも、いくつかのコントロールをコンポーネントとして用意しています。
<br>
※ 将来的には、ライブラリとして、もっと快適に利用出来ることを目指しています。
<br>
<br>

	<component id="thanks-button" href="button.xml">Thanks</component>

*button.xml*はボタン コンポーネントが定義されているXMLファイルです。
*component*要素の*href*に外部コンポーネントのファイルを指定することで、ターゲットドキュメントに対して、コンポーネントを組み込みます。
<br>
<br>

サンプルコードでは、*component*要素の中に、*view*と*watch*要素がそれぞれ定義されています。  
前回のチュートリアルでも登場した*view*要素では、表示内容を定義します。HTMLやSVGを使ってドキュメントのレイアウトやコンテンツ内容を記述します。

また、*watch*要素は、*view*要素内で定義したインスタンスやオブジェクトの監視を行います。  
*watch*要素は、*get*要素と*set*要素の子要素があります。  
ここでは、*get*要素に使用について説明します。
*set*要素の使い方に関しては、次章以降で説明します。
<br>
<br>

	<get instance="thanks-button" event="@pushed">

サンプルコードでも使用している*get*要素は、*instance*で指定したインスタンスに対して、*event*で指定したイベントが発生した場合に行う処理を定義する事が出来ます。
上記の例では、"thanks-button"（ボタン）で*@pushed*イベントが発生した場合、アラートを表示する様に指定しています。

各要素およびイベント種別の詳細に関しては、<a href="../reference/reference.html">API Reference</a>を参照してください。


