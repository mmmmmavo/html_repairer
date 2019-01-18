# HTMLを修復します
# >> r = HTMLrepairer.new
# => #<HTMLRepairer:0x007fc758d00148 @session=#<Selenium::WebDriver::Chrome::Driver:0x1a04369d60067f02 browser=:chrome>>
#   >> r.fix("<table>")
# => "<html><head></head><body><table></table></body></html>"
# >> r.fix("<h3>hoge")
# => "<html><head></head><body><h3>hoge</h3></body></html>"
#
# 注意点：newすると、Chromeが起動します。
# 常駐プロセスでの使用の場合、使用終了時に#quit_chromeを推奨。
require "selenium-webdriver"

class HTMLRepairer
  def initialize
    ua = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/27.0.1453.116 Safari/537.36"

    caps = Selenium::WebDriver::Remote::Capabilities.chrome("chromeOptions" => {args: ["--headless","--no-sandbox", "--disable-setuid-sandbox", "--disable-gpu", "--user-agent=#{ua}", 'window-size=1280x800']})
    # caps = Selenium::WebDriver::Remote::Capabilities.chrome("chromeOptions" => {args: ["--user-agent=#{ua}", "window-size=1280x800"]})
    @session = Selenium::WebDriver.for :chrome, desired_capabilities: caps
    @session.manage.timeouts.implicit_wait = 30
  end

  def fix(html)
    html.force_encoding("utf-8")
    html.sub!(/(?<=charset=).*?(?=")/,"UTF-8")
    tmp_path = File.expand_path('../html/tmp.html', __FILE__)
    File.open(tmp_path, "w") do |f|
      f.puts html
    end
    @session.navigate.to("file:" + tmp_path)
    fixed = @session.execute_script("return document.getElementsByTagName('html')[0].outerHTML")
    File.delete(tmp_path)
    fixed
  end

  def quit_chrome
    @session.quit
  end
end