require("import");
import("common.BaseActivity");

import "org.sufficientlysecure.htmltextview.*"
import "pages.douban.detail.layout"
activity.setContentView(layout);




iconhrefout, usernameout, titledateout, titleout, data = ...
webuserpic.setImageBitmap(loadbitmap(iconhrefout))
webusernameout.Text = usernameout
webtitledateout.Text = titledateout
webtitleout.Text = titleout

luaweb.setHtml(data, HtmlHttpImageGetter(luaweb))
