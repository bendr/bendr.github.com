---
layout: tutorial.ja
title: DOM eventとproperty
---
#dom-eventとpropertyを使う

-----
このチュートリアルで出来るアプリケーション : [フリーハンド描画（マウスイベントのみ）](../../run.html?href=docs/tutorial/canvas_and_property/draw.xml)

今回は、<tt>canvas</tt>を例に使用して、<tt>dom-event</tt>と<tt>property</tt>の使い方について説明します。
<tt>canvas</tt>はブラウザ上で図を描くために、HTML5で策定された仕様です。
JavaScriptベースで図形の描画が可能になりました。

HTML5における<tt>canvas</tt>の使い方の詳細は別途調べてください。
ここでは、<tt>canvas</tt>の配置とマウスイベントによるフリーハンド描画の実装方法についてのみ触れたいと思います。

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
*draw.css*内のコードは以下の通りです。  
<tt>canvas</tt>の位置とサイズが分かりやすいように、枠線を表示するようにしています。

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
記述方法は通常の<tt>link</tt>要素と同じになります。
複数のスタイルシートを読み込みたい場合は、下から順に読み込まれることに注意してください。(将来的に変更予定)
<br>
<br>
<br>

	<property name="context" as="dynamic"
	    value="this.views.$root.getContext('2d')" />
	<property name="down" as="boolean" value="false" />

この<tt>property</tt>要素は、コンポーネントが保持するプロパティを定義するための要素です。

1つめの<tt>property</tt>は、*context*プロパティを定義しています。
<tt>canvas</tt>のDOMメソッド<tt>getContext('2d')</tt>によって取得した2Dコンテキストオブジェクトを、初期値として*value*に設定します。  
2つめの<tt>property</tt>は、*down*プロパティを定義しています。
このプロパティは、フリーハンド描画において、描画するか否かを判定するために使用します。
ユーザ操作がない間は描画しないため、初期値を*false*として*value*に設定します。
<br>
<br>
<br>
<tt>view</tt>要素には、HTMLの要素として<tt>canvas</tt>を定義します。
*width*と*height*は表示する<tt>canvas</tt>のサイズを指定します。
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

マウスイベントに関する処理については、<tt>mousedown</tt>を例に説明します。
<br>
<br>
<br>
<tt>get</tt>要素の<tt>view</tt>で指定している<tt>$root</tt>は<tt>view</tt>要素内に定義された一番最初の要素を指します。
今回の場合は<tt>canvas</tt>です。  
<tt>dom-event</tt>には、対象となる要素において処理したいDOMイベントを指定します。
今回は<tt>mousedown</tt>を指定します。  
これらによって、<tt>canvas</tt>上でマウスの左クリックが押された場合のイベントを取得することが出来ます。
<br>
<br>
<br>
<tt>set</tt>要素は、<tt>return</tt>で値を復帰した場合、指定したコンポーネント
(<tt>$self</tt>は自分自身のコンポーネントを表します)のプロパティ(*down*)に、その値を設定します。  
<tt>mousedown</tt>イベントが発生した時点で行いたい処理をここで行うことも可能です。  
処理を<tt>get</tt>要素内で行うか、<tt>set</tt>要素内で行うかの判断は、設定処理の有無を基準に考えることが出来ます。  
また、属性の<tt>view</tt>と<tt>instance</tt>は、<tt>get</tt>要素と<tt>set</tt>要素の両方で利用する事が可能です。
<tt>view</tt>は要素を指定する場合に用います。
<tt>instance</tt>はコンポーネントを指定する場合に用います。
<br>
<br>
<br>

##DOMイベントについて

今回のサンプルコードで使用しているDOMイベントは、<tt>mousedown</tt> / <tt>mouseup</tt> / <tt>mousemove</tt>の3つです。
<br>
<br>
<tt>mousedown</tt>は、マウスダウンがあった場合に発生するイベントです。  
<tt>mouseup</tt>は、マウスアップがあった場合に発生するイベントです。  
<tt>mousemove</tt>は、マウス移動があった場合に発生するイベントです。  

それぞれのDOMイベントに対して、<tt>watch</tt>要素による監視を行う必要があります。
フリーハンド描画を行うにあたり、それぞれのイベント内の処理の概要は以下の通りです。

**mousedown**
<ul class="item">
<li>イベントのデフォルトの動作の停止(<tt>preventDefault()</tt>)</li>
<li>現在のパスのリセット(<tt>beginPath()</tt>)</li>
<li>マウスカーソル位置の調整(<tt>flexo.event_offset_pos()</tt>)</li>
<li>指定の地点で新規のサブパスを生成(<tt>moveTo()</tt>)</li>
<li>描画可否フラグON</li>
</ul>


**mousemove**
<ul class="item">
<li>描画可否フラグONの場合</li>
<li>マウスカーソル位置の調整(<tt>flexo.event_offset_pos()</tt>)</li>
<li>現在のパスに指定の地点を加え、直前の地点を直線で接続する(<tt>lineTo()</tt>)</li>
<li>現在のストローク・スタイルを使って、サブパスに線を引く(<tt>stroke()</tt>)</li>
<li>フラグをそのまま復帰する</li>
<li>描画可否フラグOFFの場合</li>
<li>フラグをそのまま復帰する</li>
</ul>


**mouseup**
<ul class="item">
<li>描画可否フラグをOFFにする</li>
</ul>
<br>
<br>

##実行
サンプルのソースコードを*draw.xml*、スタイルシートを*draw.css*として保存します。  
これまでと同様に、*run.html*を使用して、ブラウザ経由で実行します。  
枠線で囲われた描画エリアが表示され、マウスを使って描画することが可能です。



