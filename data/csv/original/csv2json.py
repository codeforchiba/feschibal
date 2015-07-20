# coding: utf-8
# CSVを読み込んでJSON化する

import json
import copy
from datetime import datetime as dt

csvFileName = "chiba_festival.csv"

#読み出しで開く
csvFile = open(csvFileName,'r')

#行のリストを作成
eachLine = []

for line in csvFile:
  eachLine.append(line)

#ファイル閉じる
csvFile.close()

eachPart = [""] * len(eachLine)

#各行をカンマで分割
for i in range(len(eachLine)):
  eachPart[i] = eachLine[i].split(',')
  
#キーのリスト
keyList = eachPart.pop(0)

#配列
eachDict = []

count = 0
for i in range(len(eachPart)):
  eventJson = {}
  eventJson["@context"] = "http://schema.org"
  eventJson["@type"] = "Event"
  eventJson["name"] = eachPart[i][2] # 祭りの名称
  eventJson["description"] = eachPart[i][13] # 備考
  location = {}
  location["@type"] = "Place"
  location["name"] = eachPart[i][15] # 会場名称
  eventJson["location"] = location
  address = {}
  address["@type"] = "PostalAddress"
  address["addressRegion"] = "千葉県"
  address["addressLocality"] = eachPart[i][16] # 会場住所
  eventJson["location"]["address"] = address
  geo = {}
  geo["@type"] = "GeoCoordinates"
  geo["latitude"] = eachPart[i][18] # 会場緯度
  geo["longitude"] = eachPart[i][19] # 会場経度
  eventJson["location"]["geo"] = geo

  # 一つ目の開催日時の処理
  sDate = eachPart[i][4] + " " + eachPart[i][5]
  eDate = eachPart[i][4] + " " + eachPart[i][6]
  eventJson["startDate"] = dt.strptime(sDate, '%Y/%m/%d %H:%M').strftime('%Y-%m-%dT%H:%M:%S+09:00')
  eventJson["endDate"] = dt.strptime(eDate, '%Y/%m/%d %H:%M').strftime('%Y-%m-%dT%H:%M:%S+09:00')
  eachDict.append(eventJson)

  # 二つ目の開催日時の処理
  if eachPart[i][7] != "":
    eventJson2 = copy.deepcopy(eventJson)
    sDate = eachPart[i][7] + " " + eachPart[i][8]
    eDate = eachPart[i][7] + " " + eachPart[i][9]
    eventJson2["startDate"] = dt.strptime(sDate, '%Y/%m/%d %H:%M').strftime('%Y-%m-%dT%H:%M:%S+09:00')
    eventJson2["endDate"] = dt.strptime(eDate, '%Y/%m/%d %H:%M').strftime('%Y-%m-%dT%H:%M:%S+09:00')
    eachDict.append(eventJson2)

  # 三つ目の開催日時の処理
  if eachPart[i][10] != "":
    eventJson2 = copy.deepcopy(eventJson)
    sDate = eachPart[i][10] + " " + eachPart[i][11]
    eDate = eachPart[i][10] + " " + eachPart[i][12]
    eventJson2["startDate"] = dt.strptime(sDate, '%Y/%m/%d %H:%M').strftime('%Y-%m-%dT%H:%M:%S+09:00')
    eventJson2["endDate"] = dt.strptime(eDate, '%Y/%m/%d %H:%M').strftime('%Y-%m-%dT%H:%M:%S+09:00')
    eachDict.append(eventJson2)

encode_json_data = json.dumps(eachDict, indent=2, ensure_ascii=False)

print '<script type="application/ld+json">'
print encode_json_data
print '</script>'
