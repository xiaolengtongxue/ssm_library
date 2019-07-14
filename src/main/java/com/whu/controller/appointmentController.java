package com.whu.controller;

import com.alibaba.fastjson.JSONObject;
import com.whu.dao.AppointmentMapper;
import com.whu.dao.BookMapper;
import com.whu.dao.UserMapper;
import com.whu.entity.book.Appointment;
import com.whu.entity.book.AppointmentKey;
import com.whu.entity.book.Book;
import com.whu.entity.user.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.ArrayList;
import java.util.List;

//@Controller用于标注控制层组件
@Controller
//@RequestMapping("/xxx")  xxx  就是用户请求的xxx ，即接收用户请求地址的注解
@RequestMapping("/appointment")
public class appointmentController {
    //Autowired 作用：将Spring容器中的bean注入到属性
    @Autowired
    private AppointmentMapper appointmentMapper;

    @Autowired
    private BookMapper bookMapper;

    @Autowired
    private UserMapper userMapper;
//@Autowired
//private userService userservice;
    @RequestMapping(value = "/manage")
    private String manage(String username, Model model){
//        List<Book> bookList = null;
//        if (!username.equals("")){
//                bookList = bookMapper.selectAll();
//        }
//        model.addAttribute("booklist",bookList);
    //model传值，jsp页面使用EL表达式获取到值，<%@ page isELIgnored="false" %>
        return "appointment/manage";
    //返回到book/manage.jsp
    }

    @RequestMapping(value = "/getlist",method = RequestMethod.POST)
    //@ResponseBody 加上注解，可以返回一个json格式的字符串返回给前台，不加这个注解将会被视图解析器解析成跳转路径
    @ResponseBody
    private JSONObject getappointment(String username){
        JSONObject jsonObject=new JSONObject();
        List<Appointment> appointmentList=null;
        List<User> usernameList=new ArrayList<>();
        List<Book> booknameList=new ArrayList<>();

        if(!username.equals("")) {
            if (username.equals("admin"))
                //userList = userMapper.selectByUserName("");
                appointmentList=appointmentMapper.selectAll();
            else {
                List<User> user=null;
                user = userMapper.selectByUserName(username);
                appointmentList=appointmentMapper.selectByUserId(user.get(0).getUserid());
            }
        }

        for (int i=0;i<appointmentList.size();i++){
            Appointment appointment=appointmentList.get(i);
            int userid1=appointment.getUserid();
            long bookid1=appointment.getBookid();
            User user=userMapper.selectByPrimaryKey(userid1);
            Book book=bookMapper.selectByPrimaryKey(bookid1);
            usernameList.add(user);
            booknameList.add(book);
        }

        jsonObject.put("list",appointmentList);
        jsonObject.put("userlist",usernameList);
        jsonObject.put("booklist",booknameList);
        if (appointmentList.size()==0){
            jsonObject.put("info","error");
        }else {
            jsonObject.put("info", "success");
        }
        return jsonObject;
    }


    @RequestMapping(value = "/appoint",method = RequestMethod.POST)
    @ResponseBody
    private String appoint(int userid,long bookid){
        AppointmentKey appointmentKey=new AppointmentKey();
        appointmentKey.setBookid(bookid);
        appointmentKey.setUserid(userid);
        Appointment appointment=appointmentMapper.selectByPrimaryKey(appointmentKey);

        Book book=bookMapper.selectByPrimaryKey(bookid);

        if (appointment!=null){
            return "repeat";
        }
        if (book.getBooknumber()<=0){
            return "nonum";
        }
        int insert=appointmentMapper.insertAppointment(appointmentKey);
        if (insert<1) {
            return "error";                 //增加预约记录失败
        }else {
            int update2=bookMapper.reduceNumber(book);//图书数量减一
            if (update2 < 1){
                return "updateerror";       //图书数量更新失败
            }
            return "success";
        }
    }


    @RequestMapping(value = "/disappoint",method = RequestMethod.POST)
    //@ResponseBody 加上注解，可以返回一个json格式的字符串返回给前台，不加这个注解将会被视图解析器解析成跳转路径
    @ResponseBody
    private String disappoint(Long bookid,int userid){
        AppointmentKey appointmentKey=new AppointmentKey();
        appointmentKey.setUserid(userid);
        appointmentKey.setBookid(bookid);
        int delete=appointmentMapper.deleteByPrimaryKey(appointmentKey);
        Book book=bookMapper.selectByPrimaryKey(bookid);
        if (delete<1) {
            return "error";
        }
        else {
            int update=bookMapper.addNumber(book);
            if (update<1){
                return "updateerror";
            }
            return "success";
        }
    }
}
