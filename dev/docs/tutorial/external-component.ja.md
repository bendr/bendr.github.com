---
layout: tutorial.ja
title: Bender チュートリアル
---
#外部コンポーネントを使う

-----

Hello World.のページで作成したコードも1つのコンポーネントです。
Benderは小さいコンポーネントを組み合わせて、大きなアプリケーションを作成することが出来ます。

このページでは、別ファイルで作成したコンポーネントを使ってみるということをしたいと思います。
今回は、Benderが用意しているButtonコンポーネントを使ってみることにします。


<blockquote class="code">
</blockquote>
<script src="../../flexo.js">
</script>
<script>
flexo.ez_xhr("welcome.xml", { responseType: "text" }, function (req) {
  document.querySelector("blockquote").appendChild(flexo.$pre(req.response));
});
</script>


実行方法は、Hello Worldの時と同じです。
上記のソースコードをwelcome.xmlとして保存し、run.htmlを使って実行してみて下さい。
ラベルとグレーのボタンが表示されたかと思います。
ボタンをクリックしてみると、アラートが表示されるので、試してみて下さい。
[実行例](../../run.html?href=docs/tutorial/welcome.xml)
<br>
<br>

BenderはButton以外にも、いくつかのコントロールをコンポーネントとして用意しています。
※ 将来的には、ライブラリとして、もっと快適に利用出来ることを目指しています。
<br>
<br>

	<component id="thanks-button" href="button.xml">Thanks</component>

button.xmlはButtonコンポーネントが定義されているXMLファイルです。
component要素のhrefに外部コンポーネントのファイルを指定することで、ターゲットドキュメントに対して、コンポーネントを組み込みます。
<br>
<br>

サンプルコードでは、component要素の中に、viewとwatch要素がそれぞれ定義されています。
前回のチュートリアルでも登場したview要素では、表示内容を定義します。HTMLやSVGを使ってドキュメントのレイアウトやコンテンツ内容を記述します。

また、watch要素は、view要素内で定義したインスタンスやオブジェクトの監視を行います。
watch要素は、get要素とset要素の子要素があります。
<br>
<br>

	<get instance="thanks-button" event="@pushed">

サンプルコードでも使用しているget要素は、instanceで指定したインスタンスに対して、eventで指定したイベントが発生した場合に行う処理を定義する事が出来ます。
上記の例では、thanks-button（Button）で@pushedイベントが発生した場合、アラートを表示する様に指定しています。

各要素およびイベント種別の詳細に関しては、<a href="../reference/reference.ja.html">APIリファレンス</a>を参照してください。










