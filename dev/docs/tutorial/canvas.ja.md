---
layout: tutorial.ja
title: DOM eventとproperty
---
#dom-eventとpropertyを使う

-----
このチュートリアルで出来るアプリケーション : [フリーハンド描画（マウスイベントのみ）](../../run.html?href=docs/tutorial/canvas_and_property/draw.xml)

今回は*canvas*を例に使用して、*dom-event*と*property*の使い方について説明します。

*canvas*はブラウザ上で図を描くために、HTML5で策定された仕様です。
JavaScriptベースで図形の描画が可能になりました。

HTML5における*canvas*の使い方の詳細は別途調べてください。
ここでは、*canvas*の配置とマウスイベントによるフリーハンド描画の実装方法についてのみ触れたいと思います。

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
"draw.css"内のコードは以下の通りです。  
*canvas*の位置とサイズが分かりやすいように、枠線を表示するようにしています。

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
記述方法は通常の*link*要素と同じになります。
複数のスタイルシートを読み込みたい場合は、下から順に読み込まれることに注意してください。(将来的に変更予定)
<br>
<br>
<br>

	<property name="context" as="dynamic"
	    value="this.views.$root.getContext('2d')" />
	<property name="down" as="boolean" value="false" />

この*property*要素は、コンポーネントが保持するプロパティを定義するための要素です。

1つめの*property*は、*context*プロパティを定義しています。
*canvas*のDOMメソッド*getContext('2d')*によって取得した2Dコンテキストオブジェクトを、初期値として*value*に設定します。  
2つめの*property*は、*down*プロパティを定義しています。
このプロパティは、フリーハンド描画において、描画するか否かを判定するために使用します。
ユーザ操作がない間は描画しないため、初期値を*false*として*value*に設定します。
<br>
<br>
<br>

*view*要素には、HTMLの要素として*canvas*を定義します。
*width*と*height*は表示する*canvas*のサイズを指定します。
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

マウスイベントに関する処理については、*mousedown*を例に説明します。

*get*要素の*view*で指定している*$root*は*view*要素内に定義された一番最初の要素を指します。
今回の場合は*canvas*です。  
*dom-event*には、対象となる要素において処理したいDOMイベントを指定します。
今回は*mousedown*を指定します。  
これらによって、*canvas*上でマウスの左クリックが押された場合のイベントを取得することが出来ます。

*set*要素は、*return*で値を復帰した場合、指定したコンポーネント
(*$self*は自分自身のコンポーネントを表します)のプロパティ(*down*)に、その値を設定します。  
*mousedown*イベントが発生した時点で行いたい処理をここで行うことも可能です。  
処理を*get*要素内で行うか、*set*要素内で行うかの判断は、設定処理の有無を基準に考えることが出来ます。  
また、属性の*view*と*instance*は、*get*要素と*set*要素の両方で利用する事が可能です。
*view*は要素を指定する場合に用います。
*instance*はコンポーネントを指定する場合に用います。
<br>
<br>
<br>

##DOMイベントについて

今回のサンプルコードで使用しているDOMイベントは、*mousedown* / *mouseup* / *mousemove*の3つです。

*mousedown*は、マウスダウンがあった場合に発生するイベントです。  
*mouseup*は、マウスアップがあった場合に発生するイベントです。  
*mousemove*は、マウス移動があった場合に発生するイベントです。  

それぞれのDOMイベントに対して、*watch*要素による監視を行う必要があります。
フリーハンド描画を行うにあたり、それぞれのイベント内の処理の概要は以下の通りです。

**mousedown**
<ul class="item">
<li>イベントのデフォルトの動作の停止(<em>preventDefault()</em>)</li>
<li>現在のパスのリセット(<em>beginPath()</em>)</li>
<li>マウスカーソル位置の調整(<em>flexo.event_offset_pos()</em>)</li>
<li>指定の地点で新規のサブパスを生成(<em>moveTo()</em>)</li>
<li>描画可否フラグON</li>
</ul>


**mousemove**
<ul class="item">
<li>描画可否フラグONの場合</li>
<li>マウスカーソル位置の調整(<em>flexo.event_offset_pos()</em>)</li>
<li>現在のパスに指定の地点を加え、直前の地点を直線で接続する(<em>lineTo()</em>)</li>
<li>現在のストローク・スタイルを使って、サブパスに線を引く(<em>stroke()</em>)</li>
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
サンプルのソースコードを"draw.xml"、スタイルシートを"draw.css"として保存します。  
これまでと同様に、*run.html*を使用して、ブラウザ経由で実行します。  
枠線で囲われた描画エリアが表示され、マウスを使って描画することが可能です。



