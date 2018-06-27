package com.neuedu.controller;


import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.neuedu.entity.Dept;
import com.neuedu.service.DeptService;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.openxml4j.exceptions.InvalidFormatException;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.usermodel.WorkbookFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import sun.misc.BASE64Encoder;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.InputStream;
import java.net.URLEncoder;
import java.util.List;

@Controller
@RequestMapping(value = {"/dept"})
public class DeptController {

    @Autowired
    private DeptService deptService;

    @RequestMapping(value = {"/deptlist"})
    public String deptList(ModelMap param, @RequestParam(value = "pageNum",defaultValue = "1") int pageNum, HttpSession httpSession){
        PageHelper.startPage(pageNum,10);
        List<Dept> deptList = deptService.listDept();
        PageInfo<Dept> pageInfo = new PageInfo<>(deptList,5);
        param.put("pageInfo",pageInfo);
        httpSession.setAttribute("deptPageNum",pageInfo.getPageNum());
        return "deptlist";
    }

    @RequestMapping(value = {"/addDept"})
    public String addDept(Dept dept){
        int pageNum_D = deptService.saveDept(dept);
        return "redirect:/dept/deptlist?pageNum_D=" + pageNum_D;
    }

    @RequestMapping(value = {"/addDeptView"})
    public String AddDeptView(){
        return "addDept";
    }

    @RequestMapping(value = {"/deleteDeptById"})
    public String deleteDeptById(int[] id,HttpSession httpSession){
        deptService.deleteDeptById(id);
        Integer pageNum = (Integer) httpSession.getAttribute("deptPageNum");
        return "redirect:/dept/deptlist?pageNum=" + pageNum;
    }

    @RequestMapping(value = {"/exportdata"})
    public String exportData(HttpServletRequest request, HttpServletResponse response) throws IOException {
        List<Dept> list = deptService.listDept();
        //创建sheet工作单元
        HSSFWorkbook workbook = new HSSFWorkbook();
        Sheet sheet = workbook.createSheet("dept_list");
        //
        Row rowfirst = sheet.createRow(0);
        //
        rowfirst.createCell(0).setCellValue("部门编号");
        rowfirst.createCell(1).setCellValue("部门名称");
        rowfirst.createCell(2).setCellValue("工作地点");

        //
        for (Dept dept : list) {
            Row row = sheet.createRow(sheet.getLastRowNum() + 1);
            row.createCell(0).setCellValue(dept.getId());
            row.createCell(1).setCellValue(dept.getDname());
            row.createCell(2).setCellValue(dept.getLocation());
        }

        String filename = "部门数据.xls";

        String useragent = request.getHeader("User-Agent");
        if (useragent.contains("Firefox")) { // 火狐浏览器
            filename = "=?UTF-8?B?" + new BASE64Encoder().encode(filename.getBytes("utf-8")) + "?=";
        } else { // IE及其他浏览器
            filename = URLEncoder.encode(filename, "utf-8");
            filename = filename.replace("+", " ");//url编码把空格变成+
        }

        //输出流
        ServletOutputStream out = response.getOutputStream();
        response.setContentType("application/vnd-ms.excel");
        response.setHeader("Content-Disposition","attachment;filename="+filename);

        //
        workbook.write(out);
        return null;
    }

    //importdata
    @RequestMapping(value = {"/importdept"})
    public String importDept(MultipartFile file) throws Exception {
        InputStream in = file.getInputStream();
        //1
        Workbook workbook = WorkbookFactory.create(in);
        //2
        Sheet sheet = workbook.getSheetAt(0);
        //3
        for (Row row : sheet) {
            int rowNum = row.getRowNum();
            if(rowNum == 0){
                continue;
            }
            String dname = row.getCell(0).getStringCellValue();
            String location = row.getCell(1).getStringCellValue();

            Dept dept = new Dept();
            dept.setDname(dname);
            dept.setLocation(location);

            deptService.saveDept(dept);
        }
        return "redirect:/dept/deptlist";
    }



}
