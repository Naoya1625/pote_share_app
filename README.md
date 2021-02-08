README
Rails実践課題2つ目の「宿泊予約アプリ」です。

このアプリでは、
ユーザー登録、ログイン、ログアウト
ルームの登録、確認、編集、削除
他のユーザが登録したルームの予約、全ての予約確認を行うことができます。




-----アプリを動かす方法-----

・本リポジトリをクローンし、該当のディレクトリへ移動します。

$ git clone -b develop https://github.com/Naoya1625/poteshare_ptpn.git

$ cd poteshare_fin

・必要なパッケージをインストールし、bundle installします。

$ bundle install

・yarnをインストールします。

$ yarn install --check-files

・データベースを移行します。

$ rails db:migrate

・サンプルデータを設定します。

$ rails db:seed

・テストを実行して、正しく動作していることを確認します。

$ bin/rspec

・アプリを実行する準備が整いました。

$ rails server


