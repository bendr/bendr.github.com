---
layout: setup.ja
title: Bender 環境構築
---
#Benderアプリケーション開発環境の構築

-----

Benderアプリケーションを作成する環境を構築するためには以下の手順で作業して下さい。

##1. Benderソースコードのダウンロード
任意のディレクトリに、以下のURLで公開しているソースコードをダウンロードします。

[Bender version 0.8](https://github.com/bendr/bender/archive/v0.8.zip) 
のダウンロード後、任意のディレクトリに解凍して下さい。

<br>
##2. Webサーバの準備（オプション）
Bender runtimeはコンポーネントとリソースをロードするのにXMLHttpRequestを使用するので、
Bender runtimeとコンポーネントをWebサーバ経由で利用したい場合はWebサーバを設定して下さい。
既にWebサーバをインストールし設定されている方は、上記ステップ1で設定したBenderのディレクトリ
にアクセス可能かどうかを確認して下さい。

<br>
##3. RelaxNG validatorのインストール（オプション）

BenderコンポーネントはXMLとして保存され、その構文はRelax NGの文法（'spec/bender.rng'）に従って
確認が可能です。作成したコンテンツを検証するのに、[Jing](http://www.thaiopensource.com/relaxng/jing.html)のようなRelax NG validatorをインストールしてもよいでしょう。 

<br>
上記の設定が完了したら、ブラウザで以下のURLにアクセスすることにより、Benderの動作を確認できます。
[dev/dom/runtime.svg?href=test/logo.xml](../../dom/runtime.svg?href=test/logo.xml)
（URLにはBenderがインストールされた場所をPrefixとして指定する必要があります。）
これでBenderのロゴが表示されるはずです。
次はBenderを利用したWebアプリケーション開発を始める為[チュートリアル](../tutorial/tutorial.html)のページに進みましょう。


