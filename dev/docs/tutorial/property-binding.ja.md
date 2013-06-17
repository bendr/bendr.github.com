---
layout: tutorial.ja
title: Bender チュートリアル
---
# プロパティのバインディング

-----
このチュートリアルで出来るアプリケーション : [ボタンクリックによりカウントアップ](../../dom/runtime.html?href=../dom/test/sample.xml)

ソースコードを以下に記述します。

<blockquote class="code">
</blockquote>
<script>
flexo.ez_xhr("../../dom/test/sample.xml", { responseType: "text" }, function (req) {
  document.querySelector("blockquote").appendChild(flexo.$pre(req.response));
});
</script>


上記のサンプルコードについて説明します。

##プロパティの利用

	<property name="count" as="number" value="0"/>
	<property name="roman" value="flexo.to_roman(`count).toUpperCase()"/>
このように、<tt>property</tt>要素を使用して、コンポーネント内でプロパティを保持することが出来ます。
<tt>name</tt>属性にプロパティ名を指定し、<tt>as</tt>属性にプロパティの型を指定します。
<tt>value</tt>属性には、プロパティに設定する値を指定します。
<tt>count</tt>は、ボタンをクリックされた際にカウントアップ（ダウン）する値を格納するため、プロパティの型はnumberになっています。
<tt>roman</tt>は<tt>value</tt>に式を設定しているため、型はデフォルト（dynamic）としています。
<tt>`count</tt>はcountプロパティを意味します。&#096;（バッククォート）をプロパティ名の前につけることにより、<tt>property</tt>, <tt>view</tt>などの各要素内でプロパティへのバインディングを行います。
（ただし、watch要素内での利用は未実装）

	    <html:p>
	      Number of clicks: `roman
	    </html:p>
このように<tt>view</tt>要素内で<tt>roman</tt>プロパティを利用することも可能です。
<tt>`roman</tt>とすることで、ローマ数字に変換された<tt>count</tt>の値が返されます。

##外部コンポーネントのプロパティ

	      <component href="../lib/button.xml" id="button-minus" class="red">
	        <property name="enabled" value="#sample`count &gt; 0"/>
	        <view>
	          -1
	        </view>
	      </component>
今回のサンプルではボタンを2つ組み合わせています。
<a href="">外部コンポーネント</a>と同様に、<tt>button.xml</tt>を利用してボタンを実装しています。
<tt>button-minus</tt>は、<tt>count</tt>プロパティの値がマイナス値になった場合、ボタンを無効にするために、<tt>button</tt>コンポーネントの<tt>enabled</tt>プロパティに<tt>false</tt>を設定するように<tt>value</tt>に値を設定しています。


##pushイベントの取得

	  <watch>
	    <get component="button-minus" event="!pushed"/>
	    <set property="count" value="this.properties.count + 1"/>
	  </watch>
マウスイベントによる<tt>pushed</tt>イベントの取得は<a href="">外部コンポーネント</a>と同じですが、<tt>get</tt>要素内で<tt>alert()</tt>を実行していたのに対し、ここでは、<tt>set</tt>要素を使用します。
<tt>set</tt>要素は指定したターゲット（ここでは<tt>count</tt>プロパティ）に<tt>value</tt>を設定するものです。
<tt>count</tt>プロパティを参照するために、<tt>this.properties.count</tt>としてます。
（watch要素内でのプロパティ バインディングが未実装なため）





