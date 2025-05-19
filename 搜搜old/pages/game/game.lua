require("import");
import("common.BaseActivity");
import "pages.game.layout"


activity.setContentView(layout)


--webView.getSettings().setLoadsImagesAutomatically(true)
--webView.getSettings().setBlockNetworkImage(true)
webView.loadUrl("http://jg.doghun.com/fast/visitor?lg=11037170&client=2&ly=platform");

--设置禁止自动播放视频
webView.getSettings().setMediaPlaybackRequiresUserGesture(true);
webView.getSettings().setAcceptThirdPartyCookies(true) --接受第三方cookie
webView.getSettings().setSafeBrowsingEnabled(true)--安全浏览
webView.setHorizontalScrollBarEnabled(false)
webView.setHorizontalScrollBarEnabled(false);
webView.setVerticalScrollBarEnabled(false);
webView.getSettings().setJavaScriptEnabled(true); --支持js脚本

webView.getSettings().setDomStorageEnabled(true); --dom储存数据
webView.addJavascriptInterface({},"androidJS")--漏洞封堵代码


