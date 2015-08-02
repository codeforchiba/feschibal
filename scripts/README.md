## お祭りイベントCSVファイル

お祭りイベントのオリジナルCSVファイル(chiba_festival.csv)を保存

### お祭りイベントCSVファイルをJSON-LD形式に変換

使い方: 下記コマンドでchiba_festival.csvファイルを読み込んでJSON-LD形式の文字列を標準出力する。

```
nkf -w -Lu chiba_festival.csv chiba_festival.utf8.csv
python csv2json.py
```
