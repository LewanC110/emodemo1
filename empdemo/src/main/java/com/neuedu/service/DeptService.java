package com.neuedu.service;

import com.neuedu.entity.Dept;

import java.util.List;


public interface DeptService {
    /**
     * 查询所有dept
     * @return
     */
    List<Dept> listDept();

    int saveDept( Dept dept);

    /**
     * 根据id数组删除dept
     * @param ids
     * @return 影响行数
     */
    int deleteDeptById(int[] ids);

}
