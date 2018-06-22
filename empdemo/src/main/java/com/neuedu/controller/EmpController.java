package com.neuedu.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.neuedu.entity.Emp;
import com.neuedu.service.DeptService;
import com.neuedu.service.EmpService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

@Controller
@RequestMapping(value = "/emp")
public class EmpController {

    @Autowired
    private EmpService empService;
    @Autowired
    private DeptService deptService;

    @RequestMapping(value = {"/emplist"})
    public String empList(ModelMap param, @RequestParam(name = "pageNum", defaultValue = "1") int pageNum, HttpSession httpSession) {
        //在查询之前调用插件的分页方法
        PageHelper.startPage(pageNum, 10);
        List<Emp> empList = empService.listEmp();
        PageInfo<Emp> pageInfo = new PageInfo<>(empList, 10);
        param.put("pageInfo", pageInfo);
        //将当前页码存入到session
        httpSession.setAttribute("empPageNum",pageInfo.getPageNum());
        return "emplist";
    }


    @RequestMapping(value = {"/deleteEmpById"})
    public String deleteEmpById(int[] id,HttpSession httpSession) {
        empService.deleteEmpByIds(id);
        Integer pageNum = (Integer) httpSession.getAttribute("empPageNum");
        return "redirect:/emp/emplist?pageNum=" + pageNum;
    }

    @RequestMapping(value = {"/addEmpView"})
    public String addEmpView(ModelMap param) {
        param.put("deptList", deptService.listDept());
        return "addEmp";
    }

    //method为限制请求类型
//    @RequestMapping(value = {"/addEmp"},method = {RequestMethod.POST})
    @PostMapping(value = {"/addEmp"})
    public String addEmp(Emp emp) {
        int pageNum = empService.saveEmp(emp);
        return "redirect:/emp/emplist?pageNum=" + pageNum;
    }

    @RequestMapping(value = {"/updateEmpView"})
    public String updateEmpView(ModelMap param, int id) {
        param.put("deptList",deptService.listDept());
        param.put("emp",empService.getEmpById(id));
        return "updateEmp";
    }

    @RequestMapping(value = {"/updateEmp"})
    public String updateEmp(Emp emp,HttpSession httpSession){
        empService.updateEmp(emp);
        Integer pageNum = (Integer) httpSession.getAttribute("empPageNum");
        return "redirect:/emp/emplist?pageNum=" + pageNum;
    }


    /**
     * 需要在这个方法里查询出所有员工信息并且转化为json格式响应给前台
     */
    @RequestMapping(value = {"/emps"})
    @ResponseBody//告诉springmvc这响应不是页面是一个实体内容，你给我转化成json响应
    @CrossOrigin//允许ajax跨域，在http协议上带一个键值对Access-Control-Allow-Origin
    public List<Emp> emps(HttpServletResponse resp) throws IOException {
        //1 数据查询了
        List<Emp> empList = empService.listEmp();
        return empList;
    }

}
