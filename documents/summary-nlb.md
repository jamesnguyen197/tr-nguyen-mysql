# AWS NLB の health check の仕様調査

# **Network Load Balancing**

Network Load Balancing (NLB) とは、同じシステム内に同じ機能を持つ2つ以上のサーバー間でトラフィックを均等に分散することです。具体的には、レイヤー4で操作します。TCP/UDPトラフィックの負荷を分散し、1秒で複数のリクエストを処理できます。また、低レイテンシー (ALB ~400ms と比較して ~100ms) を保証します。

### **目的:**&#x20;

* 単一の機能を1つにまとめます。

* 1台が故障や同期異常の場合、自動的に切り離され、他の台で実装しています。

### **利点:**&#x20;

* サーバーが過負荷になってダウンする状況をシステムが最小限に抑えることができます。&#x20;

* 1台が故障すると、負荷分散がそのサーバーのワークロードを残りのサーバーに振り分け、システムのアップタイムを最大限に押し上げ、全体的な性能を向上させます。

# **Health Check**

Health Checkは、サーバーの状況を確認しています。 転送規則で定義されたプロトコルやポートを使用し、サーバーに接続することにより、サーバーが動いていることを確認します。

サーバーのダウンが発生した場合、Health Checkはコンテナーから削除し、 リクエストが次のHealth Checkに達成するまで、このサーバーに転送されないことです。また、このプロセスを通じて、すべてのユーザータスクを処理するために実際に動作しているサーバーにトラフィックを直接転送できます。


<div style="text-align: center;">
<img src="./Image/NLBHealthCheck.png" alt="NLB Health check (Example)" width="400"/></div>

例えば、以上の図では左のMySQL Read Replicaでダウンが発生した場合、Health Checkでザーバーを判断してコンテナーから削除します。そして、右のMySQL Read Replicaはダウンしない場合、リクエストはそれらに送信して処理を行います。

# **問題点やできること**
1. [AWS NLB初心者向け説明 (特にHealthCheck)](https://iga-ninja.hatenablog.com/entry/2017/10/15/010946) <br>
 * Health Check は VPC か Subnet のCIDRぐらいしか無い <br>
 * NLB + Privateに引っ込んだバックエンドの構成は可能 <br>
 * ECS + NLBも一応イケる Privateに引っ込めるのがおすすめ

2. [NLBのヘルスチェックが原因でMySQLが接続ホストをブロックしてしまった話](https://qiita.com/araryo/items/09eb79c59be7e3961bc0) <br>
 * NLBのHealth Checkの原因でMySQLがホストとの接続できない

3. [ハマりポイントから学ぶALBとNLBの違い](https://qiita.com/sasamuku/items/10b9172185f9b551183a)<br>
 * NLBのSecurityGroupをアタッチできない <br>
 * NLBのクロスゾーン負荷分散はデフォルト無効になる