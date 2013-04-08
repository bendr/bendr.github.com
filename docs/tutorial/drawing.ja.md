---
layout: tutorial.ja
title: Bender チュートリアル
---
#描画アプリを作成する

-----
このチュートリアルで出来るアプリケーション : [描画アプリ](../../run.html?href=docs/tutorial/draw_app/draw-view.xml)

[dom-eventとproperty](canvas.ja.html)で使った<tt>canvas</tt>コンポーネントを使用して、描画アプリを作成してみましょう。  
<tt>canvas</tt>コンポーネント以外にもいくつかのコンポーネントを用意し、それらを組み合わせることによってアプリケーションの形にしていきたいと思います。コンポーネントの組み合わせの基本に関しては、[外部コンポーネント](external-component.ja.html)を参照してください。

##アプリケーション概要
描画アプリケーションの概要は以下の通りです。
<ul class="item">
  <li>コンテンツエリア内にアプリケーションタイトルを表示する</li>
  <li>描画線の色および線の太さの指定を可能にする</li>
  <li>描画線のスタイルをなめらかにする</li>
</ul>
機能としては多くありませんが、これによって、コンポーネントの組み合わせやコンポーネント間でのパラメタの受け渡しなど、基本的な実装仕様の確認が出来ることと思います。


##構成と各コンポーネントの説明
いくつかのコンポーネントを組み合わせて作成します。ファイル名のリンク先で、それぞれのコンポーネントの詳細について説明します。

<strong><a href="#text-box-title">text-box.xml</a></strong>
線の色と線の太さを指定するための入力用テキストボックスを定義します。

<strong><a href="#draw-title">draw.xml</a></strong>
描画コンポーネントを定義します。
前項の描画コンポーネントをベースに線の色や太さなどいくつかの<tt>property</tt>の追加と<tt>property</tt>に対する処理の追加を行います。

<strong><a href="#draw-view-title">draw-view.xml</a></strong>
アプリケーションのコンテンツエリア内のレイアウトを決定します。
描画コンポーネント(draw.xml)、テキストボックスコンポーネント(text-box.xml)を組み合わせて、それぞれの配置を決定します。
また、テキストボックスに入力された値を描画コンポーネントに渡す設定も本コンポーネントで行います。

<strong>draw.css</strong>
描画アプリ用のスタイルシート。前項からの変更がないため、特記はしません。

実行するメインのコンポーネントは、*draw-view.xml*で定義したコンポーネントです。
*draw-view.xml*は、*draw.xml*および*text-box.xml*を内部に組み込んでいます。
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

入力ボックスを配置し、入力ボックス内に変更が発生した場合、*value*プロパティに設定します。  
このコンポーネントは*draw-view*内で使用されます。


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

*width* / *height* / *size* / *color* / *linestyle*を<tt>property</tt>として追加しました。  
*width*と*height*は、<tt>canvas</tt>のサイズを上位コンポーネントから指定出来るようにするために追加しています。  
*size*は描画時の線の太さ、*color*は描画時の線の色を指定するためのプロパティです。  
*linejoin*および*linecap*は描画時の線の種類を指定するためのプロパティです。  
*width* / *height* / *size*は数値を設定するため、型を指定するために、<tt>as</tt>に*number*を設定しています。  

追加したプロパティに対しても、<tt>watch</tt>要素を使って、監視処理を記載します。  

	<watch>
	  <get instance="$self" property="color">
	    this.properties.context.strokeStyle = value;
	  </get>
	</watch>
*color*プロパティに変更があった場合、<tt>canvas</tt>のコンテキストが持つ<tt>strokeStyle</tt>に*value*を設定します。  
*value*は色コードを指定されます。

	<watch>
	  <get instance="$self" property="size">
	    this.properties.context.lineWidth = value;
	  </get>
	</watch>
*size*プロパティに変更があった場合、<tt>lineWidth</tt>(線幅)に*value*を設定します。  
*value*は数値が指定されます。

*linejoin* / *linecap*も同様に<tt>watch</tt>要素を使用して、<tt>canvas</tt>のコンテキストに設定しています。
ただし、これらは途中で変更されることはありません。（読み込み時のみの処理の正しいソリューションは別途説明する予定です。）

mouseイベントに関する処理は特に変更ありませんが、モバイル端末向けにtouchイベントも取得出きるように、<tt>get</tt>要素(<tt>touchstart</tt> / <tt>touchmove</tt> / <tt>touchend</tt>)を追加しています。


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

プロパティは*draw-vew*コンポーネント内で使用する*color*と*size*のみ定義します。
<br>
<br>
<tt>view</tt>では、用意した外部コンポーネントを使用して、アプリケーションとしてのレイアウトを決定します。  
タイトル、ラベル+入力ボックス(線色、線サイズ)、描画エリアを配置しています。
それぞれ<tt>html</tt>要素を使用しているため、基本的な記述方法はHTMLのソースコードを書く場合と同じになります。  

このコンポーネントでは、入力ボックスに入力された値を描画コンポーネントに引き渡すための処理をしています。

	<watch>
	  <get instance="color" property="value"/>
	  <set instance="draw" property="color"/>
	</watch>

<br>
<br>
この<tt>instance</tt>には、<tt>view</tt>内で読み込んだ<tt>component</tt>の<tt>id</tt>を指定します。
つまり、<tt>get</tt>要素では<tt>id</tt>が*color*であるコンポーネントの*value*プロパティを取得します。  
そして、<tt>set</tt>要素では<tt>get</tt>要素で取得した値を<tt>id</tt>が*draw*のコンポートネントの*color*プロパティに受け渡します。  
*size*に関しても同様に処理を追加しています。

上記の通り、3つのコンポーネントを組み合わせることにより、描画アプリケーションを組み上げることが出来ます。  
これ以外にも、コントロールパネル用のコンポーネントなどを別途作成し、自由自在にカスタマイズすることが可能になります。


##実行
それぞれのコンポーネントの作成が完了したら、*run.html*を使って実行してみてください。


これで、基本的なBenderの使い方の説明は終わりです。
応用編では、さらに[詳細なコンポーネントの作成方法]()と[ランタイムのカスタマイズ方法]()について説明します。











