# rss_feed_builder

対象ページの更新情報を定期実行で取得し、RSSフィードを生成する。

## Setting


## Usage

```bash
docker compose build
```

```bash
cp .env.sample .env
# .envを編集する
docker compose --env-file .env up -d
docker compose exec app lib/main.rb
```
