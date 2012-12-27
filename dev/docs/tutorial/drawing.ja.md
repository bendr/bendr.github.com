---
layout: tutorial.ja
title: Bender チュートリアル
---
#描画アプリを作成する

-----
[DOM Eventとproperty](canvas.ja.html)で使ったcanvasのコンポーネントを使用して、描画アプリを作成してみましょう。  
canvasのコンポーネント以外にもいくつかのコンポーネントを用意し、それらを組み合わせることによってアプリケーションの形にしていきたいと思います。コンポーネントの組み合わせに基本に関しては、[外部コンポーネント](external-component.ja.html)を参照してください。

##アプリケーション概要
描画アプリケーションの概要は以下の通りです。
<ul class="item">
  <li>コンテンツエリア内にアプリケーションタイトルを表示する</li>
  <li>描画線の色および線の太さの指定を可能にする</li>
  <li>描画線のスタイルをなめらかにする</li>
</ul>
機能としては多くありませんが、これによって、コンポーネントの組み合わせやコンポーネント間でのパラメタの受け渡しなど、基本的な実装仕様の確認が出来ることと思います。

以下のリンクをクリックすることにより、本項で作成するアプリケーションと同じものが動作します。

[描画アプリ](../../run.html?href=docs/tutorial/draw_app/draw-view.xml)

##構成と各コンポーネントの説明
いくつかのコンポーネントを組み合わせて作成します。ファイル名のリンク先で、それぞれのコンポーネントの詳細について説明します。

<strong><a href="#draw-view-title">draw-view.xml</a></strong>
アプリケーションのコンテンツエリア内のレイアウトを決定する。
描画コンポーネント(draw.xml)、テキストボックスコンポーネント(text-box.xml)を組み合わせて、それぞれの配置を決定する。また、テキストボックスに入力された値を描画コンポーネントに渡す設定も本コンポーネントで行う。

<strong><a href="#draw-title">draw.xml</a></strong>
描画コンポーネントを定義する。前項の描画コンポーネントをベースに線の色や太さなどいくつかのpropertyの追加とpropertyに対する処理が追加されたもの。

<strong><a href="#text-box-title">text-box.xml</a></strong>
線の色と線の太さを指定するための入力用テキストボックスを定義する。

<strong>draw.css</strong>
描画アプリ用のスタイルシート。前項からの変更がないため、特記はしない。

実行するメインのコンポーネントは、draw-view.xmlで定義したコンポーネントです。
draw-view.xmlは、draw.xmlおよびtext-box.xmlを内部に組み込んでいます。
組み込み方は、外部コンポーネントの使い方と同じですが、組み込み対象のコンポーネントが、Benderがあらかじめ用意しているものではなく、自分で作成したものを使用するという点が異なります。
このことは、現時点では大きな違いではないので、特に意識する必要はありません。

<h2 id="text-box-title">text-box</h2>

<blockquote class="code" id="text-box">
</blockquote>
<script src="../../flexo.js">
</script>
<script>
flexo.ez_xhr("draw_app/text-box.xml", { responseType: "text"}, function (req) {
  document.querySelector("#text-box").appendChild(flexo.$pre(req.response));
});
</script>





<h2 id="draw-title">draw</h2>


<blockquote class="code" id="draw">
</blockquote>
<script src="../../flexo.js">
</script>
<script>
flexo.ez_xhr("draw_app/draw.xml", { responseType: "text"}, function (req) {
  document.querySelector("#draw").appendChild(flexo.$pre(req.response));
});
</script>

width / height / size / color / linestyleをpropertyとして追加しました。
widthとheightは、canvasのサイズを上位コンポーネントから指定出来るようにするために追加しています。
sizeは描画時の線の太さ、colorは描画時の線の色を指定するためのプロパティです。
linstyleは変更になる可能性があるので、保留。
width / height / sizeは数値を設定するため、型を指定するために、asに"number"を設定しています。



<h2 id="draw-view-title">draw-view</h2>


<blockquote class="code" id="draw-view">
</blockquote>
<script src="../../flexo.js">
</script>
<script>
flexo.ez_xhr("draw_app/draw-view.xml", { responseType: "text"}, function (req) {
  document.querySelector("#draw-view").appendChild(flexo.$pre(req.response));
});
</script>


##実行
それぞれのコンポーネントの作成が完了したら、run.htmlを使って実行してみてください。


これで、基本的なBenderの使い方の説明は終わりです。
応用編では、さらに[詳細なコンポーネントの作成方法]()と[ランタイムのカスタマイズ方法]()について説明します。











