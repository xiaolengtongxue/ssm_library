package com.whu.controller;

import com.whu.dao.UserMapper;
import com.whu.entity.user.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.List;

//@Controller用于标注控制层组件
@Controller
//@RequestMapping("/xxx")  xxx  就是用户请求的xxx ，即接收用户请求地址的注解
@RequestMapping("/user")
public class userController {
    //Autowired 作用：将Spring容器中的bean注入到属性
    @Autowired
    private   UserMapper userMapper;
//@Autowired
//private userService userservice;
    @RequestMapping(value = "/register")
    private String  register(){
        return "user/register";     //返回到user/register.jsp
    }

    @RequestMapping(value = "/manage")
    private String  manage(String username,Model model){
        List<User> userList = null;
        if(!username.equals("")) {
            if (username.equals("admin"))
                //userList = userMapper.selectByUserName("");
                userList = userMapper.selectAll("");
            else
                userList = userMapper.selectByUserName(username);
        }
        model.addAttribute("userlist",userList);
        //model传值，jsp页面使用EL表达式获取到值，<%@ page isELIgnored="false" %>
        return "user/manage";
        //返回到user/manage.jsp
    }
@RequestMapping(value = "editUser",method = RequestMethod.POST)
//@ResponseBody 加上注解，可以返回一个json格式的字符串返回给前台，不加这个注解将会被视图解析器解析成跳转路径
@ResponseBody
private String editUser(User user){
    //建一个user集合，将username相同的user对象放进去
    List<User> userList = null;
    userList = userMapper.selectByUserName(user.getUsername());
//    User user1 = new User();
//    user1 = userMapper.selectByPrimaryKey(user.getUserid());
    //更新用户名或密码时不能为空，否则不能更新
    if (user.getUsername().equals("") || user.getPassword().equals("")){
        return "nullerror";
    }
    //集合中有与修改后的username相同的user
    if (userList.size() > 0) {
        //如果修改后username的userid与集合里username一样的userid相同，说明没改username，可以更新
        //否则说明修改后的username与其他的相同，说明username重复了，则不可以更新
        if (userList.get(0).getUserid() == user.getUserid()){
            int update=userMapper.updateByPrimaryKeySelective(user);
            if(update<1)
                return "error";
            return "success";
        }else {
            return "error";
        }
    }else {
        int update = userMapper.updateByPrimaryKeySelective(user);
        if (update < 1)
            return "error";
        return "success";
    }
}
    @RequestMapping(value = "/login",method = RequestMethod.POST)
    @ResponseBody
    private String login(String userName,String password,HttpSession session ) throws NullPointerException{
        if (userName == "" || password == ""){
            return "nullerror";
        }
        User user = userMapper.login(userName,password);
        //登录成功把user对象放在session里面传递
        session.setAttribute("user",user);
        if(user!=null && user.getUsername() != "" && user.getPassword() != "")
            return "success";
        return "error";
    }
    @RequestMapping(value = "/registers",method = RequestMethod.POST)
    @ResponseBody
    private String registers(String userName,String password, HttpSession session){
        //新建一个user对象的集合，通过username查询，将username一样的放进集合中
        List<User> userList = null;
        userList = userMapper.selectByUserName(userName);
        //如果user集合大小大于0，说明注册的名字已存在，不可以注册
        if (userList.size() > 0)
            return "error";
        //用户名或密码为空时，不可以注册，返回nullerror
        if (userName == "" || password == ""){
            return "nullerror";
        }
        //成功注册，将新的user对象到数据库
        User user = new User();
        user.setUsername(userName);
        user.setPassword(password);
        int insert=userMapper.insert(user);
        if(insert>0) {
            //登陆成功将user对象放进session里传递
            session.setAttribute("user",user);
            return "success";
        }
        return "error";
    }
    @RequestMapping(value = "/deleteUser",method = RequestMethod.POST)
    @ResponseBody
    private String deleteUser(int userid){
        int delete = userMapper.deleteByPrimaryKey(userid);
        if(delete < 1)
            return  "error";
        return  "success";
    }

    @RequestMapping(value ="/signout")
    public String singout(HttpSession session){
        session.removeAttribute("user");
        return "login";
    }
}
