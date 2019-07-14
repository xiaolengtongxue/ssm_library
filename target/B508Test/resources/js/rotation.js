var n=0;
var timer;
$(function () {
    function start_Time() {
       timer=setInterval(function () {
           n++;
           if (n>=4){
               n=0;
           }
           changeImg();
       },3000);
    }

    start_Time();

    function changeImg() {
        $("ul.imgs li").stop(true,true);    //停止匹配元素上当前运行的动画
        $("ul.imgs li").fadeOut(400).eq(n).fadeIn(400);
        //fadeIn()方法使用淡入效果来显示被选元素，假如该元素是隐藏的
        //400:规定元素从隐藏到可见的速度
        //fadeOut()方法使用淡出效果来隐藏被选元素，假如该元素是隐藏的。
        $("ul.focusList li").removeClass("cur").eq(n).addClass("cur");
        //eq()方法将匹配元素集中指定index上的一个
    }

    $(".leftBtn").click(function () {
        clearInterval(timer);
        n --;
        if (n==-1){
            n=3;
        }
        changeImg();
        start_Time();
    });

    $(".nextBtn").click(function () {
        clearInterval(timer);
        n ++;
        if (n==4){
            n=0;
        }
        changeImg();
        start_Time();
    });

    $("ul.focusList li").click(function () {
        clearInterval(timer);
        n=$(this).index();
        changeImg(n);
        start_Time();
    });

});