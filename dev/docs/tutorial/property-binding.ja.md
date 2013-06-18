---
layout: tutorial.ja
title: Bender チュートリアル
---
# プロパティのバインディング

-----
このチュートリアルで出来るアプリケーション : [ボタンクリックによりカウントアップ]
(../../dom/runtime.html?href=../dom/test/sample.xml)

ソースコードを以下に記述します。

<blockquote class="code">
</blockquote>
<script>
flexo.ez_xhr("../../dom/test/sample.xml", { responseType: "text" }, function (req) {
  document.querySelector("blockquote").appendChild(flexo.$pre(req.response));
});
</script>

##コンポーネントのプロパティ

Benderのコンポーネントは状態を管理するプロパティを持つことができます。
BenderのプロパティはJavascriptオブジェクトのプロパティと同様ですが、
さらにwatch要素によって観測できるというメリットがあり、プロパティの値の
変更をトリガとして様々な変更を行うことも可能になります。

今回の例では、メインのコンポーネントがカウントを保持する<tt>count</tt>を持ち、
2つのボタンでカウントアップとカウントダウンが可能です。
また、カウントは別のプロパティ<tt>roman</tt>を使うことによりローマ数字で
表示されます。

プロパティは以下のように<tt>component</tt>要素に<tt>property</tt>子要素を
追加することで定義されます。

	<property name="count" as="number" value="0"/>

<tt>name</tt>属性は必須でプロパティの名称を定義します。
<tt>value</tt>属性はプロパティの値を定義します。この例ではカウントが0から
始まります。
XMLの属性は常に文字列なので、<tt>as</tt>属性で値をどのように扱うかの情報を
付与します。ここでは、カウントはテキスト文字列ではなくJavascriptのnumberと
して扱われます。<tt>as</tt>に設定される他の値は<tt>string</tt>、<tt>boolean</tt>
（<tt>true</tt>か<tt>false</tt>となるJavascriptのboolean値）、<tt>json</tt>
（JSON表記を使ったJavascriptのboolean値）、<tt>dynamic</tt>（Javascriptの式で
これがデフォルト値）です。

##カウントアップとダウン

<tt>button-plus</tt>と<tt>button-minus</tt>の2つのボタンでカウントのアップと
ダウンを行います。
[外部コンポーネント](external-component.ja.html)と同様にwatchを使用してボタン
から<tt>pushed</tt>イベントを取得し、その結果に応じて<tt>count</tt>プロパティ
の値を修正します。

	<watch>
	  <get component="button-plus" event="!pushed"/>
	  <set property="count" value="this.properties.count +1"/>
	</watch>

<tt>set</tt>要素は<tt>value</tt>（プロパティ値と同様）を指定されたターゲット
（今回のサンプルでは<tt>count</tt>プロパティ）に設定します。
値は<tt>this</tt>が現状のコンポーネントを参照するJavascriptの式です。
<tt>this.properties</tt>はコンポーネントのプロパティのディクショナリなので、
<tt>this.properties.count</tt>はコンポーネントのプロパティの<tt>count</tt>
プロパティを参照します。

##カウントのローマ数字への変換

2つめのプロパティである<tt>roman</tt>は以下のように定義されています。

	<property name="roman" value="flexo.to_roman('count).toUpperCase()"/>

本プロパティの値がJavascriptの式で、1つ違いがあることに注意して下さい。
文字<tt>&#x60;</tt>がコンポーネントの他のプロパティを参照する為に使用されて
います。これには2つの効果が含まれます。

<ol>
	<li><tt>this.properties.count</tt>の簡易な記述方法</li>
	<li><tt>count</tt>の値が変更（例えばボタンの1つが押された場合）される度に
	<tt>roman</tt>の値が更新されることを確認するwatchを生成
</ol>

これがプロパティ　バインディングと呼ばれ、ここでは<tt>roman</tt>プロパティが
<tt>count</tt>プロパティにバインドされています。

本プロパティの定義の最終結果として、<tt>count</tt>に新しい数値が設定される度に
<tt>roman</tt>はFlexoの<tt>to_roman()</tt>ライブラリ関数を使ってローマ数字に
設定され、大文字に変換されて表示されることになります。

##カウント値の表示

最後の段階になりますが、コンポーネントのview内に<tt>roman</tt>プロパティの値
を表示します。
Benderではview内でテキスト要素を生成し、<tt>roman</tt>プロパティが変更された
場合にテキスト要素が新しい値で更新されるようにwatchを設定することで実現可能です。
テキストバインディングを使うことで、以下のようにさらに簡単になります。

	<view xmlns:html="http://www.w3.org/1999/xhtml">
	  <html:p>
	    Number of clicks: `roman
	  </html:p>
	</view>

繰り返しになりますが、<tt>roman</tt>に<tt>&#x60;</tt>文字が付いていることに
注意して下さい。

##他のコンポーネントからのバインディング

今回のサンプルアプリケーションでは正の値のみを表示します。
カウントが0の場合、それ以上はマイナスすることができない為、マイナスボタンは
無効にする必要があります。
Benderで標準のボタンはboolean値の<tt>enabled</tt>プロパティを持っています。
ボタンを無効にするには本プロパティをfalseに設定し、有効にするにはtrueに設定
します。

カウントが0以下になることを防ぐ為に、マイナスボタンの<tt>enabled</tt>プロパティ
がメインコンポーネントの<tt>count</tt>プロパティにバインドされています。

	<component href="../lib/button.xml" id="button-minus" class="red">
	  <property name="enabled" value="#sample`count &gt; 0"/>
	  <view>
	    -1
	  </view>
	</component>

マイナスボタンの<tt>enabled</tt>プロパティはさらに複雑なバインディングで、
自身のプロパティのバインディングではなく、他のコンポーネント（ここではidが
<tt>sample</tt>のメインコンポーネント）のバインディングになっています。
異なるコンポーネントのプロパティが参照する際は、プロパティ名（バッククォート
を含む）はコンポーネントidの後に続き、それに<tt>#</tt>記号が付きます。


