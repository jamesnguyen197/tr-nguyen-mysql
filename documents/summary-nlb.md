# AWS NLB の health check の仕様調査

 https://docs.aws.amazon.com/elasticloadbalancing/latest/network/introduction.html 

 https://docs.aws.amazon.com/elasticloadbalancing/latest/network/target-group-register-targets.html#target-security-groups 

 https://docs.aws.amazon.com/elasticloadbalancing/latest/network/target-group-health-checks.html 

 https://docs.aws.amazon.com/ja_jp/athena/latest/ug/networkloadbalancer-classic-logs.html 

 https://qiita.com/kooohei/items/c6443c2b455c62907832 

 https://dev.classmethod.jp/articles/load-balancing-private-ec2-rds-nlb/ 

Network Load Balancingとは、同じシステム内に同じ機能を持つ2つ以上のサーバー間でトラフィックを均等に分散することです。

#### **目的:**&#x20;

・単一の機能を1つにまとめます。

・1台が故障や同期異常の場合、自動的に切り離され、他の台で実装しています。

#### 利点:&#x20;

・サーバーが過負荷になってダウンする状況をシステムが最小限に抑えることができます。&#x20;

・1台が故障すると、負荷分散がそのサーバーのワークロードを残りのサーバーに振り分け、システムのアップタイムを最大限に押し上げ、全体的な性能を向上させます。

#### 問題点


