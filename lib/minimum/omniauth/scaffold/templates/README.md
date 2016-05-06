# APP_NAME

APP_DESCRIPTION.

## Local Setting

### GitHub上でFork

```
https://github.com/USER_NAME/APP_NAME/
```

### リポジトリをローカルへ作成

```
cd ~/WORK_DIRECTORY
git clone git@github.com:YOUR_USER_NAME/APP_NAME.git
cd APP_NAME
```

### ブランチ作成

```
git checkout -b YOUR_NEW_BRANCH
```

### Twitterアプリ登録

<a href="https://dev.twitter.com/apps/new" target="_blank">Twitter Create an application</a>

```
Name: [ (アプリケーションの名前) ]
Description: [ (アプリケーションの説明) ]
WebSite: [ http://0.0.0.0:3000/ ]
Callback URL: [ http://0.0.0.0:3000/ ] ※登録しないと動かない
□ Yes, I agree <= チェック
CAPTCHA入力後「Create your Twitter application」を押下
```

### ローカル用Twitterキー設定

Create: config/settings.local.yml

```ruby
# Twitter OAuth Local Setting
twitter_key:    "YOUR_CONSUMER_KEY"
twitter_secret: "YOUR_CONSUMER_SECRET"
```

※Twitterアプリ登録完了後に表示された「Consumer key」を「YOUR_CONSUMER_KEY」に、「Consumer secret」を「YOUR_CONSUMER_SECRET」にそれぞれ入力

### Rails起動

Gemインストール

```
bundle install --without production
```

ローカルDB作成

```
rake db:setup
```

ローカルサーバ起動

```
bundle exec rails s
```

ページアクセス

```
http://0.0.0.0:3000/
```

## Copyright

Copyright (c) 20xx MY_NAME.

<a rel="license" href="http://creativecommons.org/licenses/by-nc-sa/4.0/" target="_blank">
<img alt="クリエイティブ・コモンズ・ライセンス" style="border-width:0" src="https://i.creativecommons.org/l/by-nc-sa/4.0/88x31.png" />
</a>
<br />
この 作品 は <a rel="license" href="http://creativecommons.org/licenses/by-nc-sa/4.0/" target="_blank">クリエイティブ・コモンズ 表示 - 非営利 - 継承 4.0 国際 ライセンス</a>の下に提供されています。
