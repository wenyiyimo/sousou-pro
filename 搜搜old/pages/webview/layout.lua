layout = loadlayout({
  LinearLayout;
  backgroundColor="0xffffffff";
  layout_height="fill";
  orientation="vertical";
  layout_width="fill";
  {
    LuaWebView;
    layout_width="fill";
    id="webView";
    layout_height="fill";
    background="0xffffffff";
    layout_weight=1,
  };

  {
    LinearLayout;
    layout_width="match_parent";
    --Elevation="0dp";
    layout_height="70dp";
    paddingLeft='10dp';--卡片边距
    paddingRight='10dp';--卡片边距
    orientation="horizontal";
    backgroundColor="#FFFFFFFF";--背景色
    elevation=ElevationStyles().medium,--阴影层次
    --home按键
    {
      MaterialCardView;--卡片控件
      layout_width='45dp';--卡片宽度
      layout_height='45dp';--卡片高度
      cardBackgroundColor='#00ffffff';--卡片颜色
      layout_gravity='center';--在父控件中的对齐方式
      layout_margin='0dp';--卡片边距
      cardElevation='0dp';--卡片阴影
      strokeWidth="0dp", --边框宽度
      clickable=true;--点击效果
      radius='10dp';--卡片圆角
      id='home';--设置控件ID
      {
        ImageView;--图片控件
        layout_width='20dp';--图片宽度
        layout_height='20dp';--图片高度
        ColorFilter='#5C5C5C';--图片着色
        src="static/img/webview/home.png";
        --    id="homeButton"; ColorFilter='#5C5C5C';--图片着色
        scaleType='fitXY';--图片拉伸
        layout_gravity='center';--重力
        id='imgHome';--设置控件ID
      };
    };

    {
      MaterialCardView;--卡片控件
      layout_width='45dp';--卡片宽度
      layout_height='45dp';--卡片高度
      cardBackgroundColor='#00ffffff';--卡片颜色
      layout_gravity='center';--在父控件中的对齐方式
      layout_margin='0dp';--卡片边距
      cardElevation='0dp';--卡片阴影
      strokeWidth="0dp", --边框宽度
      clickable=true;--点击效果
      radius='10dp';--卡片圆角
      id='close';--设置控件ID
      {
        ImageView;--图片控件
        layout_width='20dp';--图片宽度
        layout_height='20dp';--图片高度
        ColorFilter='#5C5C5C';--图片着色
        src="static/img/webview/close.png";
        --    id="homeButton"; ColorFilter='#5C5C5C';--图片着色
        scaleType='fitXY';--图片拉伸
        layout_gravity='center';--重力
        id='imgClose';--设置控件ID
      };
    };




    --tag按键
    {
      MaterialCardView;--卡片控件
      layout_width='fill';--卡片宽度
      layout_height='35dp';--卡片高度
      cardBackgroundColor='#11000000';--卡片颜色
      layout_gravity='center';--在父控件中的对齐方式
      --layout_margin='0dp';--卡片边距
      layout_marginLeft='10dp';--卡片边距
      layout_marginRight='10dp';--卡片边距
      cardElevation='0dp';--卡片阴影
      strokeWidth="0dp", --边框宽度
      clickable=true;--点击效果
      radius='10dp';--卡片圆角
      id='search';--设置控件ID
      layout_weight=1,
      --tag按键
      {
        LinearLayout;
        layout_width="match_parent";
        --Elevation="0dp";
        layout_height="35dp";
        paddingLeft='10dp';--卡片边距
        paddingRight='10dp';--卡片边距
        orientation="horizontal";
        backgroundColor="#11000000";--背景色
        elevation=ElevationStyles().medium,--阴影层次
        --home按键

        {
          TextView;--文本控件
          layout_width='fill';--控件宽度
          layout_height='fill';--控件高度
          text='0';--显示文字
          textSize='11dp';--文字大小
          textColor='#5C5C5C';--文字颜色
          id='webTitle';--设置控件ID
          layout_weight=1,
          gravity='center';--重力
          singleLine=true;--设置单行输入
          ellipsize='marquee';--多余文字用跑马灯显示
          layout_marginLeft='10dp';--卡片边距
          layout_marginRight='10dp';--卡片边距
        };
        --tag按键
        {
          MaterialCardView;--卡片控件
          layout_width='25dp';--卡片宽度
          layout_height='25dp';--卡片高度
          cardBackgroundColor='#227CEA';--卡片颜色
          layout_gravity='center';--在父控件中的对齐方式
          layout_margin='0dp';--卡片边距
          cardElevation='0dp';--卡片阴影
          strokeWidth="0dp", --边框宽度
          clickable=true;--点击效果
          radius='25dp';--卡片圆角
          id='res';--设置控件ID
          Visibility=8,
          --tag按键

          {
            TextView;--文本控件
            layout_width='fill';--控件宽度
            layout_height='fill';--控件高度
            text='0';--显示文字
            textSize='11dp';--文字大小
            textColor='#ffffff';--文字颜色
            id='resNum';--设置控件ID
            singleLine=true;--设置单行输入
            ellipsize='marquee';--多余文字用跑马灯显示
            gravity='center';--重力
          };

        };
      };
    },

    {
      MaterialCardView;--卡片控件
      layout_width='45dp';--卡片宽度
      layout_height='45dp';--卡片高度
      cardBackgroundColor='#00ffffff';--卡片颜色
      layout_gravity='center';--在父控件中的对齐方式
      layout_margin='0dp';--卡片边距
      cardElevation='0dp';--卡片阴影
      strokeWidth="0dp", --边框宽度
      clickable=true;--点击效果
      radius='10dp';--卡片圆角
      id='flush';--设置控件ID

      {
        ImageView;--图片控件
        layout_width='20dp';--图片宽度
        layout_height='20dp';--图片高度
        ColorFilter='#5C5C5C';--图片着色
        src="static/img/webview/flush.png";
        --    id="homeButton"; ColorFilter='#5C5C5C';--图片着色
        scaleType='fitXY';--图片拉伸
        layout_gravity='center';--重力
        id='imgFlush';--设置控件ID
      };
    };




    --menu按键
    {
      MaterialCardView;--卡片控件
      layout_width='45dp';--卡片宽度
      layout_height='45dp';--卡片高度
      cardBackgroundColor='#00ffffff';--卡片颜色
      layout_gravity='center';--在父控件中的对齐方式
      layout_margin='0dp';--卡片边距
      cardElevation='0dp';--卡片阴影
      strokeWidth="0dp", --边框宽度
      clickable=true;--点击效果
      radius='10dp';--卡片圆角
      id='menu';--设置控件ID
      {
        ImageView;--图片控件
        layout_width='20dp';--图片宽度
        layout_height='20dp';--图片高度
        src="static/img/webview/menu.png";
        ColorFilter='#5C5C5C';--图片着色
        scaleType='fitXY';--图片拉伸
        layout_gravity='center';--重力
        id='imgMenu';--设置控件ID
      };
    };

  };


})


