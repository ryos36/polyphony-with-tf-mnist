# Jupyter での学習

ここでは自学自習できるように notebook 形式のプログラムを提供します。
1. tf-mnist.ipynb
   TensorFlow をつかってごく簡単な MNIST のモデルをつくって学習をさせます。
2. bfloat16.ipynb
   TensofFlow の学習データを bfloat16 に変換します。
3. python-bfloat16.ipynb
   bfloat16 の足し算/掛け算のプログラムを作ります
4. python-mnist.ipynb
   Python で MNIST をつかった予測をしてみます。bfloat16 を使っています。
       
4. でつかったファイルをコンパイルすると Vivado 等で実際に FPGA で動作させることが出来ます。

# Verilog ファイル
Verilog の下にコンパイル済み + ちょっとしたパッチ(Vivado に便利なように)
を入れてあります。
tcl 


# 関連情報
TensorFlow で MNIST
   http://www.sinby.com/seiko-udoku/19-04140.html

TensorFlow と bfloat16
   http://www.sinby.com/seiko-udoku/19-04141.html

Python を使って bfloat16
   http://www.sinby.com/seiko-udoku/19-04142.html

Polyphony で bfloat16
   http://www.sinby.com/seiko-udoku/19-04143.html

Polyphony で MNIST
   http://www.sinby.com/seiko-udoku/19-04144.html

Zybo で MNIST
   http://www.sinby.com/seiko-udoku/19-04145.html

Copyright (C) Sinby Corp.
