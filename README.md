# dotfiles

## requires

- bash
- git
- (Mac) Xcode

## usage (linux & mac)

```
$ mkdir ~/.dotfiles ; cd $_
$ git clone https://github.com/ohsuga/dotfiles.git .
$ bash ./bin/install.sh
```
- brew でパッケージを探すには `brew search アプリ名`
- brew でパッケージを追加するときは ~/Brewfile に対象パッケージを追記して `brew bundle`

## usage (windows)

- chocolatey のインストール
  - `@powershell -NoProfile -ExecutionPolicy unrestricted -Command "iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))" && SET PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin`
  - proxy 環境下ではhttp://chocolatey.org/api/v2/package/chocolatey/ をブラウザでダウンロード後、ファイル名 `chocolatey-*.nupkg` を `*.zip` に変更して展開。その後、同フォルダをzipで再圧縮・展開した後(ダウンロードファイルの実行ブロック回避のため)、管理者権限でコマンドプロンプトを開き展開したディレクトリに移動して
```
powershell -NoProfile -ExecutionPolicy unrestricted -Command ".\tools\chocolateyInstall.ps1"
```
  - packages.config をダウンロード
  - 管理者権限でコマンドプロンプトを開きpackages.config のあるディレクトリで
```
cinst -y packages.config
```

