more_item= {
  LinearLayout,--线性布局
  orientation="horizontal",--水平方向
  layout_width="fill",--布局宽度
  layout_height="fill",--布局高度
  {
    CardView,--卡片框控件
    layout_width="fill",--布局宽度
    layout_height="50dp",--布局高度
    layout_margin="10dp",--布局边距
    cardElevation="0dp",--卡片提升
    cardBackgroundColor="#FFF2F3F5",--卡片背景色
    radius="5dp",--圆角半径
    {
      LinearLayout,--线性布局
      orientation="horizontal",--水平方向
      layout_width="fill",--布局宽度
      layout_height="fill",--布局高度
      {
        ImageView,--图片框控件
        layout_width="56dp",--布局宽度
        layout_height="25dp",--布局高度
        id="img",
        src="static/img/more/icon.png",--视图路径
        layout_gravity="center",--重力居中
        --colorFilter="#333333",--图片颜色
      },
      {
        TextView,--文本框控件
        id="title",
        text="待开发",--文本内容
        layout_gravity="center",--重力居中
        textSize="13sp",--文本大小
        textColor="#333333",--文本颜色
      },
    },--线性布局 结束
  },--卡片框控件 结束
}
