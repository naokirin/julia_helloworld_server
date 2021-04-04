# julia helloworld server

Juliaで簡単なWeb APIサーバーのサンプル

## 実行方法

docker-composeで実行できます。

```sh
$ docker-compose up --build
```

## アクセス方法

```sh
$ curl -X POST http://localhost:8888/hello_world -d '{"your_name": "taro"}'

# レスポンス結果
{"message":"Hello World: taro"}
```

