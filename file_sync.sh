#!/bin/sh
PACKET_FROM=$1
PACKET_TO=$2
ENVIRONMENT=$3
HOST=$4
SECRET_KEY_PATH=$5

function error {
  echo "同期失敗"
  exit 1
}

if [ "$ENVIRONMENT" == "s3" ]; then
  echo "ファイル同期開始"
  aws s3 sync s3://${PACKET_FROM}/sample s3://${PACKET_TO}/sample --delete --profile ds-photo
  if [ $? != 0 ]; then
    error
  fi
  echo "ファイル同期完了"
elif [ "$ENVIRONMENT" == "local" ]; then
  echo "ファイル同期開始"
  rsync -avz --delete -e "ssh -i ${SECRET_KEY_PATH}" /sample/ user@${HOST}:/sample/
  if [ $? != 0 ]; then
    error
  fi
  echo "ファイル同期完了"
else
  echo "指定のオプションは正しくありません"
  exit 1
fi