package com.neuedu.mapper;

import com.neuedu.entity.Dept;
import com.neuedu.entity.Emp;

import java.util.List;

public interface DeptMapper {

    /**
     * 查询所有dept
     * @return
     */
    List<Dept> listDept();

}
