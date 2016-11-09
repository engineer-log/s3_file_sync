#!/bin/sh
PACKET_FROM=$1
PACKET_TO=$2

function error {
  echo "同期失敗"
  exit 1
}

echo "ファイル同期開始"
aws s3 sync s3://${PACKET_FROM}/sample s3://${PACKET_TO}/sample --delete --profile aws
if [ $? != 0 ]; then
  error
fi
echo "ファイル同期完了"