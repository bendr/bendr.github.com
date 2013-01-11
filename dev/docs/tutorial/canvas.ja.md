---
layout: tutorial.ja
title: DOM eventとproperty
---
#DOM eventとpropertyを使う

-----
このチュートリアルで出来るアプリケーション : [フリーハンド描画（マウスイベントのみ）](../../run.html?href=docs/tutorial/canvas_and_property/draw.xml)

今回はCANVASを例に使用して、DOM eventとpropertyの使い方について説明します。

CANVASはブラウザ上で図を描くために、HTML5で策定された仕様です。
JavaScriptベースで図形の描画が可能になりました。

HTML5におけるCANVASの使い方の詳細は別途調べてください。
ここでは、CANVASの配置とマウスイベントによるフリーハンド描画の実装方法についてのみ触れたいと思います。

## サンプルコード

ソースコードは以下の通りです。

<blockquote class="code" id="draw-xml">
</blockquote>
<script src="../../flexo.js">
</script>
<script>
flexo.ez_xhr("canvas_and_property/draw.xml", { responseType: "text"}, function (req) {
  document.querySelector("#draw-xml").appendChild(flexo.$pre(req.response));
});
</script>

## スタイルシート
draw.css内のコードは以下の通りです。  
CANVASの位置とサイズが分かりやすいように、枠線を表示するようにしています。

<blockquote class="code" id="draw-css">
</blockquote>
<script src="../../flexo.js">
</script>
<script>
flexo.ez_xhr("canvas_and_property/draw.css", { responseType: "text"}, function (req) {
  document.querySelector("#draw-css").appendChild(flexo.$pre(req.response));
});
</script>

##ソースコードの説明
順番にコードの説明をします。

	<link rel="stylesheet" href="draw.css" />
スタイルシートの読み込みを行います。
記述方法は通常のlink要素と同じになります。
複数のスタイルシートを読み込みたい場合は、下から順に読み込まれることに注意してください。(変わるかもしれない。)
<br>
<br>
<br>

	<property name="context" as="dynamic"
	    value="this.views.$root.getContext('2d')" />
	<property name="down" as="boolean" value="false" />

このproperty要素は、コンポーネントが保持するプロパティを定義するための要素です。

1つめのpropertyは、contextプロパティを定義しています。CANVASのDOMメソッドgetContext('2d')によって取得した2Dコンテキストオブジェクトを、初期値としてvalueに設定します。  
2つめのpropertyは、downプロパティを定義しています。
このプロパティは、フリーハンド描画において、描画するか否かを判定するために使用します。ユーザ操作がない間は描画しないため、初期値をfalseとしてvalueに設定します。
<br>
<br>
<br>

view要素には、HTMLの要素としてcanvasを定義します。widthとheightは表示するCANVASのサイズを指定します。
<br>
<br>
<br>

	<get view="$root" dom-event="mousedown" />
	<set instance="$self" property="down">
	  value.preventDefault();
	  this.properties.context.beginPath();
	  var p = flexo.event_offset_pos(value, this.views.$root);
	  this.properties.context.moveTo(p.x, p.y);
	  return true;
	</set>

マウスイベントに関する処理については、mousedownを例に説明します。

get要素のviewで指定している$rootはview要素内に定義された一番最初の要素を指します。今回の場合はcanvasです。  
dom-eventには、対象となる要素において処理したいDOMイベントを指定します。今回はmousedownを指定します。  
これらによって、canvas上でマウスの左クリックが押された場合のイベントを取得することが出来ます。

set要素は、returnで値を復帰した場合、指定したコンポーネント($selfは自分自身のコンポーネントを表します)のプロパティ(down)に、その値を設定します。  
mousedownイベントが発生した時点で行いたい処理をここで行うことも可能です。  
処理をget要素内で行うか、set要素内で行うかの判断は、設定処理の有無を基準に考えることが出来ます。  
また、アトリビュートのviewとinstanceは、get要素とset要素の両方で利用する事が可能です。viewは要素を指定する場合に用います。instanceはコンポーネントを指定する場合に用います。
<br>
<br>
<br>

##DOM eventについて

今回のサンプルコードで使用しているDOM eventは、mousedown / mouseup / mousemoveの3つです。

mousedownは、マウスダウンがあった場合に発生するイベントです。  
mouseupは、マウスアップがあった場合に発生するイベントです。  
mousemoveは、マウス移動があった場合に発生するイベントです。  

それぞれのDOM eventに対して、watch要素による監視を行う必要があります。
フリーハンド描画を行うにあたり、それぞれのイベント内の処理の概要は以下の通りです。

<strong>mousedown</strong>
<ul class="item">
<li>イベントのデフォルトの動作の停止(preventDefault())</li>
<li>現在のパスのリセット(beginPath())</li>
<li>マウスカーソル位置の調整(flexo.event_offset_pos())</li>
<li>指定の地点で新規のサブパスを生成(moveTo())</li>
<li>描画可否フラグON</li>
</ul>


<strong>mousemove</strong>
<ul class="item">
<li>描画可否フラグONの場合</li>
<li>マウスカーソル位置の調整(flexo.event_offset_pos())</li>
<li>現在のパスに指定の地点を加え、直前の地点を直線で接続する(lineTo())</li>
<li>現在のストローク・スタイルを使って、サブパスに線を引く(stroke())</li>
<li>フラグをそのまま復帰する</li>
<li>描画可否フラグOFFの場合</li>
<li>フラグをそのまま復帰する</li>
</ul>


<strong>mouseup</strong>
<ul class="item">
<li>描画可否フラグをOFFにする</li>
</ul>
<br>
<br>

##実行
サンプルのソースコードをdraw.xml、スタイルシートをdraw.cssとして保存します。  
これまでと同様に、run.htmlを使用して、ブラウザ経由で実行します。  
枠線で囲われた描画エリアが表示され、マウスを使って描画することが可能です。  
以下のリンクをクリックすることで、サンプルコードを実際に動かした場合の挙動が確認出来ます。



