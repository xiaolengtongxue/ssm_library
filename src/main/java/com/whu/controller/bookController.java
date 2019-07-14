package com.whu.controller;

import com.alibaba.fastjson.JSONObject;
import com.whu.dao.BookMapper;
import com.whu.entity.book.Book;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;
//import com.whu.service.userService;

//@Controller用于标注控制层组件
@Controller
//@RequestMapping("/xxx")  xxx  就是用户请求的xxx ，即接收用户请求地址的注解
@RequestMapping("/book")
public class bookController {
    //Autowired 作用：将Spring容器中的bean注入到属性
    @Autowired
    private   BookMapper bookMapper;
//@Autowired
//private userService userservice;

    @RequestMapping(value = "/manage")
    private String manage(String username,Model model){
//        List<Book> bookList = null;
//        if (!username.equals("")){
//                bookList = bookMapper.selectAll();
//        }
//        model.addAttribute("booklist",bookList);
        //model传值，jsp页面使用EL表达式获取到值，<%@ page isELIgnored="false" %>
        return "book/manage";
        //返回到book/manage.jsp
    }

    @RequestMapping(value = "/list",method = RequestMethod.POST)
    //@ResponseBody 加上注解，可以返回一个json格式的字符串返回给前台，不加这个注解将会被视图解析器解析成跳转路径
    @ResponseBody
    private JSONObject getbooklist(){
        JSONObject jsonObject=new JSONObject();
        List<Book> bookList=null;

        bookList=bookMapper.selectAll();
        jsonObject.put("list",bookList);
        if (bookList.size()==0){
            jsonObject.put("info","error");
        }else {
            jsonObject.put("info", "success");
        }
        return jsonObject;
    }

    @RequestMapping(value = "/editBook",method = RequestMethod.POST)
    //@ResponseBody 加上注解，可以返回一个json格式的字符串返回给前台，不加这个注解将会被视图解析器解析成跳转路径
    @ResponseBody
    private String editBook(Book book){
        List<Book> bookList=null;
        bookList=bookMapper.selectByBookname(book.getBookname());
        if (book.getBookname().equals("") || book.getBooknumber()==null){
            return "nullerror";
        }
        if (book.getBooknumber()<0){
            return "numerror";
        }
        if (bookList.size()>0){
            if ((long)(bookList.get(0).getBookid()) == (long)(book.getBookid())){
                int update=bookMapper.updateByPrimaryKeySelective(book);
                if (update<1)
                    return "error";
                return "success";
            }else {
                return "error";
            }
        }else {
            int update=bookMapper.updateByPrimaryKeySelective(book);
            if (update<1)
                return "error";
            return "success";
        }
    }

    @RequestMapping(value = "/addBook",method = RequestMethod.POST)
    //@ResponseBody 加上注解，可以返回一个json格式的字符串返回给前台，不加这个注解将会被视图解析器解析成跳转路径
    @ResponseBody
    private String addBook(Book book){
        List<Book> bookList=null;
        Book book1=new Book();
        bookList=bookMapper.selectByBookname(book.getBookname());
        book1=bookMapper.selectByPrimaryKey(book.getBookid());
        if (book.getBookid() == null){
            return "idnull";
        } else if (book.getBookname().equals("")){
            return "namenull";
        } else if (book.getBooknumber() == null){
            return "numnull";
        }
        else if (book.getBooknumber()<0){
            return "numerror";
        }
        if (bookList.size()>0){
            return "nameerror";
        }else if (book1!=null){
            return "iderror";
        }else {
            int insert=bookMapper.insert(book);
            if (insert<1)
                return "error";
            return "success";
        }
    }

    @RequestMapping(value = "/deleteBook",method = RequestMethod.POST)
    //@ResponseBody 加上注解，可以返回一个json格式的字符串返回给前台，不加这个注解将会被视图解析器解析成跳转路径
    @ResponseBody
    private String deleteBook(Long bookid){
        int delete=bookMapper.deleteByPrimaryKey(bookid);
        if (delete<1)
            return "error";
        return "success";
    }
//    public void test() throws Exception{
//
//        long bookId=1000;
//        Book book=bookMapper.selectByPrimaryKey(bookId);
//        System.out.println(book);
//
//        List<Book> books=bookMapper.selectAll();
//        System.out.println(books);
//
//        int update=bookMapper.reduceNumber(bookId);
//        Book book1=bookMapper.selectByPrimaryKey(bookId);
//        System.out.println(book1);
//
//        int update2=bookMapper.addNumber(bookId);
//        Book book2=bookMapper.selectByPrimaryKey(bookId);
//        System.out.println(book2);
//    }



}
