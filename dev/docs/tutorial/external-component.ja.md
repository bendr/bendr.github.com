---
layout: tutorial.ja
title: Bender チュートリアル
---
#外部コンポーネントを使う

-----
このチュートリアルで出来るアプリケーション : [ボタンでアラート表示](../../dom/runtime.html?href=../docs/tutorial/welcome.xml)

[Hello World.](./hello-world.ja.html)のページで作成したコードも1つのコンポーネントです。
Benderは小さいコンポーネントを組み合わせて、大きなアプリケーションを作成することが出来ます。

このページでは、別ファイルで作成したコンポーネントを使ってみるということをしたいと思います。
今回は、Benderが用意しているボタン コンポーネントを使ってみることにします。


<blockquote class="code">
</blockquote>
<script>
flexo.ez_xhr("welcome.xml", { responseType: "text" }, function (req) {
  document.querySelector("blockquote").appendChild(flexo.$pre(req.response));
});
</script>


実行方法は、Hello World.の時と同じです。
上記のソースコードを*welcome.xml*として保存し、*runtime.html*を使って実行してみて下さい。
ラベルとグレーのボタンが表示されたかと思います。
ボタンをクリックしてみると、アラートが表示されるので、試してみて下さい。
<br>
<br>

Benderはボタン以外にも、いくつかのコントロールをコンポーネントとして用意しています。
<br>
※ 将来的には、ライブラリとして、もっと快適に利用出来ることを目指しています。
<br>
<br>

     <component id="thanks-button" href="../../dom/lib/button.xml">
       <view>
         Thanks
       </view>
     </component>

*button.xml*はボタン コンポーネントが定義されているXMLファイルです。
<tt>component</tt>要素の<tt>href</tt>に外部コンポーネントのファイルを指定することで、ターゲットドキュメントに対して、コンポーネントを組み込みます。
<br>
<br>

サンプルコードでは、<tt>component</tt>要素の中に、<tt>view</tt>と<tt>watch</tt>要素がそれぞれ定義されています。  
前回のチュートリアルでも登場した<tt>view</tt>要素では、表示内容を定義します。HTMLやSVGを使ってドキュメントのレイアウトやコンテンツ内容を記述します。

また、<tt>watch</tt>要素は、<tt>view</tt>要素内で定義したインスタンスやオブジェクトの監視を行います。  
<tt>watch</tt>要素は、<tt>get</tt>要素と<tt>set</tt>要素の子要素があります。  
ここでは、<tt>get</tt>要素に使用について説明します。
<tt>set</tt>要素の使い方に関しては、次章以降で説明します。
<br>
<br>

	<get instance="thanks-button" event="@pushed">

サンプルコードでも使用している<tt>get</tt>要素は、<tt>instance</tt>で指定したインスタンスに対して、<tt>event</tt>で指定したイベントが発生した場合に行う処理を定義する事が出来ます。
上記の例では、*thanks-button*（ボタン）で<tt>@pushed</tt>イベントが発生した場合、アラートを表示する様に指定しています。


[次のステップ](property-binding.ja.html)では、プロパティの利用とバインディングについて説明します。

