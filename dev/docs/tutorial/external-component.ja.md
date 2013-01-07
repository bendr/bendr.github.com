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

<code>button.xml</code>はButtonコンポーネントが定義されているXMLファイルです。  
<code>component</code>要素の<code>href</code>に外部コンポーネントのファイルを指定することで、ターゲットドキュメントに対して、コンポーネントを組み込みます。
<br>
<br>

サンプルコードでは、<code>component</code>要素の中に、<code>view</code>と<code>watch</code>要素がそれぞれ定義されています。
前回のチュートリアルでも登場した<code>view</code>要素では、表示内容を定義します。HTMLやSVGを使ってドキュメントのレイアウトやコンテンツ内容を記述します。

また、<code>watch</code>要素は、<code>view</code>要素内で定義したインスタンスやオブジェクトの監視を行います。
<code>watch</code>要素は、<code>get</code>要素と<code>set</code>要素の子要素があります。
<br>
<br>

		<get instance="thanks-button" event="@pushed">

サンプルコードでも使用している<code>get</code>要素は、<code>instance</code>で指定したインスタンスに対して、<code>event</code>で指定したイベントが発生した場合に行う処理を定義する事が出来ます。
上記の例では、<code>thanks-button</code>（Button）で<code>@pushed</code>イベントが発生した場合、アラートを表示する様に指定しています。

各要素およびイベント種別の詳細に関しては、<a href="../reference/reference.ja.html">APIリファレンス</a>を参照してください。










