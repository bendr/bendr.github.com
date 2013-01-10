---
layout: tutorial.ja
title: Bender チュートリアル
---
#描画アプリを作成する

-----
[DOM Eventとproperty](canvas.ja.html)で使ったcanvasのコンポーネントを使用して、描画アプリを作成してみましょう。  
canvasのコンポーネント以外にもいくつかのコンポーネントを用意し、それらを組み合わせることによってアプリケーションの形にしていきたいと思います。コンポーネントの組み合わせの基本に関しては、[外部コンポーネント](external-component.ja.html)を参照してください。

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

<strong><a href="#text-box-title">text-box.xml</a></strong>
線の色と線の太さを指定するための入力用テキストボックスを定義する。

<strong><a href="#draw-title">draw.xml</a></strong>
描画コンポーネントを定義する。前項の描画コンポーネントをベースに線の色や太さなどいくつかのpropertyの追加とpropertyに対する処理が追加されたもの。

<strong><a href="#draw-view-title">draw-view.xml</a></strong>
アプリケーションのコンテンツエリア内のレイアウトを決定する。
描画コンポーネント(draw.xml)、テキストボックスコンポーネント(text-box.xml)を組み合わせて、それぞれの配置を決定する。また、テキストボックスに入力された値を描画コンポーネントに渡す設定も本コンポーネントで行う。

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

入力ボックスを配置し、入力ボックス内に変更が発生した場合、valueプロパティに設定します。  
このコンポーネントはdraw-view内で使用されます。


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

<property name="context" as="dynamic"
  value="this.views.$root.getContext('2d')" />
<property name="width" as="number" />
<property name="height" as="number" />
<property name="down" as="boolean" value="false" />
<property name="size" as="number" />
<property name="color" />
<property name="linejoin" value="round"/>
<property name="linecap" value="round"/>

width / height / size / color / linestyleをpropertyとして追加しました。  
widthとheightは、canvasのサイズを上位コンポーネントから指定出来るようにするために追加しています。  
sizeは描画時の線の太さ、colorは描画時の線の色を指定するためのプロパティです。  
linejoinおよびlinecapは描画時の線の種類を指定するためのプロパティです。  
width / height / sizeは数値を設定するため、型を指定するために、asに"number"を設定しています。  

追加したプロパティに対しても、watch要素を使って、監視処理を記載します。  

	<watch>
	  <get instance="$self" property="color">
	    this.properties.context.strokeStyle = value;
	  </get>
	</watch>
colorプロパティに変更があった場合、canvasのコンテキストが持つstrokeStyleにvalueを設定します。  
valueは色コードを指定されます。

	<watch>
	  <get instance="$self" property="size">
	    this.properties.context.lineWidth = value;
	  </get>
	</watch>
sizeプロパティに変更があった場合、lineWidth(線幅)にvalueを設定します。  
valueは数値が指定されます。

linejoin / linecapも同様にwatch要素を使用して、canvasのコンテキストに設定しています。
ただし、これらは途中で変更されることはありません。（読み込み時のみの処理の正しいソリューションは別途説明する予定です。）

mouseイベントに関する処理は特に変更ありませんが、モバイル端末向けにtouchイベントも取得出きるように、get要素(touchstart / touchmove / touchend)を追加しています。


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

プロパティはdraw-vewコンポーネント内で使用するcolorとsizeのみ定義します。

viewでは、用意した外部コンポーネントを使用して、アプリケーションとしてのレイアウトを決定します。  
タイトル、ラベル+入力ボックス(線色、線サイズ)、描画エリアを配置しています。
それぞれhtml要素を使用しているため、基本的な記述方法はHTMLのソースコードを書く場合と同じになります。  

このコンポーネントでは、入力ボックスに入力された値を描画コンポーネントに引き渡すための処理をしています。

	<watch>
	  <get instance="color" property="value"/>
	  <set instance="draw" property="color"/>
	</watch>
instanceには、view内で読み込んだcomponentのidを指定します。つまり、get要素ではidがcolorであるコンポーネントのvalueプロパティを取得します。  
そして、set要素ではget要素で取得した値をidがdrawのコンポートネントのcolorプロパティに受け渡します。  
sizeに関しても同様に処理を追加しています。

上記の通り、3つのコンポーネントを組み合わせることにより、描画アプリケーションを組み上げることが出来ます。  
これ以外にも、コントロールパネル用のコンポーネントなどを別途作成し、自由自在にカスタマイズすることが可能になります。


##実行
それぞれのコンポーネントの作成が完了したら、run.htmlを使って実行してみてください。


これで、基本的なBenderの使い方の説明は終わりです。
応用編では、さらに[詳細なコンポーネントの作成方法]()と[ランタイムのカスタマイズ方法]()について説明します。











