# 壊れたHTMLを修復します
```
>> r = HTMLrepairer.new
=> #<HTMLRepairer:0x007fc758d00148 @session=#<Selenium::WebDriver::Chrome::Driver:0x1a04369d60067f02 browser=:chrome>>
>> r.fix("<table>")
=> "<html><head></head><body><table></table></body></html>"
>> r.fix("<h3>hoge")
=> "<html><head></head><body><h3>hoge</h3></body></html>"
```

## 注意点
- newすると、Chromeが起動します。
    - Chrome/selenium実行環境が必要です。chromedriver/chromeのインストールが必要です。
    - 常駐プロセスでの使用の場合、使用終了時に#quit_chromeしてchromeを終了させることを推奨。