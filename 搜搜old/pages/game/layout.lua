layout = loadlayout({
  LinearLayout;
  layout_height="fill";
  layout_width="fill";
  --  backgroundColor=4294967295;
  {
    LuaWebView;
    layout_height="match_parent";
    layout_width="match_parent";
    id="webView";
  };
})