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


プロパティのバインディングにより、

&#096;（バッククォート）


上記のコードでは、

実際に実行すると



